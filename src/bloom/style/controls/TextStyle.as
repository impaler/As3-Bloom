package bloom.style.controls {

import bloom.core.IStyle;
import bloom.style.brush.Brush;

/**
 * TextStyle
 */
public class TextStyle implements IStyle {

	public var textStyleBrush:Brush;

	///////////////////////////////////
	// toString
	///////////////////////////////////

	public function toString ():String {
		return "[bloom.styles.TextStyle]";
	}

	public function dispose (gc:Boolean = false):void {
		textStyleBrush.dispose ();
		textStyleBrush = null;
	}

}

}
