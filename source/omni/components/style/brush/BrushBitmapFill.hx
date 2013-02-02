package omni.components.style.brush;

import omni.components.core.interfaces.IBrush;
import omni.components.core.interfaces.IOComponent;

import nme.Assets;
import nme.display.Graphics;
import nme.display.BitmapData;

class BrushBitmapFill implements IBrush
{

	private var images:Hash<BitmapData>;
	public var smooth:Bool;

	public function setBitmapState(state:String, path:String):Void
	{
		var image = loadNMEGraphic(path);
		images.set(state, image);
	}
	
	public function setBitmapDataState(state:String, data:BitmapData):Void
	{
		images.set(state, data);
	}
	
	public function loadNMEGraphic(path:String):BitmapData
	{
		return Assets.getBitmapData(path);
	}

	public function new()
	{
		smooth = false;
		images = new Hash();
	}

	public function update(drawTarget:IOComponent)
	{
		var bitmapdata = images.get(drawTarget.state);
		var graphics:Graphics = drawTarget.sprite.graphics;
		graphics.clear();
		graphics.beginBitmapFill(bitmapdata, null, false, smooth);
		graphics.drawRect(0, 0, drawTarget.width, drawTarget.height);
		graphics.endFill();
	}

	public function destroy():Void
	{
		images = null;
	}

}
