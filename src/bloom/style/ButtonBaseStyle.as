package bloom.style 
{

import bloom.brush.Brush;
import bloom.core.IStyleBase;

/**
	 * ButtonBaseStyle
	 */
	public class ButtonBaseStyle implements IStyleBase {
		
		public var backgroundBrush:Brush;
		
		///////////////////////////////////
		// toString
		///////////////////////////////////
		
		public function toString():String {
			return "[bloom.style.default.ButtonBaseStyle]";
		}

	}
}
