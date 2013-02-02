package omni.components.gui.controls;

import omni.components.core.signals.OSignalMouse;
import omni.components.core.interfaces.IStyle;
import omni.components.gui.layout.Layout;
import nme.geom.Rectangle;
import omni.components.gui.controls.Slider.SliderBaseStyle;
import flash.display.DisplayObjectContainer;
import flash.events.Event;

class ScrollBar extends Slider
{
	public var _realSize:Int = 0;

	public var minSize(getMinSize, setMinSize):Int;
	public var _minSize:Int = 0;

	public var contentSize(default, setContentSize):Int = 0;
	public var pageSize(default, setPageSize):Int = 0;

	public var _working:Bool = true;

	override public function onMouseMove(?e:OSignalMouse):Void
	{
		super.onMouseMove(e);
	}

	override public function onMouseUp(?e:OSignalMouse):Void
	{
		button.onMouseUp(e);
		button.stopDrag();

		updateValueOnMouseMove();

		mouseUp.remove(onMouseUp);
		mouseMove.remove(onMouseMove);
	}

	override public function onMouseDown(?e:OSignalMouse):Void
	{
		button.onMouseDown(e);

		updateButtonLocationFromDown();
		updateValueFromButtonLocation();

		button.startDrag(false, _rect);
		mouseMove.add(onMouseMove);
		mouseUp.add(onMouseUp);
	}

	override public function onMouseWheel(?e:OSignalMouse):Void
	{
		if(_type == Layout.HORIZONTALLY)
		{
			value += e.delta > 0 ? step : - step;
		}
		else
		{
			value -= e.delta > 0 ? step : - step;
		}
		e.updateAfterEvent();
	}

	override public function refreshButton():Void
	{
		_max = Math.max(contentSize - pageSize, 0);
		
		if(_max > 0)
		{
			barNeeded = true;
			if(_type == Slider.HORIZONTALLY)
			{
				_realSize = Std.int((pageSize * _width) / (_max + pageSize));
				button._size(Math.max(_realSize, _minSize), _height);
				_rect.width = Math.ceil(_width - button.width);
				button.x = _value / _max * _rect.width;
				if(button.x + button.width > _width) button.x = _width - button.width;
			}
			else
			{
				_realSize = Std.int((pageSize * _height) / (_max + pageSize));
				button._size(_width, Math.max(_realSize, _minSize));
				_rect.height = Math.ceil(_height - button.height);
				button.y = _value / _max * _rect.height;
				if(button.y + button.height > _height) button.y = _height - button.height;
			}
			_working = true;
		}
		else
		{
			barNeeded = false;
			_value = 0;
			_rect.width = 0;
			_rect.height = 0;
			button.move(0, 0);
			button._size(0, 0);
			_working = false;
		}
	}

	override public function updateValueOnMouseMove():Void
	{
		var valueChange = _value;

		if(_type == Slider.HORIZONTALLY)
		{
			valueChange = clamp(Math.ceil(button.sprite.x / _rect.width * _max));
		}
		else
		{
			valueChange = clamp(Math.ceil(button.sprite.y / _rect.height * _max));
		}

		if(_value != valueChange)
		{
			_value = valueChange;
			onChange.dispatch(_value);
		}
	}

	override public function updateValueFromButtonLocation():Void
	{
		var valueChange = _value;
		if(_type == Slider.HORIZONTALLY)
		{
			valueChange = Math.ceil(button.x / _rect.width * _max);
		}
		else
		{
			valueChange = Math.ceil(button.y / _rect.height * _max);
		}
		if(_value != valueChange)
		{
			_value = valueChange;
			onChange.dispatch(_value);
		}
	}
	
	public var barNeeded(getBarNeeded, setBarNeeded):Bool;
	public function setBarNeeded(value:Bool):Bool
	{
		barNeeded = value;
		return barNeeded;
	}
	public function getBarNeeded():Bool
	{
		_max = Math.max(contentSize - pageSize, 0);
		
		if(_max > 0)
		{
			return true;

		} else {

			return false;
		}
	}

	public function setContentSize(value:Int):Int
	{
		if(contentSize != value)
		{
			contentSize = value;
		}
		return value;
	}

	public function setPageSize(value:Int):Int
	{
		if(pageSize != value)
		{
			pageSize = value;
		}
		return value;
	}

	public function setMinSize(value:Int):Int
	{
		if(_minSize != value)
		{
			_minSize = value;
		}
		return _minSize;
	}

	public function getMinSize():Int
	{
		return _minSize;
	}

	override public function getStyleId():String
	{
		return ScrollBarStyle.styleString;
	}

}

class ScrollBarStyle extends SliderBaseStyle
{

	public static var styleString:String = "ScrollBarStyle";

	public function new()
	{
		super();
		styleID = styleString;
	}
}




