package bloom.components 
{
	import bloom.core.ScaleBitmap;
	
	/**
	 * ProgressBarStyle
	 */
	public class ProgressBarStyle implements IStyle {
		
		public var background:ScaleBitmap;
		public var progress:ScaleBitmap;
		
		public function ProgressBarStyle() {
			
		}
		
		///////////////////////////////////
		// toString
		///////////////////////////////////
		
		public function toString():String {
			return "[bloom.styles.ProgressBarStyle]";
		}
	}

}