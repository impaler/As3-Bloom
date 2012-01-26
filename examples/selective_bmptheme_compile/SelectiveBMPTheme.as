/**
 * Date: 26/01/12
 * Time: 12:59 PM
 */
package selective_bmptheme_compile {

import bloom.themes.ITheme;
import bloom.themes.bmptheme.ButtonBMPTheme;
import bloom.themes.bmptheme.NumericStepperBMPTheme;

public class SelectiveBMPTheme implements ITheme {

	public function initialize ():void {
		new ButtonBMPTheme ().initialize ();
		new NumericStepperBMPTheme ().initialize ();
	}

}
}
