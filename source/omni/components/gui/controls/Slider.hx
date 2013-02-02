package omni.components.gui.controls;

import omni.components.gui.controls.Slider;
import omni.components.core.interfaces.IOComponent;
import omni.components.core.interfaces.IStyle;
import omni.components.core.signals.OSignal;
import omni.components.core.signals.OCoreEvent;
import omni.components.core.signals.OSignalMouse;
import omni.components.style.OBackgroundStyle;
import omni.components.core.OCore;
import omni.components.core.signals.OSignalMouse;
import omni.components.core.OComponent;
import omni.components.core.OButtonBase;
import omni.components.utils.ComponentUtils;

import nme.display.Sprite;
import nme.geom.Rectangle;
import nme.events.Event;
import nme.events.MouseEvent;

class Slider extends OComponent
{
	public static var VERTICALLY:Int = 0;
	public static var HORIZONTALLY:Int = 1;

	public var step:Int = 10;

	public var button:OButtonBase;

	public var value(getValue, setValue):Int;
	public var _value:Int = 30;

	public var type(getType, setType):Int;
	public var _type:Int = 0;

	public var max(getMax, setMax):Float;
	public var _max:Float = 100;

	public var min(getMin, setMin):Float;
	public var _min:Float = 0;

	private var _rect:Rectangle;

	private var buttonClick:Bool = false;

	private var mouseMove:OSignalMouse;
	private var mouseWheel:OSignalMouse;
	private var mouseDown:OSignalMouse;
	private var mouseUp:OSignalMouse;

	public var onChange(default, null):OSignal<Int -> Void>;

	//todo broken in html5
	private var _mouseWheelTarget(default, setMouseWheelTarget):Sprite;

	override public function createMembers():Void
	{
		_rect = new Rectangle();

		onChange = new OSignal<Int -> Void>();
		mouseWheel = new OSignalMouse (OSignalMouse.WHEEL, this.sprite);
		mouseDown = new OSignalMouse (OSignalMouse.DOWN, this.sprite);
		mouseUp = OCore.instance.onStageMouseUp;
		mouseMove = OCore.instance.onStageMouseMove;

		button = new OButtonBase();
		add(button);
		
		sprite.buttonMode = true;
	}

	override public function enableSignals():Void
	{
		button.mouseDown.add(onButtonDown);
		mouseWheel.add(onMouseWheel);
		mouseDown.add(onMouseDown);
	}

	override public function disableSignals():Void
	{
		button.mouseDown.remove(onButtonDown);
		mouseDown.remove(onMouseDown);
		mouseWheel.remove(onMouseWheel);
	}
	
	public function onMouseMove(?e:OSignalMouse):Void
	{
		updateValueOnMouseMove();

		e.updateAfterEvent();
	}
	
	public function onMouseDown(?e:OSignalMouse):Void
	{
		button.onMouseDown(e);

		updateButtonLocationFromDown();
		updateValueFromButtonLocation();

		button.startDrag(false, _rect);

		mouseMove.add(onMouseMove);
		mouseUp.add(onMouseUp);
	}

	public function onButtonDown(e:OSignalMouse):Void
	{
		buttonClick = true;
		OCore.instance.onStageMouseLeave.add(onLeftStage);
	}

	public function onMouseUp(?e:OSignalMouse):Void
	{
		button.onMouseUp(e);
		button.stopDrag();

		mouseUp.remove(onMouseUp);
		mouseMove.remove(onMouseMove);

		updateValueFromButtonLocation();
		
		onChange.dispatch(value);
	}

	public function onMouseWheel(?e:OSignalMouse):Void
	{
		value += (e.delta > 0 ? step : - step);
		e.updateAfterEvent();
	}
	
	public function onLeftStage(e:OCoreEvent):Void
	{
		onMouseUp();
	}

	public function updateButtonLocationFromDown():Void
	{
		if ( buttonClick == false ) {
			if (_type == HORIZONTALLY) {
				var maxlocation = Math.min( this.width - button.width, this.mouseX - button.width / 2 );
				button.x = ComponentUtils.clamp( (this.mouseX - button.width / 2), 0, maxlocation );
			}
			
			if(_type == VERTICALLY) {
				var maxlocation = Math.min( this.height - button.height , this.mouseY - button.height / 2 );
				button.y = ComponentUtils.clamp( (this.mouseY - button.height / 2), 0, maxlocation );
			}
		}
		buttonClick = false;
	}

	public function updateValueOnMouseMove():Void
	{
		var valueChange = _value;
		
		if(_type == Slider.HORIZONTALLY)
		{
			valueChange = clamp(Std.int(button.x / (_width - _height) * (_max - _min) + _min));
		}
		else
		{
			valueChange = clamp(Std.int((_height - _width - button.y) / (_height - _width) * (_max - _min) + _min));
		}

		if(_value != valueChange)
		{
			_value = valueChange;
			onChange.dispatch(_value);
		}
	}

