package omni.components.theme.orange;

import omni.components.style.OBaseStyle;
import omni.components.style.brush.BrushColorFill;
import omni.components.gui.controls.ScrollBar.ScrollBarStyle;
import omni.components.gui.controls.Slider.SliderBaseStyle;
import omni.components.utils.ColorUtils;

class OrangeScrollBar extends ScrollBarStyle
{
	public function new()
	{
		super();

		buttonStyle = new OrangeButtonBase();

		var bgColor = new BrushColorFill ();
		bgColor.setColorState(OBaseStyle.STATE_ACTIVE, Orange.BG);
		setBackgroundBrush(bgColor);

		defaultWidth = 20;
		defaultHeight = 180;
		defaultPadding = 10;

	}

}
