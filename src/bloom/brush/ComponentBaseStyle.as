package bloom.brush {

import bloom.core.IStyle;

/**
 * ComponentBaseStyle
 */
public class ComponentBaseStyle implements IStyle {

	public var defaultWidth:Number;
	public var defaultHeight:Number;

	///////////////////////////////////
	// Dispose
	///////////////////////////////////

	public function dispose (gc:Boolean = false):void {

	}

	///////////////////////////////////
	// toString
	///////////////////////////////////

	public function toString ():String {
		return "[bloom.styles.ComponentBaseStyle]";
	}

}
}
