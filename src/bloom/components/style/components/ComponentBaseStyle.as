package bloom.components.style.components {

import bloom.core.IComponent;
import bloom.core.IStyle;

/**
 * ComponentBaseStyle
 */
public class ComponentBaseStyle implements IStyle {

	public var defaultWidth:Number;
	public var defaultHeight:Number;

	public function update (value:IComponent):void {
	}

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
