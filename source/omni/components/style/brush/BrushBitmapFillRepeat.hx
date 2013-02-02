package omni.components.style.brush;

import omni.components.core.interfaces.IBrush;
import omni.components.core.interfaces.IOComponent;

import nme.display.Graphics;

class BrushBitmapFillRepeat extends BrushBitmapFill
{
	override public function update(drawTarget:IOComponent)
	{
		#if (cpp||neko)
		//maybe related to https://haxenme.atlassian.net/browse/NME-82
		drawTarget.sprite.cacheAsBitmap = true;
		#end
		
		var bitmapdata = images.get(drawTarget.state);
		var graphics:Graphics = drawTarget.sprite.graphics;
		graphics.clear();
		graphics.beginBitmapFill(bitmapdata, null, true, smooth);
		graphics.drawRect(0, 0, drawTarget.width, drawTarget.height);
		graphics.endFill();
	}
}
