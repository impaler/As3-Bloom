package bloom.components {

import bloom.core.IStyle;
import bloom.core.InteractiveComponent;
import bloom.core.StateConstants;
import bloom.core.OmniCore;
import bloom.style.BaseStyle;

import flash.display.DisplayObjectContainer;
import flash.events.Event;
import flash.events.MouseEvent;

import org.osflash.signals.natives.NativeSignal;

/**
 * ButtonBase
 */
public class ButtonBase extends InteractiveComponent {

	public function ButtonBase (p:DisplayObjectContainer = null) {
		super (p);

		buttonMode = true;
		tabEnabled = false;

		mouseOver.add (onMouseOver);
		mouseDown.add (onMouseDown);

		_style = OmniCore.defaultTheme.buttonBaseStyle as IStyle;
		size (120,30);
	}

	override protected function onThemeChanged ():void {
		style = OmniCore.defaultTheme.buttonBaseStyle;
	}

	override protected function draw (e:Event = null):void {
		if (! _changed) return;
		_changed = false;

		buttonBaseStyle.drawStyle (state,graphics,getDimensionObject);
	}

	protected function onMouseOver (e:MouseEvent):void {
		if (_state != StateConstants.OVER) {
			_state = StateConstants.OVER;
			_changed = true;
			invalidate ();
			mouseOut.add (onMouseOut);
		}
	}

	protected function onMouseDown (e:MouseEvent):void {
		if (_state != StateConstants.DOWN) {
			_state = StateConstants.DOWN;
			_changed = true;
			invalidate ();
			mouseUp.add (onMouseUp);
			mouseOver.remove (onMouseOver);
		}
	}

	protected function onMouseUp (e:MouseEvent):void {
		_state = StateConstants.NORMAL;
		_changed = true;
		invalidate ();
		mouseOver.add (onMouseOver);
		mouseOut.remove (onMouseOut);
		mouseUp.remove (onMouseUp);
	}

	protected function onMouseOut (e:MouseEvent):void {
		if (_state != StateConstants.DOWN) onMouseUp (e);
	}

	///////////////////////////////////
	// getter/setters
	///////////////////////////////////

	public function get state ():int {
		return _state;
	}

	public function set state (value:int):void {
		_state = value;
		_changed = true;
		invalidate ();
	}

	public function get mouseUp ():NativeSignal {
		return OmniCore.onStageMouseUp;
	}
	
	public function get buttonBaseStyle ():ButtonBaseStyle {
		return _style as ButtonBaseStyle;
	}

	///////////////////////////////////
	// toString
	///////////////////////////////////

	public override function toString ():String {
		return "[bloom.components.ButtonBase]";
	}

	///////////////////////////////////
	// Dispose
	///////////////////////////////////

	override public function dispose (gc:Boolean = false):void {
		mouseUp.remove (onMouseUp);
		super.dispose (gc);
	}

}

}