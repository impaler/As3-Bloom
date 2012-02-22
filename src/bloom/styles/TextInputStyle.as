package bloom.styles 
{
	import bloom.core.ScaleBitmap;
	
	/**
	 * TextInputStyle
	 */
	public class TextInputStyle implements IStyle {
		
		public var text_normal:TextStyle;
		public var text_active:TextStyle;
		
		public var normal:ScaleBitmap;
		public var active:ScaleBitmap;
		
		public function TextInputStyle() {
			
		}
		
		///////////////////////////////////
		// toString
		///////////////////////////////////
		
		public function toString():String {
			return "[bloom.styles.TextInputStyle]";
		}
	}

}