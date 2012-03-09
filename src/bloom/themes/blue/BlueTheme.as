package bloom.themes.blue {

import bloom.core.Theme;

/**
 * BlueTheme
 */
public class BlueTheme extends Theme {

	public function BlueTheme () {
		disabledAlpha = 0.5;
		buttonBase = BlueButtonBase;

//			_label = new BlueLabel();
//			_button = new BlueButton();
//			_buttonBase = new BlueButtonBase();
//			_checkBox = new BlueCheckBox();
//			_textInput = new BlueTextInput();
//			_numericStepper = new BlueNumericStepper();
//			_progressBar = new BlueProgressBar();
//			_slider = new BlueSlider();
//			_textBox = new BlueTextBox();
//			_toggleButton = new BlueToggleButton();
//			_container = new BlueContainer();
//			_scrollContainer = new BlueScrollContainer();
//			_window = new BlueWindow();
	}

	///////////////////////////////////
	// toString
	///////////////////////////////////

	public function toString ():String {
		return "[bloom.themes.BlueTheme]";
	}

}

}
