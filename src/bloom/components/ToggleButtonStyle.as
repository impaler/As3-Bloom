package bloom.components 
{
	import bloom.core.ScaleBitmap;
	
	/**
	 * ToggleButtonStyle
	 */
	public class ToggleButtonStyle implements IStyle {
		
		public var title_normal:TextStyle;
		public var title_active:TextStyle;
		
		public var normal:ScaleBitmap;
		public var active:ScaleBitmap;
		
		public function ToggleButtonStyle() {
			
		}
		
		///////////////////////////////////
		// toString
		///////////////////////////////////
		
		public function toString():String {
			return "[bloom.styles.ToggleButtonStyle]";
		}
	}

}