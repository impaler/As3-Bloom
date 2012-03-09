package bloom.themes.blue {

import bloom.containers.ScrollContainerStyle;
import bloom.controls.ButtonBaseStyle;
import bloom.controls.SliderStyle;
import bloom.core.ScaleBitmap;

import flash.geom.Rectangle;

/**
 * BlueScrollContainer
 */
public class BlueScrollContainer extends ScrollContainerStyle {

	[Embed(source="assets/sc.png")]
	private static var bm0:Class;

	[Embed(source="assets/sc_scrollbar.png")]
	private static var bm1:Class;

	[Embed(source="assets/sc_scrollbar_normal.png")]
	private static var bm2:Class;

	[Embed(source="assets/sc_scrollbar_over.png")]
	private static var bm3:Class;

	[Embed(source="assets/sc_scrollbar_down.png")]
	private static var bm4:Class;

	public function BlueScrollContainer () {
		background = new ScaleBitmap (new bm0 ().bitmapData);
		background.scale9Grid = new Rectangle (7,7,2,2);

		h_scrollBar = new SliderStyle ();
		h_scrollBar.background = new ScaleBitmap (new bm1 ().bitmapData);
		h_scrollBar.background.scale9Grid = new Rectangle (7,7,2,2);

		h_scrollBar.button = new ButtonBaseStyle ();
		h_scrollBar.button.normal = new ScaleBitmap (new bm2 ().bitmapData);
		h_scrollBar.button.normal.scale9Grid = new Rectangle (7,7,2,2);
		h_scrollBar.button.over = new ScaleBitmap (new bm3 ().bitmapData);
		h_scrollBar.button.over.scale9Grid = new Rectangle (7,7,2,2);
		h_scrollBar.button.down = new ScaleBitmap (new bm4 ().bitmapData);
		h_scrollBar.button.down.scale9Grid = new Rectangle (7,7,2,2);

		v_scrollBar = new SliderStyle ();
		v_scrollBar.background = new ScaleBitmap (new bm1 ().bitmapData);
		v_scrollBar.background.scale9Grid = new Rectangle (7,7,2,2);

		v_scrollBar.button = new ButtonBaseStyle ();
		v_scrollBar.button.normal = new ScaleBitmap (new bm2 ().bitmapData);
		v_scrollBar.button.normal.scale9Grid = new Rectangle (7,7,2,2);
		v_scrollBar.button.over = new ScaleBitmap (new bm3 ().bitmapData);
		v_scrollBar.button.over.scale9Grid = new Rectangle (7,7,2,2);
		v_scrollBar.button.down = new ScaleBitmap (new bm4 ().bitmapData);
		v_scrollBar.button.down.scale9Grid = new Rectangle (7,7,2,2);
	}

	///////////////////////////////////
	// toString
	///////////////////////////////////

	override public function toString ():String {
		return "[bloom.themes.blue.BlueScrollContainer]";
	}
}

}
