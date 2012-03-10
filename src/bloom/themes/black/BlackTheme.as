package bloom.themes.black {

import bloom.core.Theme;
import bloom.themes.blue.*;

/**
 * BlackTheme
 */
public class BlackTheme extends Theme {

	public function BlackTheme () {
		disabledAlpha = 0.5;
		buttonBase = BlackButtonBase;
		button = BlackButton;

	}

	///////////////////////////////////
	// toString
	///////////////////////////////////

	public function toString ():String {
		return "[bloom.themes.BlackTheme]";
	}

}

}
