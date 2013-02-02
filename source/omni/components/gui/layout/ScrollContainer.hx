package omni.components.gui.layout;

import omni.components.core.signals.OCoreEvent;
import omni.components.core.interfaces.IOComponent;
import omni.components.core.signals.OSignalMouse;
import omni.components.core.OCore;
import omni.components.gui.controls.ScrollBar;
import omni.components.gui.layout.Layout;
import omni.components.utils.Tween;
import omni.components.utils.ComponentUtils;

import nme.display.DisplayObject;
import nme.display.DisplayObjectContainer;
import nme.display.Sprite;
import nme.events.MouseEvent;
import nme.events.Event;
import nme.geom.Point;
import nme.geom.Rectangle;

class ScrollContainer extends Layout
{
	private var h_scrollBar_enabled:Bool = true;
	private var v_scrollBar_enabled:Bool = true;

	private var h_scrollBar:ScrollBar;
	private var v_scrollBar:ScrollBar;
	public var contentComponent:IOComponent;

	private var _rect:Rectangle;

	private var scrollStep:Int;
	private var scrollButtonSize:Int;

	public var tweenEnabled:Bool;
	
	private var _xOffset:Float = 0;
	private var _yOffset:Float = 0;
	private var _scrollY:Float = 0;
	private var _scrollX:Float = 0;

	private var _yPos:Float;
	private var _xPos:Float;

	private var _xCache:Float = 0;
	private var _yCache:Float = 0;
	private var _xSpeed:Float = 0;
	private var _ySpeed:Float = 0;
	private var tweenBackSpeed:Int = 0;
	private var _speedLimit:Float = 0;
	private var _ratio:Float = 0;
	private var _decel:Float = 0;
	private var _drag:Bool = false;

	private var _scrollbarMove:Bool = false;

	private var mouseWheel:OSignalMouse;
	private var dragEnterFrame:OCoreEvent;

	override public function createMembers():Void
	{
		super.createMembers();

		//todo needs a good clean up and maybe some bool checks on event listeners to stop button bashing bug
		
		//todo move all properties to style system
		scrollButtonSize = 10;
		scrollStep = 20;
		tweenBackSpeed = 8;
		_speedLimit = 1;
		_ratio = .5;
		_decel = .9;
//		animated = true;

		_rect = new Rectangle(0, 0, 0, 0);

		target = new Sprite();
		target.scrollRect = _rect;
		sprite.addChild(target);

		var thisStyle = cast(_style, ScrollContainerStyle);

		h_scrollBar = new ScrollBar( thisStyle.hScrollStyle );
		h_scrollBar.type = Layout.HORIZONTALLY;
		//todo in style
		h_scrollBar.step = scrollStep;

		v_scrollBar = new ScrollBar( thisStyle.vScrollStyle );
		v_scrollBar.type = Layout.VERTICALLY;
		v_scrollBar.step = scrollStep;
		
		dragEnterFrame = new OCoreEvent(Event.ENTER_FRAME, nme.Lib.stage );
	}

	public function enableTween():Void
	{
		tweenEnabled = true;
		dragEnterFrame.add (doDrag);
		nme.Lib.stage.addEventListener(MouseEvent.MOUSE_UP, doRelease);
	}

	public function disableTween():Void
	{
		tweenEnabled = false;
		dragEnterFrame.remove (doDrag);
		nme.Lib.stage.removeEventListener(MouseEvent.MOUSE_UP, doRelease);
	}

	override public function enableSignals():Void
	{
		h_scrollBar.onChange.add(onHScrollBarMove);
		v_scrollBar.onChange.add(onVScrollBarMove);

		enableTween();
//		
		//todo release outside of stage for desktop
	}

	override public function disableSignals():Void
	{
		h_scrollBar.onChange.remove(onHScrollBarMove);
		v_scrollBar.onChange.remove(onVScrollBarMove);

		disableTween();
	}

	override public function add(comp:IOComponent):Void
	{
		contentComponent = comp;

		target.addChild(comp.sprite);
		this.components.push(comp);

		target.addEventListener(MouseEvent.MOUSE_DOWN, doPress);

		if(mouseWheel != null) mouseWheel.removeAll();
		mouseWheel = new OSignalMouse (OSignalMouse.WHEEL, target);
		mouseWheel.add(v_scrollBar.onMouseWheel);

		invalidate();
	}

