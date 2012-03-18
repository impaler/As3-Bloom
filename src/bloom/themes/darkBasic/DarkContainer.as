package bloom.themes.darkBasic {

import bloom.core.ComponentConstants;
import bloom.components.style.brush.ColorBrush;
import bloom.components.style.components.containers.ContainerStyle;
import bloom.utils.ColorUtils;

/**
 * DarkContainer
 */
public class DarkContainer extends ContainerStyle {

	private var _scaleBitmaps:Vector.<uint> = new Vector.<uint> (2,true);

	public function DarkContainer () {
		_scaleBitmaps[ComponentConstants.ACTIVE] = ColorUtils.DARK_GRAY;
		_scaleBitmaps[ComponentConstants.DISABLED] = ColorUtils.LIGHT_GRAY;
		background = new ColorBrush (_scaleBitmaps);

		defaultWidth = 300;
		defaultHeight = 360;

		contentPadding = 10;
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
		return "[bloom.styles.DarkContainer]";
	}

}

}
