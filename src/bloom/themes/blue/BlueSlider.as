package bloom.themes.blue {

import bloom.core.ComponentConstants;
import bloom.core.ScaleBitmap;
import bloom.components.style.brush.BMPBrush;
import bloom.components.style.brush.ColorBrush;
import bloom.components.style.components.controls.ButtonBaseStyle;
import bloom.components.style.components.controls.SliderStyle;
import bloom.utils.ColorUtils;

import flash.geom.Rectangle;

/**
 * DarkSlider
 */
public class BlueSlider extends SliderStyle {

	private var _background:Vector.<uint> = new Vector.<uint> (2,true);
	private var _sliderButtonBitmaps:Vector.<ScaleBitmap> = new Vector.<ScaleBitmap> (4,true);

	[Embed(source="assets/slider_normal.png")]
	protected static var bm0:Class;

	[Embed(source="assets/slider_over.png")]
	protected static var bm1:Class;

	[Embed(source="assets/slider_down.png")]
	protected static var bm2:Class;

	[Embed(source="assets/button_disabled.png")]
	protected static var bm3:Class;

	public function BlueSlider () {
		_background[ComponentConstants.ACTIVE] = ColorUtils.GRAY;
		_background[ComponentConstants.DISABLED] = ColorUtils.LIGHT_GRAY;
		background = new ColorBrush (_background);

		defaultWidth = 40;
		defaultHeight = 40;

		var normal:ScaleBitmap = new ScaleBitmap (new bm0 ().bitmapData);
		normal.scale9Grid = new Rectangle (7,7,2,2);

		var over:ScaleBitmap = new ScaleBitmap (new bm1 ().bitmapData);
		over.scale9Grid = new Rectangle (7,7,2,2);

		var down:ScaleBitmap = new ScaleBitmap (new bm2 ().bitmapData);
		down.scale9Grid = new Rectangle (7,7,2,2);

		var disabled:ScaleBitmap = new ScaleBitmap (new bm3 ().bitmapData);
		disabled.scale9Grid = new Rectangle (15,15,70,14);
		disabled.alpha = .2;

		_sliderButtonBitmaps[ComponentConstants.ACTIVE] = normal;
		_sliderButtonBitmaps[ComponentConstants.OVER] = over;
		_sliderButtonBitmaps[ComponentConstants.ACTIVATED] = down;
		_sliderButtonBitmaps[ComponentConstants.DISABLED] = disabled;
		var _backgroundBrush = new BMPBrush (_sliderButtonBitmaps);

		var sliderButton:ButtonBaseStyle = new ButtonBaseStyle ();
		sliderButton.background = _backgroundBrush;

		button = sliderButton;

	}

	///////////////////////////////////
	// toString
	///////////////////////////////////

	override public function toString ():String {
		return "[bloom.styles.DarkSlider]";
	}

}

}
