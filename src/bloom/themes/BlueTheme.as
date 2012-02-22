package bloom.themes 
{
	import bloom.themes.blue.*;
	
	/**
	 * BlueTheme
	 */
	public class BlueTheme extends Theme {
		
		public function BlueTheme() {
			_alpha = 0.5;
			
			_label = new BlueLabel();
			_buttonBase = new BlueButtonBase();
		}
		
		///////////////////////////////////
		// toString
		///////////////////////////////////
		
		override public function toString():String {
			return "[bloom.themes.BlueTheme]";
		}
		
	}

}