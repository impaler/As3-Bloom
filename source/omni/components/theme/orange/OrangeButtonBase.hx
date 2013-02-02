package omni.components.theme.orange;

import omni.components.core.OButtonBase.OButtonBaseStyle;
import omni.components.style.OBaseStyle;
import omni.components.utils.ColorUtils;
import omni.components.style.brush.BrushColorFill;
import omni.components.core.OComponent.ComponentStyle;

class OrangeButtonBase extends OButtonBaseStyle
{
	public function new()
	{
		super();

		var bgColor = new BrushColorFill ();
		bgColor.setColorState(OBaseStyle.STATE_ACTIVE, Orange.ACTIVE);
		bgColor.setColorState(OBaseStyle.STATE_DISABLED, Orange.DISABLED);
		bgColor.setColorState(OButtonBaseStyle.STATE_OVER, Orange.OVER);
		bgColor.setColorState(OButtonBaseStyle.STATE_DOWN, Orange.DOWN);
		setBackgroundBrush(bgColor);

		defaultWidth = 200;
		defaultHeight = 50;
		minWidth = 10;
		minHeight = 10;
		maxWidth = 2000;
		maxHeight = 2000;
		defaultPadding = 0;
	}
}