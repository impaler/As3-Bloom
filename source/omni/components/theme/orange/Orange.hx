package omni.components.theme.orange;

import omni.components.core.OTheme;
import omni.components.utils.ColorUtils;

class Orange extends OTheme
{
	static public inline var DISABLED:Int = ColorUtils.LIGHT_ORANGE;
	static public inline var ACTIVE:Int = ColorUtils.DARKER_ORANGE;
	static public inline var OVER:Int = ColorUtils.ORANGE_BRIGHT;
	static public inline var DOWN:Int = ColorUtils.ORANGE;
	static public inline var BG:Int = ColorUtils.GRAY;

	public function new()
	{
		super();
		
		addStyle(OrangeComponent);
		addStyle(OrangeButtonBase);
		addStyle(OrangeLayout);
		addStyle(OrangeSlider);
		addStyle(OrangeScrollBar);
		addStyle(OrangeScrollContainer);
		addStyle(OrangeTextBase);
	}
}