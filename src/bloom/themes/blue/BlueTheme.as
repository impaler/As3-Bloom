package bloom.themes.blue {

import bloom.core.Theme;
import bloom.themes.dark.DarkLabel;

/**
 * BlueTheme
 */
public class BlueTheme extends Theme {

	public function BlueTheme () {
		disabledAlpha = 0.5;

		buttonBase = BlueButtonBase;
		button = BlueButton;
		container = BlueContainer;
		slider = BlueSlider;
		textStyle = DarkLabel;

	}

	///////////////////////////////////
	// toString
	///////////////////////////////////

	public function toString ():String {
		return "[bloom.themes.BlueTheme]";
	}

}

}
