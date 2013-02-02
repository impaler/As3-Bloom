package omni.examples.components;

import omni.components.utils.ComponentUtils;
import nme.events.MouseEvent;
import nme.events.Event;
import nme.display.Sprite;

class MouseSpeed extends Sprite
{
	private var _xCache:Float = 0;
	private var _yCache:Float = 0;
	private var _xSpeed:Float = 0;
	private var _ySpeed:Float = 0;
	private var _ratio:Float = 0;
	private var _decel:Float = 0;
	private var _drag:Bool = false;

	private var _xOffset:Float = 0;
	private var _yOffset:Float = 0;

	public function new(ratio:Float, decel:Float)
	{
		super();
		_ratio = .5;
		_decel = .9;
		buttonMode = true;

		var testy = ComponentUtils.createTestSprite();
		addChild(testy);
		
		addListeners();
	}

	private function addListeners():Void
	{
		nme.Lib.stage.addEventListener(Event.ENTER_FRAME, doDrag);
		addEventListener(MouseEvent.MOUSE_DOWN, doPress);
		nme.Lib.stage.addEventListener(MouseEvent.MOUSE_UP, doRelease);
	}

	private function doDrag(e:Event):Void
	{
		if(! _drag)
		{
			x += (_xSpeed *= _decel);
			y += (_ySpeed *= _decel);
		}
		else
		{
			_xCache = x;
			_yCache = y;
			x = nme.Lib.stage.mouseX - _xOffset;
			y = nme.Lib.stage.mouseY - _yOffset;
		}
	}

	private function doPress(e:MouseEvent):Void
	{
		_xOffset = e.stageX - x;
		_yOffset = e.stageY - y;
		_drag = true;
	}

	private function doRelease(e:MouseEvent):Void
	{
		_drag = false;
		_xSpeed = (x - _xCache) * _ratio;
		_ySpeed = (y - _yCache) * _ratio;
	}
} 
	