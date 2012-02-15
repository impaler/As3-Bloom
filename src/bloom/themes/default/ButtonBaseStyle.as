package bloom.themes.default 
{
	import bloom.core.ScaleBitmap;
	import bloom.core.StyleBase;
	
	/**
	 * ButtonBaseStyle
	 */
	public class ButtonBaseStyle extends StyleBase {
		
		public var normal:ScaleBitmap;
		public var over:ScaleBitmap;
		public var down:ScaleBitmap;
		
		public function ButtonBaseStyle() {
			
		}
		
		///////////////////////////////////
		// toString
		///////////////////////////////////
		
		override public function toString():String {
			return "[bloom.themes.default.ButtonBaseStyle]";
		}
		
	}

}