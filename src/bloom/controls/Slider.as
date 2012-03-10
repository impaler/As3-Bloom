package bloom.controls {

import bloom.core.Component;
import bloom.core.ComponentConstants;
import bloom.core.OmniCore;
import bloom.style.controls.SliderStyle;

import flash.display.BitmapData;
import flash.display.DisplayObjectContainer;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.Rectangle;
import flash.ui.Mouse;
import flash.ui.MouseCursor;

import org.osflash.signals.Signal;
import org.osflash.signals.natives.NativeSignal;

/**
 * Slider
 */
public class Slider extends Component {

	public var step:Number = 10;

	protected var background:BitmapData;
	protected var _button:ButtonBase;

	protected var _value:Number;
	protected var _max:Number;
	protected var _min:Number;
	protected var _rect:Rectangle;
	protected var _type:int;

	protected var _mouseWheel:NativeSignal;
	protected var _bgMouseDown:NativeSignal;

	protected var _valueChanged:Signal;
	protected var _scrolling:Signal;

	public function Slider (p:DisplayObjectContainer = null,type:int = 0,value:Number = 0,max:Number = 100,
	                        min:Number = 0) {
		tabChildren = tabEnabled = false;

		_type = type;
		_max = max;
		_min = min;
		_value = value;

		super (p);
	}

	override public function initializeDefaultStyle ():void {
		super.initializeDefaultStyle ();
		_type == ComponentConstants.VERTICALLY ? size (20,100) : size (100,20);
	}

	override public function enableSignals ():void {
		_bgMouseDown.add (clickOnBg);
		_button.mouseDown.add (onMouseDown);
		_mouseWheel.add (onMouseWheel);
	}

	override public function disableSignals ():void {
		_bgMouseDown.remove (clickOnBg);
		_button.mouseDown.remove (onMouseDown);
		_mouseWheel.remove (onMouseWheel);
	}

	override protected function createAssets ():void {
		_button = new ButtonBase (this);

		_rect = new Rectangle (0,0,0,0);

		_mouseWheel = new NativeSignal (this,MouseEvent.MOUSE_WHEEL,MouseEvent);
		_bgMouseDown = new NativeSignal (this,MouseEvent.MOUSE_DOWN,MouseEvent);

		_valueChanged = new Signal (Slider);
		_scrolling = new Signal (Slider);
	}

	override protected function onThemeChanged ():void {
		style = OmniCore.defaultTheme.sliderStyle;
		_button.style = sliderStyle.button;
		super.onThemeChanged ();
	}

	override protected function draw (e:Event = null):void {
		if (! _changed) return;
		_changed = false;

		sliderStyle.background.update (_state,this,getDimensionObject);
		_button.drawDirectly ();

		positionButton ();
	}

	protected function positionButton ():void {
		if (_type == ComponentConstants.HORIZONTALLY) {
			_button.size (_height,_height);
			_rect.width = _width - _height;
			_button.move ((_value - _min) / (_max - _min) * _rect.width,0);
		} else {
			_button.size (_width,_width);
			_rect.height = _height - _width;
			_button.move (0,_rect.height - (_value - _min) / (_max - _min) * _rect.height);
		}
	}

	protected function fixValue ():void {
		if (_max > _min) {
			if (_value > _max)_value = _max;
			if (_value < _min)_value = _min;
		} else {
			_value = _min = _max;
		}
	}

	protected function onMouseDown (e:MouseEvent):void {
		_button.state = ComponentConstants.ACTIVATED;
		_button.startDrag (false,_rect);
		OmniCore.onStageMouseMove.add (onMouseMove);
		OmniCore.onStageMouseUp.add (onMouseUp);
	}

	protected function onMouseMove (e:MouseEvent):void {
		_button.state = ComponentConstants.ACTIVATED;

		if (_type == ComponentConstants.HORIZONTALLY) {
			_value = _button.x / (_width - _height) * (_max - _min) + _min;
		} else {
			_value = (_height - _width - _button.y) / (_height - _width) * (_max - _min) + _min;
		}
		e.updateAfterEvent ();

		fixValue ();
		_scrolling.dispatch (this);
	}

	protected function onMouseUp (e:MouseEvent):void {
		_button.state = ComponentConstants.ACTIVE;
		_button.mouseOver.addOnce (_button.onMouseOver);
		Mouse.cursor = MouseCursor.AUTO;

		_button.stopDrag ();
		_valueChanged.dispatch (this);
		OmniCore.onStageMouseMove.remove (onMouseMove);
		OmniCore.onStageMouseUp.remove (onMouseUp);
	}

	protected function clickOnBg (e:MouseEvent):void {
		if (_type == ComponentConstants.HORIZONTALLY) {
			value = ((mouseX - (_height >> 1)) / (_width - _height)) * (_max - _min) + _min;
		} else {
			value = (_height - (_width >> 1) - mouseY) / (_height - _width) * (_max - _min) + _min;
		}
		_button.startDrag (false,_rect);

		_button.mouseOver.removeAll ();

		_button.state = ComponentConstants.ACTIVATED;
		Mouse.cursor = MouseCursor.BUTTON;

		OmniCore.onStageMouseMove.add (onMouseMove);
		OmniCore.onStageMouseUp.add (onMouseUp);

		e.updateAfterEvent ();
	}

	public function onMouseWheel (e:MouseEvent):void {
		value += (e.delta > 0 ? step : - step);
		e.updateAfterEvent ();
	}

	///////////////////////////////////
	// getter/setters
	///////////////////////////////////

	public function get sliderStyle ():SliderStyle {
		return _style as SliderStyle;
	}

	public function get button ():ButtonBase {
		return _button;
	}

	public function set max (value:Number):void {
		if (_max != value) {
			_max = value;
			fixValue ();
			positionButton ();
		}
	}

	public function get max ():Number {
		return _max;
	}

	public function set min (value:Number):void {
		if (_min != value) {
			_min = value;
			fixValue ();
			positionButton ();
		}
	}

	public function get min ():Number {
		return _min;
	}

	public function set value (value:Number):void {
		if (_value != value) {
			_value = value;
			fixValue ();
			positionButton ();
			_valueChanged.dispatch (this);
		}
	}

	public function get value ():Number {
		return _value;
	}

	public function set type (value:int):void {
		if (_type != value) {
			_type = value;
			_rect = new Rectangle (0,0,0,0);
			_changed = true;
			invalidate ();
		}
	}

	public function get type ():int {
		return _type;
	}

	public function get valueChanged ():Signal {
		return _valueChanged;
	}

	public function get scrolling ():Signal {
		return _scrolling;
	}

	public function get mouseWheel ():NativeSignal {
		return _mouseWheel;
	}

	///////////////////////////////////
	// Dispose
	///////////////////////////////////

	override public function dispose (gc:Boolean = false):void {
		super.dispose (gc);

		if (background) background.dispose ();
		background = null;

		OmniCore.onStageMouseMove.remove (onMouseMove);
		OmniCore.onStageMouseUp.remove (onMouseUp);

		_mouseWheel.removeAll ();
		_mouseWheel = null;

		_bgMouseDown.removeAll ();
		_bgMouseDown = null;

		_valueChanged.removeAll ();
		_valueChanged = null;

		_scrolling.removeAll ();
		_scrolling = null;

		removeChild (_button);
		_button.dispose (false);
		_button = null;

		graphics.clear ();
	}

	///////////////////////////////////
	// toString
	///////////////////////////////////

	override public function toString ():String {
		return "[bloom.components.Slider]";
	}
}

}
