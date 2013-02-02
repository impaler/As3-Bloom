package omni.components.gui.layout;

import omni.components.core.interfaces.IOComponent;
import omni.components.core.OComponent;
import omni.components.style.OBackgroundStyle;

import nme.display.Sprite;

class StretchLayout extends Layout
{

	override public function add(comp:IOComponent):Void
	{
		super.add(comp);
		invalidate();
	}

	override public function getHeight():Float
	{
		
		return _height;
	}

	override public function getWidth():Float
	{
		return _width;
	}

	override public function draw():Void
	{

		for(i in 0...components.length)
		{
			var current = cast (components[i], IOComponent);
			
//			current._width = current.widthPercent / components.length / _width

		}

		super.draw();
	}

	public function setDirection(value:Int):Int
	{
		_direction = value;
		invalidate();

		return _direction;
	}

	override public function getStyleId():String
	{
		return StretchLayoutStyle.styleString;
	}
}

/**
* StretchLayoutStyle
*/
class StretchLayoutStyle extends LayoutStyle
{

	public static var styleString:String = "StretchLayoutStyle";

	public function new()
	{
		super();
		styleID = styleString;
	}
}


