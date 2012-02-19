package bloom.brush {

import bloom.core.TextBase;
import bloom.core.TextStyle;

public class TextBrush extends Brush {

	public var textStyle:Vector.<TextStyle>;

	public function TextBrush ( bitmap:Vector.<TextStyle> = null ) {
		this.textStyle = bitmap;
	}

	override public function update ( state:int , value:* , args:Object = null ):void {
		var style:TextStyle = textStyle[state];
		
		var _text:TextBase = value as TextBase;
		_text.style = style;
	}

	///////////////////////////////////
	// toString
	///////////////////////////////////

	override public function toString ():String {
		return "[bloom.brushes.BMPBrush]";
	}
	
	override public function destroy ():void {
		textStyle = null;
	}

}

}