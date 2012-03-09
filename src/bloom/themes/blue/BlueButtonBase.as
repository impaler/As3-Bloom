package bloom.themes.blue {

import bloom.core.ScaleBitmap;
import bloom.core.StateConstants;
import bloom.components.ButtonBaseStyle;

import flash.display.Graphics;
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

	public function BlueButtonBase () {
		normal = new ScaleBitmap (new bm0 ().bitmapData);
		normal.scale9Grid = new Rectangle (15,15,70,14);
		stateCollection[StateConstants.NORMAL] = normal;

		over = new ScaleBitmap (new bm1 ().bitmapData);
		over.scale9Grid = new Rectangle (15,15,70,14);
		stateCollection[StateConstants.OVER] = over;

		down = new ScaleBitmap (new bm2 ().bitmapData);
		down.scale9Grid = new Rectangle (15,15,70,14);
		stateCollection[StateConstants.DOWN] = down;
	}
	

	///////////////////////////////////
	// Dispose
	///////////////////////////////////

	override public function dispose (gc:Boolean = false):void {
		normal.dispose ();
		normal = null;
		over.dispose ();
		over = null;
		down.dispose ();
		down = null;
		
		super.dispose(gc);
	}
	
	///////////////////////////////////
	// toString
	///////////////////////////////////

	override public function toString ():String {
		return "[bloom.styles.BlueButtonBase]";
	}

}

}