	//todo addToLayout
	//addVerical
	//addHorizontal

	private function doDrag(e:OCoreEvent):Void
	{
		if(! _scrollbarMove)
		{
			removeanimateYBack();
			removeanimateXBack();

			if(! _drag)
			{
				limitSpeed();

				contentComponent.x += (_xSpeed *= _decel);
				contentComponent.y += (_ySpeed *= _decel);

				if(Math.round(_ySpeed) == 0 || Math.round(_xSpeed) == 0)
				{
					checkYPosition();
					checkXPosition();
				}
			}
			else
			{
				_xCache = contentComponent.x;
				_yCache = contentComponent.y;
				contentComponent.x = nme.Lib.stage.mouseX - _xOffset;
				contentComponent.y = nme.Lib.stage.mouseY - _yOffset;
			}
		}

		updateScrollBarsFromChange();
	}

	private inline function limitSpeed():Void
	{
		//if the content is out of bounds limit it's speed
		if(! isValidY())
		{
			if(_ySpeed > _speedLimit) _ySpeed = _speedLimit;
			if(_ySpeed < - _speedLimit) _ySpeed = - _speedLimit;
		}

		if(! isValidX())
		{
			if(_xSpeed > _speedLimit) _xSpeed = _speedLimit;
			if(_xSpeed < - _speedLimit) _xSpeed = - _speedLimit;
		}
	}

	//todo bool checlk

	public function animateToxPos():Void
	{
		nme.Lib.stage.addEventListener(Event.ENTER_FRAME, animateXBack);
	}
	//todo bool checlk

	public function animateXBack(e:Event):Void
	{
		contentComponent.x += (_xPos - contentComponent.x) / tweenBackSpeed;

		if(contentComponent.x == _xPos)
		{
			removeanimateXBack();
		}
	}
	//todo bool checlk

	public function removeanimateXBack():Void
	{
		nme.Lib.stage.removeEventListener(Event.ENTER_FRAME, animateXBack);
	}
	//todo bool checlk

	public function animateToYPos():Void
	{
		nme.Lib.stage.addEventListener(Event.ENTER_FRAME, animateYBack);
	}
	//todo bool checlk

	public function animateYBack(e:Event):Void
	{
		contentComponent.y += (_yPos - contentComponent.y) / tweenBackSpeed;

		if(contentComponent.y == _yPos)
		{
			removeanimateYBack();
		}
	}
	//todo bool checlk

	public function removeanimateYBack():Void
	{
		nme.Lib.stage.removeEventListener(Event.ENTER_FRAME, animateYBack);
	}

	private function doPress(e:MouseEvent):Void
	{
		if (tweenEnabled) {
			removeanimateXBack();
			removeanimateYBack();
		} else {
			nme.Lib.stage.addEventListener(MouseEvent.MOUSE_MOVE, onDraggingContent);
		}
		
		_drag = true;
		_scrollbarMove = false;

		_xOffset = e.stageX - contentComponent.x;
		_yOffset = e.stageY - contentComponent.y;
		
	}
	
	public function onDraggingContent(e:MouseEvent):Void
	{

		if(v_scrollBar_enabled)
		{
			contentComponent.y = e.stageY - _yOffset;
			_scrollY = - contentComponent.y;
			//todo shouldnt need this as _value clamp should take care in scrollbar???
			if(_scrollY < 0) _scrollY = 0;

			v_scrollBar._value = Std.int(_scrollY);
			v_scrollBar.refreshButton();
		}

		if(h_scrollBar_enabled)
		{
			contentComponent.x = e.stageX - _xOffset;
			_scrollX = - contentComponent.x;
			if(_scrollX < 0) _scrollX = 0;

			h_scrollBar._value = Std.int(_scrollX);
			h_scrollBar.refreshButton();
		}
		
		checkXPosition(false);
		checkYPosition(false);
		
		nme.Lib.stage.addEventListener(MouseEvent.MOUSE_UP, onRelease);
		e.updateAfterEvent();
	}

