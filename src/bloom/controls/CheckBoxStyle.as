package bloom.controls {

import bloom.core.ScaleBitmap;

/**
 * CheckBoxStyle
 */
public class CheckBoxStyle implements IStyle {

	public var title_normal:TextStyle;
	public var title_checked:TextStyle;

	public var normal:ScaleBitmap;
	public var checked:ScaleBitmap;

	public function CheckBoxStyle () {

	}

	///////////////////////////////////
	// toString
	///////////////////////////////////

	public function toString ():String {
		return "[bloom.styles.CheckBoxStyle]";
	}
}

}
