package bloom.controls {

import bloom.core.TextBase;

import flash.display.DisplayObjectContainer;
import flash.text.TextFieldAutoSize;
import flash.text.TextFieldType;

/**
 * Label
 */
public class Label extends TextBase {

	public function Label (p:DisplayObjectContainer = null,text:String = "") {
		super (p);

		type = TextFieldType.DYNAMIC;
		autoSize = TextFieldAutoSize.LEFT;

		selectable = mouseEnabled = tabEnabled = false;

		this.text = text;

//		style = OmniCore.defaultTheme.label;
	}

	override protected function onThemeChanged ():void {
//		style = OmniCore.defaultTheme.label;
	}

	///////////////////////////////////
	// Dispose
	///////////////////////////////////

	override public function dispose (gc:Boolean = false):void {
		super.dispose (gc);
	}

	///////////////////////////////////
	// toString
	///////////////////////////////////

	override public function toString ():String {
		return "[bloom.components.Label]";
	}

}

}
