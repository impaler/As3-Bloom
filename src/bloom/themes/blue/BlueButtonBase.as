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
		disabled.alpha =.2;

		_scaleBitmaps[StateConstants.ACTIVE] = normal;
		_scaleBitmaps[StateConstants.OVER] = over;
		_scaleBitmaps[StateConstants.ACTIVATED] = down;
		_scaleBitmaps[StateConstants.DISABLED] = disabled;
		background = new BMPBrush (_scaleBitmaps);

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
