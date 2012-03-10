package bloom.controls {

import bloom.brush.ComponentBaseStyle;
import bloom.core.IStyle;
import bloom.core.InteractiveComponent;
import bloom.core.OmniCore;
import bloom.core.StateConstants;

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

		enableSignals();
	}

	override public function enableSignals ():void {
		mouseOver.add (onMouseOver);
		mouseDown.add (onMouseDown);
	}

	override public function disableSignals ():void {
		mouseOver.remove (onMouseOver);
		mouseDown.remove (onMouseDown);
	}

	override protected function onThemeChanged ():void {
		_style = OmniCore.defaultTheme.buttonBaseStyle as ComponentBaseStyle;
		super.onThemeChanged();
	}

	override protected function draw (e:Event = null):void {
		if (! _changed) return;
		_changed = false;
		buttonBaseStyle.background.update (_state,this,getDimensionObject);
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
		if (_state != StateConstants.ACTIVATED) {
			_state = StateConstants.ACTIVATED;
			_changed = true;
			invalidate ();
			mouseUp.add (onMouseUp);
			mouseOver.remove (onMouseOver);
		}
	}

	protected function onMouseUp (e:MouseEvent):void {
		_state = StateConstants.ACTIVE;
		_changed = true;
		invalidate ();
		mouseOver.add (onMouseOver);
		mouseOut.remove (onMouseOut);
		mouseUp.remove (onMouseUp);
	}

	protected function onMouseOut (e:MouseEvent):void {
		if (_state != StateConstants.ACTIVATED) onMouseUp (e);
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
