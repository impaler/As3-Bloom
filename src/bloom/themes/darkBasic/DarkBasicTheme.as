package bloom.themes.darkBasic {

import bloom.core.Theme;

/**
 * DarkTheme
 */
public class DarkBasicTheme extends Theme {

	public function DarkBasicTheme () {
		disabledAlpha = 0.5;

		buttonBase = DarkButtonBase;
		button = DarkButton;
		container = DarkContainer;
		slider = DarkSlider;
		text = DarkLabel;
		window = DarkWindow;
		toggleButton = DarkToggleButton;
		checkBoxButton = DarkCheckBoxButton;

	}

	///////////////////////////////////
	// toString
	///////////////////////////////////

	public function toString ():String {
		return "[bloom.themes.DarkTheme]";
	}

}

}
