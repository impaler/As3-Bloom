package bloom.themes.blue {

import bloom.core.ComponentConstants;
import bloom.core.ScaleBitmap;
import bloom.style.brush.BMPScale9Brush;
import bloom.style.brush.Brush;
import bloom.style.brush.ColorBrush;
import bloom.style.components.containers.TitleBarStyle;
import bloom.style.components.containers.WindowStyle;
import bloom.style.components.controls.ButtonBaseStyle;
import bloom.utils.ColorUtils;

import flash.geom.Rectangle;

/**
 * BlueWindow
 */
public class BlueWindow extends WindowStyle {

	[Embed(source="assets/window_bg.png")]
	protected static var window_bg:Class;

	[Embed(source="assets/window_header.png")]
	protected static var window_header:Class;

	private var _headerBackground:Brush;
	private var _headerBackgroundColors:Vector.<ScaleBitmap> = new Vector.<ScaleBitmap> (2,true);
	private var _background:Vector.<ScaleBitmap> = new Vector.<ScaleBitmap> (2,true);
//	private var _backgroundColors:Vector.<uint> = new Vector.<uint> (2,true);
	private var _scalerBackground:Vector.<uint> = new Vector.<uint> (4,true);


	public function BlueWindow () {

		var active:ScaleBitmap = new ScaleBitmap (new window_bg ().bitmapData);
		active.scale9Grid = new Rectangle (30,0,140,2);

		var disabled:ScaleBitmap = new ScaleBitmap (new window_bg ().bitmapData);
		disabled.scale9Grid = new Rectangle (30,0,140,2);
		disabled.alpha = .2;

		_background[ComponentConstants.ACTIVE] = active;
		_background[ComponentConstants.DISABLED] = disabled;
		background = new BMPScale9Brush (_background);


		var active:ScaleBitmap = new ScaleBitmap (new window_header ().bitmapData);
		active.scale9Grid = new Rectangle (30,0,140,2);

		var disabled:ScaleBitmap = new ScaleBitmap (new window_header ().bitmapData);
		disabled.scale9Grid = new Rectangle (30,0,140,2);
		disabled.alpha = .2;

		_headerBackgroundColors[ComponentConstants.ACTIVE] = active;
		_headerBackgroundColors[ComponentConstants.DISABLED] = disabled;
		_headerBackground = new BMPScale9Brush (_headerBackgroundColors);
		titleBar = new TitleBarStyle();
		titleBar.background = _headerBackground;
		titleBar.defaultWidth = 300;
		titleBar.defaultHeight = 30;

		_scalerBackground[ComponentConstants.ACTIVE] = ColorUtils.DARK_GRAY;
		_scalerBackground[ComponentConstants.OVER] = ColorUtils.DARK_GRAY;
		_scalerBackground[ComponentConstants.ACTIVATED] = ColorUtils.DARK_GRAY;
		_scalerBackground[ComponentConstants.DISABLED] = ColorUtils.DARK_GRAY;
		scaler = new ButtonBaseStyle();
		scaler.background = new ColorBrush (_scalerBackground);
		scaler.defaultWidth = 30;
		scaler.defaultHeight = 30;


		defaultWidth = 300;
		defaultHeight = 500;

		headerSize = 30;
		footerSize = 30;
		scrollbarSize = 30;

		maxWidth = Number.MAX_VALUE;
		minWidth = 260;
		maxHeight = Number.MAX_VALUE;
		minHeight = 260;
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
