package bloom.components 
{

import bloom.style.*;
	import bloom.core.ScaleBitmap;
	import bloom.components.SliderStyle;
	
	/**
	 * ScrollContainerStyle
	 */
	public class ScrollContainerStyle implements IStyle {
		
		public var background:ScaleBitmap;
		
		public var h_scrollBar:SliderStyle;
		public var v_scrollBar:SliderStyle;
		
		public function ScrollContainerStyle() {
			
		}
		
		///////////////////////////////////
		// toString
		///////////////////////////////////
		
		public function toString():String {
			return "[bloom.styles.ScrollContainerStyle]";
		}
		
	}

}