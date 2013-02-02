package omni.components.theme.orange;

import omni.components.style.OBaseStyle;
import omni.components.style.brush.BrushColorFill;
import omni.components.gui.controls.Slider.SliderBaseStyle;
import omni.components.utils.ColorUtils;

/**
 * OrangeSlider
 */
class OrangeSlider extends SliderBaseStyle {

	public function new( )
	{
		super( );
		
		buttonStyle = new OrangeButtonBase();
		
		var bgColor = new BrushColorFill ();
		bgColor.setColorState(OBaseStyle.STATE_ACTIVE, Orange.BG);
		setBackgroundBrush( bgColor );

		defaultVHeight = 120;
		defaultVWidth = 20;

		defaultHHeight = 20;
		defaultHWidth = 120;

		defaultValue = 50;
		
		defaultPadding = 0;
		minWidth = 10;
		minHeight = 10;
		maxWidth = 2000;
		maxHeight = 2000;
	}

}
