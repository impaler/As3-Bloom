package bloom.themes.blue {

import bloom.core.ComponentConstants;
import bloom.style.brush.ColorBrush;
import bloom.style.components.containers.ContainerStyle;
import bloom.utils.ColorUtils;

/**
 * BlueContainer
 */
public class BlueContainer extends ContainerStyle {

	private var _backgroundColors:Vector.<uint> = new Vector.<uint> (2,true);

	public function BlueContainer () {
		_backgroundColors[ComponentConstants.ACTIVE] = ColorUtils.BLACK;
		_backgroundColors[ComponentConstants.DISABLED] = ColorUtils.LIGHT_GRAY;
		background = new ColorBrush (_backgroundColors);

		defaultWidth = 300;
		defaultHeight = 500;

		contentPadding = 10;
	}

	///////////////////////////////////
	// Dispose
	///////////////////////////////////

	override public function dispose (gc:Boolean = false):void {
		_backgroundColors = null;
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
