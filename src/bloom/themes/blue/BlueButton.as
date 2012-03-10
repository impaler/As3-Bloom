package bloom.themes.blue {

import bloom.core.ComponentConstants;
import bloom.core.ScaleBitmap;
import bloom.style.brush.BMPBrush;
import bloom.style.brush.TextBrush;
import bloom.style.controls.ButtonStyle;
import bloom.style.controls.TextStyle;
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

		var title_normal:TextStyle = new TextStyle ();
		title_normal.textFormat.font = "Verdana";
		title_normal.textFormat.size = 12;
		title_normal.textFormat.color = 0xffffff;
		title_normal.textFormat.bold = false;

		var title_over:TextStyle = new TextStyle ();
		title_over.textFormat.font = "Verdana";
		title_over.textFormat.size = 12;
		title_over.textFormat.color = 0xffffff;
		title_over.textFormat.bold = true;

		var title_down:TextStyle = new TextStyle ();
		title_down.textFormat.font = "Verdana";
		title_down.textFormat.size = 12;
		title_down.textFormat.color = 0x000000;
		title_down.textFormat.bold = true;

		var title_disabled:TextStyle = new TextStyle ();
		title_disabled.textFormat.font = "Verdana";
		title_disabled.textFormat.size = 12;
		title_disabled.textFormat.color = ColorUtils.LIGHT_GRAY;
		title_disabled.textFormat.bold = true;

		var data:Vector.<TextStyle> = new Vector.<TextStyle> (4,true);
		data[ComponentConstants.ACTIVE] = title_normal;
		data[ComponentConstants.OVER] = title_over;
		data[ComponentConstants.ACTIVATED] = title_down;
		data[ComponentConstants.DISABLED] = title_disabled;
		buttonText = new TextBrush (data);

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
