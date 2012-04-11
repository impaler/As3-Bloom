package bloom.components.controls {

import bloom.core.ComponentConstants;
import bloom.core.OmniCore;

import flash.display.DisplayObjectContainer;
import flash.events.Event;
import flash.events.MouseEvent;

import org.osflash.signals.Signal;

/**
 * ToggleButton
 *
 * @description Provides basic CheckBox button
 *
 */
public class ToggleButton extends Button {

	protected var _valueChanged:Signal;
	protected var _value:Boolean;

	public function ToggleButton (p:DisplayObjectContainer = null,title:String = "",defaultValue:Boolean = false) {
		super (p,title);

		value = defaultValue;
		tabChildren = tabEnabled = false;
		buttonMode = true;
	}

	///////////////////////////////////
	// Base Component Methods
	///////////////////////////////////

	override protected function onStyleChanged ():void {
		_style = OmniCore.defaultTheme.toggleButtonStyle;

		super.onStyleChanged ();
	}

	override protected function createAssets ():void {
		_valueChanged = new Signal (Boolean);

		super.createAssets ();
	}

	override protected function initDefaultStyle ():void {
		super.initDefaultStyle ();
	}

	///////////////////////////////////
	// Signal Methods
	///////////////////////////////////

	override protected function onMouseDown (e:MouseEvent):void {
		_isDown = true;
		_changed = true;
		invalidate ();
		mouseUp.addOnce (onMouseUp);

		value = ! _value;
	}

	override protected function onMouseUp (e:MouseEvent):void {
		if (_state != ComponentConstants.ACTIVATED) {
			mouseOut.numListeners > 0 ? _state = ComponentConstants.OVER : _state = ComponentConstants.ACTIVE;

			_changed = true;
			_isDown = false;
			invalidate ();
		}

		mouseOver.addOnce (onMouseOver);
	}

	override public function onMouseOver (e:MouseEvent):void {
		if (_state != ComponentConstants.ACTIVATED) {
			_state = ComponentConstants.OVER;
			_changed = true;
			invalidate ();
			mouseOut.addOnce (onMouseOut);
		}
	}

	override public function onMouseOut (e:MouseEvent):void {
		if (_state != ComponentConstants.ACTIVATED) {
			_state = ComponentConstants.ACTIVE;
			_changed = true;
			invalidate ();
			if (! _isDown) onMouseUp (e);
		}

	}

	///////////////////////////////////
	// Draw Methods
	///////////////////////////////////

	override protected function draw (e:Event = null):void {
		if (! _changed) return;
		_changed = false;

		buttonStyle.update (this);

		positionTitleandIcon();
	}

	///////////////////////////////////
	// getter/setters
	///////////////////////////////////

	public function get valueChanged ():Signal {
		return _valueChanged;
	}

	public function get value ():Boolean {
		return _value;
	}

	public function set value (value:Boolean):void {
		if (_value != value) {
			_value = value;
			_value ? _state = ComponentConstants.ACTIVATED : _state = ComponentConstants.ACTIVE;

			_changed = true;
			invalidate ();
			_valueChanged.dispatch (_value);
		}
	}

	///////////////////////////////////
	// Dispose
	///////////////////////////////////

	override public function dispose (gc:Boolean = false):void {
		super.dispose ();

		_title.dispose ();
		_title = null;
		_mouseClick.removeAll ();
		_mouseClick = null;
		_valueChanged.removeAll ();
		_valueChanged = null;
	}

	///////////////////////////////////
	// toString
	///////////////////////////////////

	override public function toString ():String {
		return "[bloom.components.ToggleButton]";
	}
}

}
