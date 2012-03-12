package bloom.themes.darkBasic {

import bloom.core.ComponentConstants;
import bloom.style.brush.TextBrush;
import bloom.style.controls.TextStyle;
import bloom.utils.ColorUtils;

import flash.text.TextFormat;

public class DarkLabel extends TextStyle {

	public function DarkLabel () {

		var title_normal:TextFormat = new TextFormat ();
		title_normal.font = "Verdana";
		title_normal.size = 18;
		title_normal.color = ColorUtils.WHITE;
		title_normal.bold = false;

		var title_over:TextFormat = new TextFormat ();
		title_over.font = "Verdana";
		title_over.size = 15;
		title_over.color = ColorUtils.RED;
		title_over.bold = true;

		var title_down:TextFormat = new TextFormat ();
		title_down.font = "Verdana";
		title_down.size = 8;
		title_down.color = 0x000000;
		title_down.bold = true;

		var title_disabled:TextFormat = new TextFormat ();
		title_disabled.font = "Verdana";
		title_disabled.size = 8;
		title_disabled.color = ColorUtils.LIGHT_GRAY;
		title_disabled.bold = true;

		var data:Vector.<TextFormat> = new Vector.<TextFormat> (4,true);
		data[ComponentConstants.ACTIVE] = title_normal;
		data[ComponentConstants.OVER] = title_over;
		data[ComponentConstants.ACTIVATED] = title_down;
		data[ComponentConstants.DISABLED] = title_disabled;

		textStyleBrush = new TextBrush (data);

	}

	///////////////////////////////////
	// toString
	///////////////////////////////////

	override public function toString ():String {
		return "[bloom.themes.DarkLabel]";
	}
}
}
