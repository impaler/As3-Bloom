package bloom.themes.blue {

import bloom.core.ComponentConstants;
import bloom.style.brush.ColorBrush;
import bloom.style.components.controls.ButtonStyle;
import bloom.utils.ColorUtils;

/**
 * BlueCheckBoxButton
 */
public class BlueCheckBoxButton extends ButtonStyle {

	public function BlueCheckBoxButton () {

		var backgroundColors:Vector.<uint> = new Vector.<uint> (4,true);
		backgroundColors[ComponentConstants.ACTIVE] = ColorUtils.BLACK;
		backgroundColors[ComponentConstants.OVER] = 0x303030;
		backgroundColors[ComponentConstants.ACTIVATED] = ColorUtils.RED;
		backgroundColors[ComponentConstants.DISABLED] = ColorUtils.LIGHT_GRAY;
		background = new ColorBrush (backgroundColors);

		var textBrush:BlueLabel = new BlueLabel ();
		buttonText = textBrush.textStyleBrush;

		defaultWidth = 120;
		defaultHeight = 40;
	}

	///////////////////////////////////
	// toString
	///////////////////////////////////

	override public function toString ():String {
		return "[bloom.styles.BlueCheckBoxButton]";
	}

}

}
