package bloom.components {

import bloom.style.*;

import bloom.core.ScaleBitmap;

/**
 * ButtonBaseStyle
 */
public class ButtonBaseStyle extends BaseStyle {

	public var normal:ScaleBitmap;
	public var over:ScaleBitmap;
	public var down:ScaleBitmap;

	///////////////////////////////////
	// toString
	///////////////////////////////////

	override public function toString ():String {
		return "[bloom.styles.ButtonBaseStyle]";
	}

}
}
