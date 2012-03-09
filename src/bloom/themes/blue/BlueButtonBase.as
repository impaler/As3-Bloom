package bloom.themes.blue {

import bloom.brush.BMPBrush;
import bloom.controls.ButtonBaseStyle;
import bloom.core.ScaleBitmap;
import bloom.core.StateConstants;

import flash.geom.Rectangle;

/**
 * BlueButtonBase
 */
public class BlueButtonBase extends ButtonBaseStyle {

	[Embed(source="assets/button_normal.png")]
	private static var bm0:Class;

	[Embed(source="assets/button_over.png")]
	private static var bm1:Class;

	[Embed(source="assets/button_down.png")]
	private static var bm2:Class;

	private var _scaleBitmaps:Vector.<ScaleBitmap> = new Vector.<ScaleBitmap> (3,true);

	public function BlueButtonBase () {

		var normal:ScaleBitmap = new ScaleBitmap (new bm0 ().bitmapData);
		normal.scale9Grid = new Rectangle (15,15,70,14);

		var over:ScaleBitmap = new ScaleBitmap (new bm1 ().bitmapData);
		over.scale9Grid = new Rectangle (15,15,70,14);

		var down:ScaleBitmap = new ScaleBitmap (new bm2 ().bitmapData);
		down.scale9Grid = new Rectangle (15,15,70,14);

		_scaleBitmaps[StateConstants.NORMAL] = normal;
		_scaleBitmaps[StateConstants.OVER] = over;
		_scaleBitmaps[StateConstants.DOWN] = down;
		background = new BMPBrush (_scaleBitmaps);

	}

	///////////////////////////////////
	// Dispose
	///////////////////////////////////

	override public function dispose (gc:Boolean = false):void {
		for each(var bitmap:ScaleBitmap in _scaleBitmaps) {
			bitmap.dispose ();
			bitmap = null;
		}
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
