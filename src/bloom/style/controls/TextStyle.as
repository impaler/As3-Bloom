package bloom.style.controls {

import bloom.core.IStyle;

import flash.text.TextFormat;

/**
 * TextStyle
 */
public class TextStyle implements IStyle {

	public var textFormat:TextFormat;

	public function TextStyle (format:TextFormat = null) {
		textFormat = format ? format : new TextFormat ();
	}

	///////////////////////////////////
	// toString
	///////////////////////////////////

	public function toString ():String {
		return "[bloom.styles.TextStyle]";
	}

	public function dispose (gc:Boolean = false):void {
	}

	public function update (state:int,value:*,args:Object = null):void {
	}
}

}
