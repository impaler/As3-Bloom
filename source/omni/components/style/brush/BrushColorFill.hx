package omni.components.style.brush;

import omni.components.core.interfaces.IOComponent;
import omni.components.core.interfaces.IBrush;

import nme.display.Sprite;
import nme.display.Graphics;

class BrushColorFill implements IBrush
{
	public var colors:Hash<Int>;

	public function new()
	{
		colors = new Hash();
	}

	public function setColorState(state:String, color:Int):Void
	{
		colors.set(state, color);
	}

	public function update(drawTarget:IOComponent)
	{
		var color = colors.get(drawTarget.state);

		var graphics:Graphics = drawTarget.sprite.graphics;
		graphics.clear();
		graphics.beginFill(color);
		graphics.drawRect(0, 0, drawTarget.width, drawTarget.height);
		graphics.endFill();
	}

	public function destroy():Void
	{
		colors = null;
	}

}
