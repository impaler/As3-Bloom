package bloom.components.controls {

import bloom.core.OmniCore;

import flash.display.DisplayObjectContainer;

/**
 * CheckBox
 *
 * @description Provides basic CheckBox button
 *
 */
public class CheckBoxButton extends ToggleButton {

	public function CheckBoxButton (p:DisplayObjectContainer = null,title:String = "",defaultValue:Boolean = false) {
		super (p,title,defaultValue);
	}

	///////////////////////////////////
	// Base Component Methods
	///////////////////////////////////

	override protected function onStyleChanged ():void {
		_style = OmniCore.defaultTheme.toggleButtonStyle;
		super.onStyleChanged ();
	}

	override protected function createAssets ():void {
		super.createAssets ();
	}

	override protected function initDefaultStyle ():void {
		super.initDefaultStyle ();
	}

	///////////////////////////////////
	// Signal Methods
	///////////////////////////////////

	///////////////////////////////////
	// Draw Methods
	///////////////////////////////////

	///////////////////////////////////
	// getter/setters
	///////////////////////////////////

	///////////////////////////////////
	// Dispose
	///////////////////////////////////

	override public function dispose (gc:Boolean = false):void {
		super.dispose ();

	}

	///////////////////////////////////
	// toString
	///////////////////////////////////

	override public function toString ():String {
		return "[bloom.components.CheckBox]";
	}
}

}