	override public function invalidate(recursive:Bool = true):Void
	{
		refreshButton();
		super.invalidate(true);
	}

	public function refreshButton():Void
	{
		if(_type == Slider.HORIZONTALLY)
		{
			button._height = _height;
			button._width = _height;
			_rect.width = _width - _height;
			button.move((_value - _min) / (_max - _min) * _rect.width, 0);
		}
		else
		{
			button._height = _width;
			button._width = _width;
			_rect.height = _height - _width;
			button.move(0, _rect.height - (_value - _min) / (_max - _min) * _rect.height);
		}
	}

	public function updateValueFromButtonLocation():Void
	{
		if(_type == Slider.HORIZONTALLY)
		{
			_value = clamp(Std.int(((this.mouseX - (Std.int(_height) >> 1)) / (_width - _height)) * (_max - _min) + _min));
		}
		else
		{
			_value = clamp(Std.int((_height - (Std.int(_width) >> 1) - this.mouseY) / (_height - _width) * (_max - _min) + _min));
		}
	}
	
	private function clampValue( ):Void
	{
		_value = clamp(_value);
	}
	
	private function clamp( value:Int ):Int
	{
		if ( _max > _min ) {
			if ( value > Std.int(_max) )value = Std.int(_max);
			if ( value < Std.int(_min) )value = Std.int(_min);
		} else {
			value = Std.int(_max);
			_min = _max;
		}
		return value;
	}
	
	
	public function get_mouseWheelTarget():Sprite
	{
		return _mouseWheelTarget;
	}

	public function setMouseWheelTarget(value:Sprite):Sprite
	{
		_mouseWheelTarget = value;
		return _mouseWheelTarget;
	}

	private function getMax():Float
	{
		return _max;
	}

	private function setMax(value:Float):Float
	{
		if(_max != value)
		{
			_max = value;
			invalidate();
		}
		return value;
	}

	private function getMin():Float
	{
		return _min;
	}

	private function setMin(value:Float):Float
	{
		if(_min != value)
		{
			_min = value;
			invalidate();
		} return value;
	}

	public function getValue():Int
	{
		return _value;
	}

	public function setValue(value:Int):Int
	{
		value = clamp(value);

		if(_value != value)
		{
			_value = value;

			invalidate();
			onChange.dispatch(_value);
		}
		return value;
	}

	public function getType():Int
	{
		return _type;
	}

	public function setType(value:Int):Int
	{
		if(_type != value)
		{
			_type = value;

			var styleAs = cast (_style, SliderBaseStyle);
			if(_type == Slider.VERTICALLY)
			{
				_width = styleAs.defaultVWidth;
			}
			else
			{
				_width = styleAs.defaultHWidth;
			}

			if(_type == Slider.VERTICALLY)
			{
				_height = styleAs.defaultVHeight;
			}
			else
			{
				_height = styleAs.defaultHHeight;
			}
			_rect = new Rectangle(0, 0, 0, 0);

			invalidate();
		}
		return _type;
	}

	override public function destroy():Void
	{
		mouseMove.destroy();
		mouseWheel.destroy();
		mouseDown.destroy();
		mouseUp.destroy();
		
		button.mouseDown.remove(onButtonDown);
		OCore.instance.onStageMouseLeave.remove(onLeftStage);
		super.destroy();
	}

	override public function getStyleId():String
	{
		return SliderBaseStyle.styleString;
	}

}

/**
* SliderBaseStyle to setup unique id
*/
class SliderBaseStyle extends OBackgroundStyle
{
	public static var styleString:String = "SliderBaseStyle";

	public var buttonStyle:OButtonBaseStyle;

	public var defaultVHeight:Float;
	public var defaultVWidth:Float;

	public var defaultHHeight:Float;
	public var defaultHWidth:Float;

	public var defaultType:Int;
	
	public var defaultStep:Int;
	public var defaultValue:Int;
	private var defaultMax:Float;
	private var defaultMin:Float;

	public function new()
	{
		super();
		styleID = styleString;
	}

	override public function initStyle(value:IOComponent):Void
	{
		super.initStyle(value);
		
		var styleAs = cast (value, Slider);
		styleAs._type = defaultType;
		styleAs.step = defaultStep;
		styleAs._value = defaultValue;
		styleAs._max = defaultMax;
		styleAs._min = defaultMin;
		
		if(value._width == defaultWidth && value._height == defaultHeight)
		{
			if(defaultType == Slider.VERTICALLY)
			{
				value._width = defaultVWidth;
			}
			else
			{
				value._width = defaultHWidth;
			}

			if(defaultType == Slider.VERTICALLY)
			{
				value._height = defaultVHeight;
			}
			else
			{
				value._height = defaultHHeight;
			}
		}
	}

}