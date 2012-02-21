package bloom.themes.defaultTheme 
{

import bloom.style.TextStyle;

	/**
	 * LabelStyle
	 */
	public class DefaultTextStyle extends TextStyle {
		
		public function DefaultTextStyle() {
			textFormat.font = "Verdana";
			textFormat.size = 12;
			textFormat.color = 0x000000;
		}
		
		///////////////////////////////////
		// toString
		///////////////////////////////////
		
		override public function toString():String {
			return "[bloom.style.default.DefaultTextStyle]";
		}
		
	}

}