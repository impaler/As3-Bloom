package bloom.themes.dark {

import bloom.core.ComponentConstants;
import bloom.style.brush.ColorBrush;
import bloom.style.controls.ButtonBaseStyle;
import bloom.utils.ColorUtils;

/**
 * DarkButtonBase
 */
public class DarkButtonBase extends ButtonBaseStyle {

	private var _scaleBitmaps:Vector.<uint> = new Vector.<uint> (4,true);

	public function DarkButtonBase () {
		_scaleBitmaps[ComponentConstants.ACTIVE] = ColorUtils.BLACK;
		_scaleBitmaps[ComponentConstants.OVER] = 0x303030;
		_scaleBitmaps[ComponentConstants.ACTIVATED] = ColorUtils.RED;
		_scaleBitmaps[ComponentConstants.DISABLED] = ColorUtils.LIGHT_GRAY;
		background = new ColorBrush (_scaleBitmaps);

		defaultWidth = 40;
		defaultHeight = 40;

	}

	///////////////////////////////////
	// Dispose
	///////////////////////////////////

	override public function dispose (gc:Boolean = false):void {
		_scaleBitmaps = null;
		super.dispose (gc);
	}

	///////////////////////////////////
	// toString
	///////////////////////////////////

	override public function toString ():String {
		return "[bloom.styles.DarkButtonBase]";
	}

}

}
