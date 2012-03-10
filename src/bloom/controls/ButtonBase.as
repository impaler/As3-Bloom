package bloom.controls {

import bloom.core.ComponentConstants;
import bloom.core.InteractiveComponent;
import bloom.core.OmniCore;
import bloom.core.Padding;
import bloom.style.controls.ButtonBaseStyle;

import flash.display.DisplayObjectContainer;
import flash.events.Event;
import flash.events.MouseEvent;

/**
 * ButtonBase
 */
public class ButtonBase extends InteractiveComponent {

	protected var _isDown:Boolean = false;

	public function ButtonBase (p:DisplayObjectContainer = null) {
		buttonMode = true;
		tabEnabled = false;

		super (p);

		padding = new Padding (2,2,2,2);
	}

	override public function enableSignals ():void {
		mouseOver.addOnce (onMouseOver);
		mouseDown.add (onMouseDown);
	}

	override public function disableSignals ():void {
		mouseOver.remove (onMouseOver);
		mouseDown.remove (onMouseDown);
	}

	override protected function onThemeChanged ():void {
		_style = OmniCore.defaultTheme.buttonBaseStyle;
		super.onThemeChanged ();
	}

	override protected function draw (e:Event = null):void {
		if (! _changed) return;
		_changed = false;

		buttonBaseStyle.background.update (_state,this,getDimensionObject);
	}

	public function onMouseOver (e:MouseEvent):void {
		if (_state != ComponentConstants.OVER) {
			_state = ComponentConstants.OVER;
			_changed = true;
			invalidate ();
			mouseOut.addOnce (onMouseOut);
		}
	}

	protected function onMouseDown (e:MouseEvent):void {
		if (_state != ComponentConstants.ACTIVATED) {
			_state = ComponentConstants.ACTIVATED;
			_isDown = true;
			_changed = true;
			invalidate ();
			mouseUp.addOnce (onMouseUp);
		}
	}

	protected function onMouseUp (e:MouseEvent):void {
		_state = ComponentConstants.ACTIVE;
		//check if the cursor is still over the button
		mouseOut.numListeners > 0 ? _state = ComponentConstants.OVER : _state = ComponentConstants.ACTIVE;
		_changed = true;
		_isDown = false;
		invalidate ();
		mouseOver.addOnce (onMouseOver);
	}

	public function onMouseOut (e:MouseEvent):void {
		if (_state != ComponentConstants.ACTIVATED || _state != ComponentConstants.OVER) {
			if (! _isDown) onMouseUp (e);
		}
	}

	///////////////////////////////////
	// getter/setters
	///////////////////////////////////

	public function get buttonBaseStyle ():ButtonBaseStyle {
		return _style as ButtonBaseStyle;
	}

	public function get state ():int {
		return _state;
	}

	public function set state (value:int):void {
		_state = value;
		_changed = true;
		invalidate ();
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
