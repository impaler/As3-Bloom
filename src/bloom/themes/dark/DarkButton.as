package bloom.themes.dark {

import bloom.core.ComponentConstants;
import bloom.style.brush.ColorBrush;
import bloom.style.brush.TextBrush;
import bloom.style.controls.ButtonStyle;
import bloom.style.controls.TextStyle;
import bloom.utils.ColorUtils;

/**
 * DarkButton
 */
public class DarkButton extends ButtonStyle {

	private var _scaleBitmaps:Vector.<uint> = new Vector.<uint> (4,true);

	public function DarkButton () {

		_scaleBitmaps[ComponentConstants.ACTIVE] = ColorUtils.BLACK;
		_scaleBitmaps[ComponentConstants.OVER] = 0x303030;
		_scaleBitmaps[ComponentConstants.ACTIVATED] = ColorUtils.RED;
		_scaleBitmaps[ComponentConstants.DISABLED] = ColorUtils.LIGHT_GRAY;
		background = new ColorBrush (_scaleBitmaps);

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
		title_disabled.textFormat.color = 0x000000;
		title_disabled.textFormat.bold = true;

		var data:Vector.<TextStyle> = new Vector.<TextStyle> (4,true);
		data[ComponentConstants.ACTIVE] = title_normal;
		data[ComponentConstants.OVER] = title_over;
		data[ComponentConstants.ACTIVATED] = title_down;
		data[ComponentConstants.DISABLED] = title_disabled;
		buttonText = new TextBrush (data);

		defaultWidth = 300;
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
		return "[bloom.styles.DarkButton]";
	}

}

}
