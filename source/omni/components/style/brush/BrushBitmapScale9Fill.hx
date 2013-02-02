package omni.components.style.brush;

import omni.components.core.interfaces.IOComponent;
import omni.components.core.interfaces.IBrush;
import omni.components.utils.ComponentUtils;
import omni.components.utils.BitmapScaleSliceUtil;

class BrushBitmapScale9Fill extends BrushBitmapFill
{

	//vertical left, vertical right, horizontal top, horizontal bottom
	public var scaleRect:Array<Int>;
	//todo smooth
	//todo stretch

	override public function update(drawTarget:IOComponent)
	{
		var bitmapdata = images.get(drawTarget.state);

		BitmapScaleSliceUtil.slice9(drawTarget.sprite, drawTarget.width, drawTarget.height, bitmapdata, scaleRect,smooth);
	}

	override public function destroy():Void
	{
		scaleRect = null;
		super.destroy();
	}

}
