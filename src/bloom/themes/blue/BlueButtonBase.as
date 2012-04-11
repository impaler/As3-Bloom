package bloom.themes.blue {

import bloom.core.ComponentConstants;
import bloom.core.ScaleBitmap;
import bloom.style.brush.BMPScale9Brush;
import bloom.style.components.controls.ButtonBaseStyle;

import flash.geom.Rectangle;

/**
 * BlueButtonBase
 */
public class BlueButtonBase extends ButtonBaseStyle {

	[Embed(source="assets/button_active.png")]
	protected static var bm0:Class;

	[Embed(source="assets/button_over.png")]
	protected static var bm1:Class;

	[Embed(source="assets/button_down.png")]
	protected static var bm2:Class;

	[Embed(source="assets/button_disabled.png")]
	protected static var bm3:Class;

	private var _scaleBitmaps:Vector.<ScaleBitmap> = new Vector.<ScaleBitmap> (4,true);

	public function BlueButtonBase () {

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
		background = new BMPScale9Brush (_scaleBitmaps);

		defaultWidth = 100;
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