	public function onRelease(e:MouseEvent):Void
	{
		nme.Lib.stage.removeEventListener(MouseEvent.MOUSE_MOVE, onDraggingContent);
	}
	
	

	private function doRelease(e:MouseEvent):Void
	{
		_drag = false;

		_xSpeed = (contentComponent.x - _xCache) * _ratio;
		_ySpeed = (contentComponent.y - _yCache) * _ratio;
	}

	public function updateScrollBarsFromChange():Void
	{
		if(v_scrollBar_enabled)
		{
			_scrollY = - contentComponent.y;
			//todo shouldnt need this as _value clamp should take care in scrollbar???
			if(_scrollY < 0) _scrollY = 0;

			v_scrollBar._value = Std.int(_scrollY);
			v_scrollBar.refreshButton();
		}

		if(h_scrollBar_enabled)
		{
			_scrollX = - contentComponent.x;
			if(_scrollX < 0) _scrollX = 0;

			h_scrollBar._value = Std.int(_scrollX);
			h_scrollBar.refreshButton();
		}
	}

	public function checkYPosition(animate:Bool = true):Void
	{
		var isValid = isValidY();

		if(! isValid)
		{
			animate ? animateToYPos() : contentComponent.y = _yPos;
		}
	}

	private inline function isValidY():Bool
	{
		var isValid = true;
		if(contentComponent.y > 0)
		{
			_yPos = 0;
			isValid = false;
		}

		var ylimit = - (contentComponent.height - _rect.height);

		if(contentComponent.y < ylimit)
		{
			isValid = false;
			v_scrollBar.barNeeded ? _yPos = ylimit : _yPos = 0;
		}

		return isValid;
	}

	public function checkXPosition(animate:Bool = true):Void
	{
		var isValid = isValidX();

		if(! isValid)
		{
			animate ? animateToxPos() : contentComponent.x = _xPos;
		}
	}

	private function isValidX():Bool
	{
		var isValid = true;
		if(contentComponent.x > 0)
		{
			_xPos = 0;
			isValid = false;
		}

		var xlimit = - (contentComponent.width - _rect.width);

		if(contentComponent.x < xlimit)
		{
			isValid = false;
			h_scrollBar.barNeeded ? _xPos = xlimit : _xPos = 0;
		}
		return isValid;
	}

	private function onVScrollBarMove(e:Dynamic = null):Void
	{
		checkXPosition(false);
		removeanimateYBack();

		_scrollbarMove = true;

		if(v_scrollBar_enabled)
		{
			contentComponent.y = - v_scrollBar.value;
		}
	}

	private function onHScrollBarMove(e:Dynamic = null):Void
	{
		checkYPosition(false);
		removeanimateXBack();

		_scrollbarMove = true;
		
		if(h_scrollBar_enabled)
		{
			contentComponent.x = - h_scrollBar.value;
		}
	}

	override public function setDirection(value:Int):Int
	{
		_direction = value;

		if(_direction == Layout.VERTICALLY)
		{
			h_scrollBar_enabled = false;
			v_scrollBar_enabled = true;
		}
		else if(_direction == Layout.HORIZONTALLY)
		{
			h_scrollBar_enabled = true;
			v_scrollBar_enabled = false;
		}

		invalidate();

		return _direction;
	}

