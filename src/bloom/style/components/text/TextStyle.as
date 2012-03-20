package bloom.style.components.text {

import bloom.core.IComponent;
import bloom.core.IStyle;
import bloom.style.brush.Brush;

/**
 * TextStyle
 */
public class TextStyle implements IStyle {

	public var textStyleBrush:Brush;

	public function update (value:IComponent):void {
	}

	public function dispose (gc:Boolean = false):void {
		textStyleBrush.dispose ();
		textStyleBrush = null;
	}

	///////////////////////////////////
	// toString
	///////////////////////////////////

	public function toString ():String {
		return "[bloom.styles.TextStyle]";
	}

}

}
