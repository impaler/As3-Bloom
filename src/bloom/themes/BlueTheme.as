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
			_button = new BlueButton();
			_buttonBase = new BlueButtonBase();
			_checkBox = new BlueCheckBox();
			_textInput = new BlueTextInput();
		}
		
		///////////////////////////////////
		// toString
		///////////////////////////////////
		
		override public function toString():String {
			return "[bloom.themes.BlueTheme]";
		}
		
	}

}