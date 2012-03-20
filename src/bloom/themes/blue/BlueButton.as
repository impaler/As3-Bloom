package bloom.themes.blue {

import bloom.core.ComponentConstants;
import bloom.core.ScaleBitmap;
import bloom.style.brush.BMPBrush;
import bloom.style.brush.Brush;
import bloom.style.brush.TextBrush;
import bloom.style.components.controls.ButtonStyle;
import bloom.style.components.text.TextStyle;
import bloom.utils.ColorUtils;

import flash.geom.Rectangle;

/**
 * BlueButton
 */
public class BlueButton extends ButtonStyle {

	[Embed(source="assets/button_active.png")]
	protected static var bm0:Class;

	[Embed(source="assets/button_over.png")]
	protected static var bm1:Class;

	[Embed(source="assets/button_down.png")]
	protected static var bm2:Class;

	[Embed(source="assets/button_disabled.png")]
	protected static var bm3:Class;

	private var _scaleBitmaps:Vector.<ScaleBitmap> = new Vector.<ScaleBitmap> (4,true);

	public function BlueButton () {
		super ();

		var textBrush:BlueLabel = new BlueLabel ();
		buttonText = textBrush.textStyleBrush as Brush;

		var normal:ScaleBitmap = new ScaleBitmap (new bm0 ().bitmapData);
		normal.scale9Grid = new Rectangle (15,15,70,14);

		var over:ScaleBitmap = new ScaleBitmap (new bm1 ().bitmapData);
		over.scale9Grid = new Rectangle (15,15,70,14);

		var down:ScaleBitmap = new ScaleBitmap (new bm2 ().bitmapData);
		down.scale9Grid = new Rectangle (15,15,70,14);

		var disabled:ScaleBitmap = new ScaleBitmap (new bm3 ().bitmapData);
		disabled.scale9Grid = new Rectangle (15,15,70,14);
		disabled.alpha = .2;

		_scaleBitmaps[ComponentConstants.ACTIVE] = normal;
		_scaleBitmaps[ComponentConstants.OVER] = over;
		_scaleBitmaps[ComponentConstants.ACTIVATED] = down;
		_scaleBitmaps[ComponentConstants.DISABLED] = disabled;
		background = new BMPBrush (_scaleBitmaps);

		defaultWidth = 300;
		defaultHeight = 40;
	}

	///////////////////////////////////
	// toString
	///////////////////////////////////

	override public function toString ():String {
		return "[bloom.themes.blue.BlueButton]";
	}

}

}
