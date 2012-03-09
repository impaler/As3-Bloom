package bloom.themes.blue 
{
	import bloom.components.TextStyle;
	
	/**
	 * BlueLabel
	 */
	public class BlueLabel extends TextStyle {
		
		public function BlueLabel() {
			textFormat.font = "Verdana";
			textFormat.size = 12;
			textFormat.color = 0x000000;
		}
		
		///////////////////////////////////
		// toString
		///////////////////////////////////
		
		override public function toString():String {
			return "[bloom.style.blue.BlueLabel]";
		}
		
	}

}