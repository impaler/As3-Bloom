/**
 * Date: 12/02/12
 * Time: 5:04 PM
 */
package bloom.theme.defaultTheme {

import bloom.brushes.ColorBrush;
import bloom.core.BloomConstants;
import bloom.core.ButtonBaseStyle;

public class DefaultButtonBaseStyle extends ButtonBaseStyle {
	public function DefaultButtonBaseStyle () {

		defaultWidth = 130;
		defaultHeight = 36;

		var data:Vector.<uint> = new Vector.<uint> ( 3 , true );
		data[BloomConstants.NORM] = DefaultTheme.NORMCOLOR;
		data[BloomConstants.OVER] = DefaultTheme.OVERCOLOR;
		data[BloomConstants.DOWN] = DefaultTheme.DOWNCOLOR;
		backgroundBrush = new ColorBrush ( data );

	}
	
	override public function toString ():String {
		return "[bloom.theme.defaultTheme.DefaultButtonBaseStyle]";
	}
	
}
}
