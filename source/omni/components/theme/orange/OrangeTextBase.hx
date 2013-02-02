package omni.components.theme.orange;

import omni.components.style.OBaseStyle;
import omni.components.core.OTextBase.TextBaseStyle;
import omni.components.style.brush.BrushColorFill;
import omni.components.utils.ColorUtils;

import nme.Assets;
import nme.text.TextFormatAlign;
import nme.text.TextFieldType;

class OrangeTextBase extends TextBaseStyle {

	public function new( )
	{
		super( );

		var bgColor = new BrushColorFill ();
		bgColor.setColorState(OBaseStyle.STATE_ACTIVE, ColorUtils.GRAY);
		setBackgroundBrush( bgColor );

		defaultHeight = 100;
		minHeight = 100;
		maxHeight = 100;
		
		defaultWidth = 100;
		minWidth= 100;
		maxWidth = 100;
		
		defaultState = OBaseStyle.STATE_ACTIVE;
		defaultPadding = 0;
		
		var font = Assets.getFont( "assets/themes/orange/text/roboto-regular.ttf" );
		fontName = font.fontName;
		selectable = false;
		multiline= false;
		wordWrap = false;
		restrict = "0-9.\\-";
		fontSize = 50;
		type = TextFieldType.DYNAMIC;
		fontColor = ColorUtils.ORANGE_BRIGHT;
		defaultText = "Orange Text";
		
	}

}
