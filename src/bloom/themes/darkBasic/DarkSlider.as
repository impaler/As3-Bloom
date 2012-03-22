package bloom.themes.darkBasic {

import bloom.core.ComponentConstants;
import bloom.style.brush.ColorBrush;
import bloom.style.components.controls.SliderStyle;
import bloom.utils.ColorUtils;

/**
 * DarkSlider
 */
public class DarkSlider extends SliderStyle {

	private var _scaleBitmaps:Vector.<uint> = new Vector.<uint> (4,true);

	public function DarkSlider () {
		_scaleBitmaps[ComponentConstants.ACTIVE] = ColorUtils.GRAY;
		_scaleBitmaps[ComponentConstants.OVER] = 0x303030;
		_scaleBitmaps[ComponentConstants.ACTIVATED] = ColorUtils.RED;
		_scaleBitmaps[ComponentConstants.DISABLED] = ColorUtils.LIGHT_GRAY;
		background = new ColorBrush (_scaleBitmaps);

		defaultWidth = 40;
		defaultHeight = 40;

		button = new DarkButtonBase ();

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
		return "[bloom.styles.DarkSlider]";
	}

}

}
