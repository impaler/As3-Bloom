package bloom.themes.black {

import bloom.brush.ColorBrush;
import bloom.controls.ButtonBaseStyle;
import bloom.core.StateConstants;
import bloom.utils.ColorUtils;

/**
 * BlueButtonBase
 */
public class BlackButtonBase extends ButtonBaseStyle {

	private var _scaleBitmaps:Vector.<uint> = new Vector.<uint> (4,true);

	public function BlackButtonBase () {
		_scaleBitmaps[StateConstants.ACTIVE] = ColorUtils.BLACK;
		_scaleBitmaps[StateConstants.OVER] = ColorUtils.DARK_GRAY;
		_scaleBitmaps[StateConstants.ACTIVATED] = ColorUtils.RED;
		_scaleBitmaps[StateConstants.DISABLED] = ColorUtils.LIGHT_GRAY;
		background = new ColorBrush (_scaleBitmaps);

		defaultWidth = 300;
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
		return "[bloom.styles.BlueButtonBase]";
	}

}

}