	public function updateScrollBars():Void
	{
		h_scrollBar.move(0, _height - scrollButtonSize);
		v_scrollBar.move(_width - scrollButtonSize, 0);

		updateContentSize();

		if(h_scrollBar_enabled)
		{
			if(v_scrollBar_enabled)
			{
				_rect.width = _width - scrollButtonSize;
				h_scrollBar.pageSize = Std.int(_rect.width);
				_rect.height = _height - scrollButtonSize;
				v_scrollBar.pageSize = Std.int(_rect.height);

				h_scrollBar._size(_width - scrollButtonSize, scrollButtonSize);
				v_scrollBar._size(scrollButtonSize, _height - scrollButtonSize);

				if(! v_scrollBar.barNeeded)
				{
					if(v_scrollBar.sprite.parent != null) sprite.removeChild(v_scrollBar.sprite);
					_rect.width = _width;
					h_scrollBar.pageSize = Std.int(_rect.width);
					h_scrollBar._size(_width, scrollButtonSize);
				}
				else
				{
					if(v_scrollBar.sprite.parent == null) sprite.addChild(v_scrollBar.sprite);
				}

				if(! h_scrollBar.barNeeded)
				{
					if(h_scrollBar.sprite.parent != null) sprite.removeChild(h_scrollBar.sprite);
					_rect.height = _height;
					v_scrollBar.pageSize = Std.int(_rect.height);
					v_scrollBar._size(scrollButtonSize, _height);
				}
				else
				{
					if(h_scrollBar.sprite.parent == null) sprite.addChild(h_scrollBar.sprite);
				}
			}
			else
			{
				_rect.width = _width;
				h_scrollBar.pageSize = Std.int(_rect.width);
				_rect.height = _height - scrollButtonSize;
				v_scrollBar.pageSize = Std.int(_rect.height);
				h_scrollBar._size(_width, scrollButtonSize);

				v_scrollBar._size(0, 0);

				if(v_scrollBar.sprite.parent != null) sprite.removeChild(v_scrollBar.sprite);

				if(! h_scrollBar.barNeeded)
				{
					if(h_scrollBar.sprite.parent != null) sprite.removeChild(h_scrollBar.sprite);
					_rect.height = _height;
					v_scrollBar.pageSize = Std.int(_rect.height);
				}
				else
				{
					if(h_scrollBar.sprite.parent == null) sprite.addChild(h_scrollBar.sprite);
				}
			}
		}
		else
		{
			if(v_scrollBar_enabled)
			{
				_rect.width = _width - scrollButtonSize;
				h_scrollBar.pageSize = Std.int(_rect.width);
				_rect.height = _height;
				v_scrollBar.pageSize = Std.int(_rect.height);

				h_scrollBar._size(0, 0);
				v_scrollBar._size(scrollButtonSize, _height);

				if(! v_scrollBar.barNeeded)
				{
					if(v_scrollBar.sprite.parent != null) sprite.removeChild(v_scrollBar.sprite);
					_rect.width = _width;
					h_scrollBar.pageSize = Std.int(_rect.width);
				}
				else
				{
					if(v_scrollBar.sprite.parent == null) sprite.addChild(v_scrollBar.sprite);
				}
			}
			else
			{
				_rect.width = _width;
				h_scrollBar.pageSize = Std.int(_rect.width);
				_rect.height = _height;
				v_scrollBar.pageSize = Std.int(_rect.height);

				h_scrollBar._size(0, 0);
				v_scrollBar._size(0, 0);

				if(! v_scrollBar.barNeeded)
				{
					if(v_scrollBar.sprite.parent != null) sprite.removeChild(v_scrollBar.sprite);
				}
				else
				{
					if(v_scrollBar.sprite.parent == null) sprite.addChild(v_scrollBar.sprite);
				}
			}

			if(h_scrollBar.sprite.parent != null) sprite.removeChild(h_scrollBar.sprite);
		}

		target.scrollRect = _rect;
	}

	public function updateContentSize():Void
	{
		if(contentComponent != null)
		{
			var height = Std.int(contentComponent.height);
			var width = Std.int(contentComponent.width);

			h_scrollBar.contentSize = width;
			v_scrollBar.contentSize = height;
		}
	}

	override public function invalidate(recursive:Bool = true):Void
	{
		updateScrollBars();

		h_scrollBar.invalidate();
		v_scrollBar.invalidate();

		super.invalidate(false);
	}

	override public function draw():Void
	{
		coreDraw();
	}

	override public function getHeight():Float
	{
		return _height;
	}

	override public function getWidth():Float
	{
		return _width;
	}

	override public function getStyleId():String
	{
		return ScrollContainerStyle.styleString;
	}

}

class ScrollContainerStyle extends LayoutStyle
{

	public static var styleString:String = "ScrollContainerStyle";

	public var hScrollStyle:ScrollBarStyle;
	public var vScrollStyle:ScrollBarStyle;

	public function new()
	{
		super();
		styleID = styleString;
	}
}


