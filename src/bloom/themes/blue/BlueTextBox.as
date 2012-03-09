package bloom.themes.blue {

import bloom.controls.ButtonBaseStyle;
import bloom.controls.SliderStyle;
import bloom.controls.TextBoxStyle;
import bloom.controls.TextStyle;
import bloom.core.ScaleBitmap;

import flash.geom.Rectangle;

/**
 * BlueTextBox
 */
public class BlueTextBox extends TextBoxStyle {

	[Embed(source="assets/text_normal.png")]
	private static var bm0:Class;

	[Embed(source="assets/text_active.png")]
	private static var bm1:Class;

	[Embed(source="assets/textbox.png")]
	private static var bm2:Class;

	[Embed(source="assets/textbox_normal.png")]
	private static var bm3:Class;

	[Embed(source="assets/textbox_over.png")]
	private static var bm4:Class;

	[Embed(source="assets/textbox_down.png")]
	private static var bm5:Class;

	public function BlueTextBox () {
		text_normal = new TextStyle ();
		text_normal.textFormat.font = "Verdana";
		text_normal.textFormat.size = 12;
		text_normal.textFormat.color = 0x666666;

		text_active = new TextStyle ();
		text_active.textFormat.font = "Verdana";
		text_active.textFormat.size = 12;
		text_active.textFormat.color = 0x000000;

		normal = new ScaleBitmap (new bm0 ().bitmapData);
		normal.scale9Grid = new Rectangle (13,15,51,12);
		active = new ScaleBitmap (new bm1 ().bitmapData);
		active.scale9Grid = new Rectangle (13,15,51,12);

		scrollBar = new SliderStyle ();
		scrollBar.background = new ScaleBitmap (new bm2 ().bitmapData);
		scrollBar.background.scale9Grid = new Rectangle (7,7,2,2);

		scrollBar.button = new ButtonBaseStyle ();
		scrollBar.button.normal = new ScaleBitmap (new bm3 ().bitmapData);
		scrollBar.button.normal.scale9Grid = new Rectangle (7,7,2,2);
		scrollBar.button.over = new ScaleBitmap (new bm4 ().bitmapData);
		scrollBar.button.over.scale9Grid = new Rectangle (7,7,2,2);
		scrollBar.button.down = new ScaleBitmap (new bm5 ().bitmapData);
		scrollBar.button.down.scale9Grid = new Rectangle (7,7,2,2);
	}

	///////////////////////////////////
	// toString
	///////////////////////////////////

	override public function toString ():String {
		return "[bloom.themes.blue.BlueTextBox]";
	}
}

}
