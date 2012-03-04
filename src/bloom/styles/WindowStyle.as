package bloom.styles 
{
	import bloom.core.ScaleBitmap;
	
	/**
	 * WindowStyle
	 */
	public class WindowStyle implements IStyle {
		
		public var background:ScaleBitmap;
		public var scaler:ScaleBitmap;
		
		public var header:ContainerStyle;
		public var footer:ContainerStyle;
		
		public function WindowStyle() {
			
		}
		
		///////////////////////////////////
		// toString
		///////////////////////////////////
		
		public function toString():String {
			return "[bloom.styles.WindowStyle]";
		}
	}

}