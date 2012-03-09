package bloom.controls {

import bloom.core.IStyle;
import bloom.core.ScaleBitmap;

/**
 * ColorPickerStyle
 */
public class ColorPickerStyle implements IStyle {

	public var background:ScaleBitmap;

	public function ColorPickerStyle () {

	}

	///////////////////////////////////
	// toString
	///////////////////////////////////

	public function toString ():String {
		return "[bloom.themes.styles.ColorPickerStyle]";
	}

	public function drawStyle (state:int,target:*,args:*):void {
	}
}

}
