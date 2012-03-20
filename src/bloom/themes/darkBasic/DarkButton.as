package bloom.themes.darkBasic {

import bloom.core.ComponentConstants;
import bloom.style.brush.Brush;
import bloom.style.brush.ColorBrush;
import bloom.style.components.controls.ButtonStyle;
import bloom.utils.ColorUtils;

/**
 * DarkButton
 */
public class DarkButton extends ButtonStyle {

	public function DarkButton () {

		var _scaleBitmaps:Vector.<uint> = new Vector.<uint> (4,true);
		_scaleBitmaps[ComponentConstants.ACTIVE] = ColorUtils.BLACK;
		_scaleBitmaps[ComponentConstants.OVER] = 0x303030;
		_scaleBitmaps[ComponentConstants.ACTIVATED] = ColorUtils.RED;
		_scaleBitmaps[ComponentConstants.DISABLED] = ColorUtils.LIGHT_GRAY;
		background = new ColorBrush (_scaleBitmaps);

		var textBrush:DarkLabel = new DarkLabel ();
		buttonText = textBrush.textStyleBrush as Brush;

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
