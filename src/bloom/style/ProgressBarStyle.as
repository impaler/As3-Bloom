package bloom.style 
{
	import bloom.core.IStyleBase;
	import bloom.core.ScaleBitmap;
	
	/**
	 * ProgressBarStyle
	 */
	public class ProgressBarStyle implements IStyleBase {

		public var bg:ScaleBitmap;
		public var bar:ScaleBitmap;

		
		///////////////////////////////////
		// toString
		///////////////////////////////////
		
		public function toString():String {
			return "[bloom.style.default.ProgressBarStyle]";
		}
		
	}

}