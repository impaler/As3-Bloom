package bloom.styles 
{
	import bloom.core.ScaleBitmap;
	
	/**
	 * SliderStyle
	 */
	public class SliderStyle implements IStyle {
		
		public var background:ScaleBitmap;
		
		public var button:ButtonBaseStyle;
		
		public function SliderStyle() {
			
		}
		
		///////////////////////////////////
		// toString
		///////////////////////////////////
		
		public function toString():String {
			return "[bloom.styles.SliderStyle]";
		}
	}

}