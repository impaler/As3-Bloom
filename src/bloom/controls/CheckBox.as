package bloom.controls {

import bloom.core.Component;
import bloom.core.OmniCore;

import flash.display.BitmapData;
import flash.display.DisplayObjectContainer;
import flash.events.Event;
import flash.events.MouseEvent;

import org.osflash.signals.Signal;
import org.osflash.signals.natives.NativeSignal;

/**
 * CheckBox
 */
public class CheckBox extends Component {

	protected var _mouseClick:NativeSignal;
	protected var _valueChanged:Signal;

	protected var _value:Boolean;
	protected var _title:Label;

	protected var background:BitmapData;

	public function CheckBox (p:DisplayObjectContainer = null,title:String = "",value:Boolean = false) {
		super (p);

		tabChildren = tabEnabled = false;
		buttonMode = true;

		_value = value;

		_title = new Label (this,title);
		_title.onTextChanged.add (onTitleChanged);

		_mouseClick = new NativeSignal (this,MouseEvent.CLICK,MouseEvent);
		_mouseClick.add (onMouseClick);

		_valueChanged = new Signal (CheckBox);

		_style = OmniCore.defaultTheme.checkBox;
		size (100,20);
	}

	protected function onTitleChanged (e:Event):void {
		_title.move (_height + _title.margin.left,(_height - _title.height) / 2);
	}

	override public function dispose (gc:Boolean = false):void {
		super.dispose (gc);
		if (background) background.dispose ();
		background = null;
		removeChild (_title);
		_title.dispose (false);
		_title = null;
		_mouseClick.removeAll ();
		_mouseClick = null;
		_valueChanged.removeAll ();
		_valueChanged = null;
	}

	override protected function onThemeChanged ():void {
		style = OmniCore.defaultTheme.checkBox;
	}

	override protected function draw (e:Event = null):void {
		if (! _changed) return;
		_changed = false;

		var style:CheckBoxStyle = _style as CheckBoxStyle;
		if (background) background.dispose ();

		graphics.clear ();
		if (_value) {
			_title.style = style.title_checked;
			style.checked.setSize (_height,_height);
			background = style.checked.bitmapData.clone ();
		} else {
			_title.style = style.title_normal;
			style.normal.setSize (_height,_height);
			background = style.normal.bitmapData.clone ();
		}
		graphics.beginBitmapFill (background);
		graphics.drawRect (0,0,_height,_height);
		graphics.endFill ();

		_title.move (_height + _title.margin.left,(_height - _title.height) / 2);
	}

	private function onMouseClick (e:MouseEvent):void {
		value = ! _value;
	}

	///////////////////////////////////
	// getter/setters
	///////////////////////////////////

	public function get mouseClick ():NativeSignal {
		return _mouseClick;
	}

	public function get valueChanged ():Signal {
		return _valueChanged;
	}

	public function get title ():Label {
		return _title;
	}

	public function get value ():Boolean {
		return _value;
	}

	public function set value (value:Boolean):void {
		if (_value != value) {
			_value = value;
			_valueChanged.dispatch (this);
			_changed = true;
			invalidate ();
		}
	}

	///////////////////////////////////
	// toString
	///////////////////////////////////

	public override function toString ():String {
		return "[bloom.components.CheckBox]";
	}
}

}
