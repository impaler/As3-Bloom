package bloom.themes.blue {

import bloom.core.Theme;

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
		text = BlueLabel;
		window = BlueWindow;

	}

	///////////////////////////////////
	// toString
	///////////////////////////////////

	public function toString ():String {
		return "[bloom.themes.BlueTheme]";
	}

}

}
