package bloom.controls {

import bloom.brush.Brush;
import bloom.core.IStyle;

/**
 * ButtonBaseStyle
 */
public class ButtonBaseStyle implements IStyle {

	public var background:Brush;

	public function update (state:int,value:*,args:Object = null):void {
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
		return "[bloom.styles.ButtonBaseStyle]";
	}

}
}
