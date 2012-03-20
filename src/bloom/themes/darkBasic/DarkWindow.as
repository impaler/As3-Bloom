package bloom.themes.darkBasic {

import bloom.style.brush.Brush;
import bloom.style.components.containers.TitleBarStyle;
import bloom.core.ComponentConstants;
import bloom.style.brush.ColorBrush;
import bloom.style.components.containers.WindowStyle;
import bloom.utils.ColorUtils;

/**
 * BlueWindow
 */
public class DarkWindow extends WindowStyle {

	private var _backgroundColors:Vector.<uint> = new Vector.<uint> (2,true);
	private var _headerBackgroundColors:Vector.<uint> = new Vector.<uint> (2,true);
	private var _headerBackground:Brush;

	public function DarkWindow () {
		_backgroundColors[ComponentConstants.ACTIVE] = ColorUtils.BLACK;
		_backgroundColors[ComponentConstants.DISABLED] = ColorUtils.LIGHT_GRAY;
		background = new ColorBrush (_backgroundColors);

		defaultWidth = 300;
		defaultHeight = 500;

		headerSize = 30;
		footerSize = 30;
		scrollbarSize = 30;

		maxWidth = Number.MAX_VALUE;
		minWidth = 100;
		maxHeight = Number.MAX_VALUE;
		minHeight = 100;

		_headerBackgroundColors[ComponentConstants.ACTIVE] = ColorUtils.DARK_GRAY;
		_headerBackgroundColors[ComponentConstants.DISABLED] = ColorUtils.LIGHT_GRAY;
		_headerBackground = new ColorBrush (_headerBackgroundColors);
		titleBar = new TitleBarStyle();
		titleBar.background = _headerBackground;
		titleBar.defaultWidth = 300;
		titleBar.defaultHeight = 30;

	}

	///////////////////////////////////
	// Dispose
	///////////////////////////////////

	override public function dispose (gc:Boolean = false):void {
		background = null;
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
