package bloom.styles 
{	
	import bloom.core.ScaleBitmap;
	
	/**
	 * ButtonBaseStyle
	 */
	public class ButtonBaseStyle implements IStyle {
		
		public var normal:ScaleBitmap;
		public var over:ScaleBitmap;
		public var down:ScaleBitmap;
		
		public function ButtonBaseStyle() {
			
		}
		
		///////////////////////////////////
		// toString
		///////////////////////////////////
		
		public function toString():String {
			return "[bloom.styles.ButtonBaseStyle]";
		}

	}
}
