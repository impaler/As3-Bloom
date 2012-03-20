package bloom.themes.blue {

import bloom.core.ComponentConstants;
import bloom.style.brush.TextBrush;
import bloom.style.components.text.TextStyle;
import bloom.utils.ColorUtils;

import flash.text.TextFormat;

public class BlueLabel extends TextStyle {

	public function BlueLabel () {

		var title_normal:TextFormat = new TextFormat ();
		title_normal.font = "Verdana";
		title_normal.size = 12;
		title_normal.color = 0xffffff;
		title_normal.bold = false;

		var title_over:TextFormat = new TextFormat ();
		title_over.font = "Verdana";
		title_over.size = 12;
		title_over.color = 0xffffff;
		title_over.bold = true;

		var title_down:TextFormat = new TextFormat ();
		title_down.font = "Verdana";
		title_down.size = 12;
		title_down.color = 0x000000;
		title_down.bold = true;

		var title_disabled:TextFormat = new TextFormat ();
		title_disabled.font = "Verdana";
		title_disabled.size = 12;
		title_disabled.color = ColorUtils.LIGHT_GRAY;
		title_disabled.bold = true;

		var data:Vector.<TextFormat> = new Vector.<TextFormat> (4,true);
		data[ComponentConstants.DISABLED] = title_disabled;
		data[ComponentConstants.ACTIVE] = title_normal;
		data[ComponentConstants.OVER] = title_over;
		data[ComponentConstants.ACTIVATED] = title_down;

		textStyleBrush = new TextBrush (data);

	}

	///////////////////////////////////
	// toString
	///////////////////////////////////

	override public function toString ():String {
		return "[bloom.themes.BlueLabel]";
	}
}
}
