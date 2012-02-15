package bloom.themes.default 
{
	import bloom.core.StyleBase;
	
	/**
	 * ButtonStyle
	 */
	public class ButtonStyle extends ButtonBaseStyle {
		
		public var title_normal:LabelStyle;
		public var title_over:LabelStyle;
		public var title_down:LabelStyle;
		
		public function ButtonStyle() {
			
		}
		
		///////////////////////////////////
		// toString
		///////////////////////////////////
		
		override public function toString():String {
			return "[bloom.themes.default.ButtonStyle]";
		}
		
	}

}