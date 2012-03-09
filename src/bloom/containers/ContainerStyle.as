package bloom.containers {

import bloom.core.ScaleBitmap;

/**
 * ContainerStyle
 */
public class ContainerStyle implements IStyle {

	public var background:ScaleBitmap;

	public function ContainerStyle () {

	}

	///////////////////////////////////
	// toString
	///////////////////////////////////

	public function toString ():String {
		return "[bloom.styles.ContainerStyle]";
	}
}

}
