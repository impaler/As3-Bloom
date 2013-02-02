package omni.components.style.brush;

import omni.components.core.interfaces.IOComponent;
import omni.components.core.interfaces.IBrush;
import omni.components.utils.ComponentUtils;
import omni.components.utils.BitmapScaleSliceUtil;

class BrushBitmapScale3Fill extends BrushBitmapFill
{

	/**
	* This array should contain zero, one or two integers.
	* 
	* Zero -    3 slice scaling (horizontal). Bitmap is divided into two equal sized bitmaps.
	* 	        Middle part is filled with central column of pixels.
	* One -     3 slice scaling (horizontal). Bitmap is divided into two bitmaps. Middle part
	*           is filled with column of pixels with x = specified integer.
	* Two -     3 slice scaling (horizontal). Integers: left and right guidelines for slicing
	* 
	**/
	public var scaleRect:Array<Int>;
	//todo smooth
	//todo stretch

	override public function update(drawTarget:IOComponent)
	{
		var bitmapdata = images.get(drawTarget.state);

		BitmapScaleSliceUtil.slice3(drawTarget.sprite, drawTarget.width, drawTarget.height, bitmapdata, scaleRect,smooth);
	}

	override public function destroy():Void
	{
		scaleRect = null;
		super.destroy();
	}

}
