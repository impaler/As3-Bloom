package omni.components.theme.orange;

import omni.components.style.OBaseStyle;
import omni.components.style.brush.BrushColorFill;
import omni.components.gui.layout.Layout.LayoutStyle;
import omni.components.utils.ColorUtils;
import nme.geom.Rectangle;

class OrangeLayout extends LayoutStyle {

	public function new( )
	{
		super( );

		var bgColor = new BrushColorFill ();
		bgColor.setColorState(OBaseStyle.STATE_ACTIVE, ColorUtils.BLACK);
		setBackgroundBrush( bgColor );

		defaultWidth = 300;
		defaultHeight = 300;
		defaultPadding = 10;

	}

}
