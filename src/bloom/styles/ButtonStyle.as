package bloom.styles 
{
	/**
	 * ButtonStyle
	 */
	public class ButtonStyle extends ButtonBaseStyle {
		
		public var title_normal:TextStyle;
		public var title_over:TextStyle;
		public var title_down:TextStyle;
		
		public function ButtonStyle() {
			
		}
		
		///////////////////////////////////
		// toString
		///////////////////////////////////
		
		override public function toString():String {
			return "[bloom.style.ButtonStyle]";
		}
	}

}