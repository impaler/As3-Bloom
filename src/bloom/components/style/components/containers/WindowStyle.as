package bloom.components.style.components.containers {

import bloom.components.style.components.ComponentBackgroundBaseStyle;

/**
 * WindowStyle
 */
public class WindowStyle extends ComponentBackgroundBaseStyle {

	public var headerSize:Number;
	public var footerSize:Number;
	public var scrollbarSize:Number;
	public var maxWidth:Number;
	public var minWidth:Number;
	public var maxHeight:Number;
	public var minHeight:Number;

	///////////////////////////////////
	// toString
	///////////////////////////////////

	override public function toString ():String {
		return "[bloom.styles.ContainerStyle]";
	}

}

}
