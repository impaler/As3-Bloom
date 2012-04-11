package bloom.themes.darkBasic {

import bloom.core.ScaleBitmap;
import bloom.style.brush.BMPBrush;
import bloom.style.brush.Brush;
import bloom.style.components.containers.TitleBarStyle;
import bloom.core.ComponentConstants;
import bloom.style.brush.ColorBrush;
import bloom.style.components.containers.WindowStyle;
import bloom.style.components.controls.ButtonBaseStyle;
import bloom.utils.ColorUtils;

import flash.display.Bitmap;

/**
 * DarkWindow
 */
public class DarkWindow extends WindowStyle {

	[Embed(source="assets/window_scaler.png")]
	protected static var bm_window_scaler:Class;

	[Embed(source="assets/window_scaler_red.png")]
	protected static var window_scaler_red:Class;

	private var _backgroundColors:Vector.<uint> = new Vector.<uint> (2,true);
	private var _headerBackgroundColors:Vector.<uint> = new Vector.<uint> (2,true);
	private var _headerBackground:Brush;

	private var _scalerBitmap:Vector.<Bitmap> = new Vector.<Bitmap> (4,true);

	public function DarkWindow () {
		_backgroundColors[ComponentConstants.ACTIVE] = ColorUtils.BLACK;
		_backgroundColors[ComponentConstants.DISABLED] = ColorUtils.LIGHT_GRAY;
		background = new ColorBrush (_backgroundColors);

		defaultWidth = 200;
		defaultHeight = 200;

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



		var normal:Bitmap = new bm_window_scaler ();
		var over:Bitmap = new window_scaler_red ();
		var down:Bitmap = new bm_window_scaler ();
		var disabled:Bitmap = new bm_window_scaler ();
		disabled.alpha = .2;

		_scalerBitmap[ComponentConstants.ACTIVE] = normal;
		_scalerBitmap[ComponentConstants.OVER] = over;
		_scalerBitmap[ComponentConstants.ACTIVATED] = down;
		_scalerBitmap[ComponentConstants.DISABLED] = disabled;
		scaler = new ButtonBaseStyle();
		scaler.background = new BMPBrush (_scalerBitmap);
		scaler.defaultWidth = 30;
		scaler.defaultHeight = 30;

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
