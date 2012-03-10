package bloom.themes.blue {

import bloom.core.ComponentConstants;
import bloom.style.brush.ColorBrush;
import bloom.style.containers.ContainerStyle;
import bloom.utils.ColorUtils;

/**
 * BlueContainer
 */
public class BlueContainer extends ContainerStyle {

	private var _scaleBitmaps:Vector.<uint> = new Vector.<uint> (2,true);

	public function BlueContainer () {
		_scaleBitmaps[ComponentConstants.ACTIVE] = ColorUtils.BLACK;
		_scaleBitmaps[ComponentConstants.DISABLED] = ColorUtils.LIGHT_GRAY;
		background = new ColorBrush (_scaleBitmaps);

		defaultWidth = 300;
		defaultHeight = 500;

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
		return "[bloom.styles.BlueContainer]";
	}

}

}
