package bloom.components 
{

import bloom.style.*;
	import bloom.core.ScaleBitmap;
	
	/**
	 * TextBoxStyle
	 */
	public class TextBoxStyle implements IStyle {
		
		public var text_normal:TextStyle;
		public var text_active:TextStyle;
		
		public var normal:ScaleBitmap;
		public var active:ScaleBitmap;
		
		public var scrollBar:SliderStyle;
		
		public function TextBoxStyle() {
			
		}
		
		///////////////////////////////////
		// toString
		///////////////////////////////////
		
		public function toString():String {
			return "[bloom.styles.TextBoxStyle]";
		}
	}

}