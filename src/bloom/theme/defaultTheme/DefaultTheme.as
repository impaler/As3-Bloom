/**
 * Date: 12/02/12
 * Time: 5:03 PM
 */
package bloom.theme.defaultTheme {

import bloom.control.ThemeBase;

public class DefaultTheme extends ThemeBase {
	
	public static var NORMCOLOR:uint = 0x3E3E72;
	public static var OVERCOLOR:uint = 0x5E5EAC;
	public static var DOWNCOLOR:uint = 0xF1BA44;
	
	public function DefaultTheme () {
		BUTTONBASE_STYLE = DefaultButtonBaseStyle;
		super();
	}
}
}
