package bloom.themes.black {

import bloom.brush.ColorBrush;
import bloom.brush.TextBrush;
import bloom.controls.ButtonStyle;
import bloom.controls.TextStyle;
import bloom.core.StateConstants;
import bloom.utils.ColorUtils;

/**
 * BlackButton
 */
public class BlackButton extends ButtonStyle {

	private var _scaleBitmaps:Vector.<uint> = new Vector.<uint> (4,true);

	public function BlackButton () {

		_scaleBitmaps[StateConstants.ACTIVE] = ColorUtils.BLACK;
		_scaleBitmaps[StateConstants.OVER] = ColorUtils.DARK_GRAY;
		_scaleBitmaps[StateConstants.ACTIVATED] = ColorUtils.RED;
		_scaleBitmaps[StateConstants.DISABLED] = ColorUtils.LIGHT_GRAY;
		background = new ColorBrush (_scaleBitmaps);

		var title_normal:TextStyle = new TextStyle();
		title_normal.textFormat.font = "Verdana";
		title_normal.textFormat.size = 12;
		title_normal.textFormat.color = 0xffffff;
		title_normal.textFormat.bold = false;

		var title_over:TextStyle = new TextStyle();
		title_over.textFormat.font = "Verdana";
		title_over.textFormat.size = 12;
		title_over.textFormat.color = 0xffffff;
		title_over.textFormat.bold = true;

		var title_down:TextStyle = new TextStyle();
		title_down.textFormat.font = "Verdana";
		title_down.textFormat.size = 12;
		title_down.textFormat.color = 0x000000;
		title_down.textFormat.bold = true;

		var title_disabled:TextStyle = new TextStyle();
		title_disabled.textFormat.font = "Verdana";
		title_disabled.textFormat.size = 12;
		title_disabled.textFormat.color = 0x000000;
		title_disabled.textFormat.bold = true;

		var data:Vector.<TextStyle> = new Vector.<TextStyle> ( 4 , true );
		data[StateConstants.ACTIVE] = title_normal;
		data[StateConstants.OVER] = title_over;
		data[StateConstants.ACTIVATED] = title_down;
		data[StateConstants.DISABLED] = title_disabled;
		buttonText = new TextBrush( data );

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
		return "[bloom.styles.BlackButton]";
	}

}

}
