package bloom.themes.default 
{
	import bloom.core.TextStyle;
	
	/**
	 * LabelStyle
	 */
	public class LabelStyle extends TextStyle {
		
		public function LabelStyle() {
			textFormat.font = "Verdana";
			textFormat.size = 12;
			textFormat.color = 0x000000;
		}
		
		///////////////////////////////////
		// toString
		///////////////////////////////////
		
		override public function toString():String {
			return "[bloom.themes.default.LabelStyle]";
		}
		
	}

}