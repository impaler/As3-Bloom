package bloom.components.style.brush {

import bloom.core.ObjectBase;
import bloom.core.TextBase;

import flash.text.TextFormat;

public class TextBrush extends Brush {

	public var textStyle:Vector.<TextFormat>;

	public function TextBrush (textFormats:Vector.<TextFormat> = null) {
		this.textStyle = textFormats;
	}

	override public function update (state:int,value:*,args:ObjectBase = null):void {
		var _text:TextBase = value as TextBase;

		var defaultTextformy:TextFormat = TextFormat (textStyle[state]);
		_text.defaultTextFormat = defaultTextformy;
		_text.setTextFormat (defaultTextformy);

	}

	///////////////////////////////////
	// toString
	///////////////////////////////////

	override public function toString ():String {
		return "[bloom.brushes.TextBrush]";
	}

	override public function dispose ():void {
		textStyle = null;
	}

}

}
