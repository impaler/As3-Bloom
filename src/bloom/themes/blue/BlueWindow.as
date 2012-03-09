package bloom.themes.blue {

import bloom.containers.ContainerStyle;
import bloom.containers.WindowStyle;
import bloom.core.ScaleBitmap;

import flash.geom.Rectangle;

/**
 * BlueWindow
 */
public class BlueWindow extends WindowStyle {

	[Embed(source="assets/window_bg.png")]
	private static var bm0:Class;

	[Embed(source="assets/window_scaler.png")]
	private static var bm1:Class;

	[Embed(source="assets/window_footer.png")]
	private static var bm2:Class;

	[Embed(source="assets/window_header.png")]
	private static var bm3:Class;

	public function BlueWindow () {
		background = new ScaleBitmap (new bm0 ().bitmapData);
		background.scale9Grid = new Rectangle (11,1,180,2);

		scaler = new ScaleBitmap (new bm1 ().bitmapData);
		scaler.scale9Grid = new Rectangle ();

		footer = new ContainerStyle ();
		footer.background = new ScaleBitmap (new bm2 ().bitmapData);
		footer.background.scale9Grid = new Rectangle (9,6,182,4);

		header = new ContainerStyle ();
		header.background = new ScaleBitmap (new bm3 ().bitmapData);
		header.background.scale9Grid = new Rectangle (9,9,182,4);
	}

	///////////////////////////////////
	// toString
	///////////////////////////////////

	override public function toString ():String {
		return "[bloom.themes.blue.BlueWindow]";
	}
}

}
