package bloom.styles 
{
	import bloom.core.ScaleBitmap;
	import bloom.styles.SliderStyle;
	
	/**
	 * ScrollContainerStyle
	 */
	public class ScrollContainerStyle extends ContainerStyle {
		
		public var h_scrollBar:SliderStyle;
		public var v_scrollBar:SliderStyle;
		
		public function ScrollContainerStyle() {
			
		}
		
		///////////////////////////////////
		// toString
		///////////////////////////////////
		
		override public function toString():String {
			return "[bloom.styles.ScrollContainerStyle]";
		}
		
	}

}