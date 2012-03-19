package bloom.themes.darkBasic {

import bloom.components.style.brush.ColorBrush;
import bloom.components.style.components.controls.ButtonStyle;
import bloom.core.ComponentConstants;
import bloom.utils.ColorUtils;

/**
 * DarkCheckBox
 */
public class DarkCheckBox extends ButtonStyle {

	public function DarkCheckBox () {

		var backgroundColors:Vector.<uint> = new Vector.<uint> (4,true);
		backgroundColors[ComponentConstants.ACTIVE] = ColorUtils.BLACK;
		backgroundColors[ComponentConstants.OVER] = 0x303030;
		backgroundColors[ComponentConstants.ACTIVATED] = ColorUtils.RED;
		backgroundColors[ComponentConstants.DISABLED] = ColorUtils.LIGHT_GRAY;
		background = new ColorBrush (backgroundColors);

		var textBrush:DarkLabel = new DarkLabel ();
		buttonText = textBrush.textStyleBrush;

		defaultWidth = 120;
		defaultHeight = 40;
	}

	///////////////////////////////////
	// toString
	///////////////////////////////////

	override public function toString ():String {
		return "[bloom.styles.DarkButton]";
	}

}

}
