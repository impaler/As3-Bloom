package bloom.themes.dark {

import bloom.core.Theme;

/**
 * DarkTheme
 */
public class DarkTheme extends Theme {

	public function DarkTheme () {
		disabledAlpha = 0.5;

		buttonBase = DarkButtonBase;
		button = DarkButton;
		container = DarkContainer;
		slider = DarkSlider;
		textStyle = DarkLabel;

	}

	///////////////////////////////////
	// toString
	///////////////////////////////////

	public function toString ():String {
		return "[bloom.themes.DarkTheme]";
	}

}

}
