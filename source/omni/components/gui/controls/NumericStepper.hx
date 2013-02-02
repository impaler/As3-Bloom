package omni.components.gui.controls;

import omni.components.core.interfaces.IOComponent;
import omni.components.core.OCore;
import omni.components.core.signals.OSignalMouse;
import omni.components.core.signals.OSignal;
import omni.components.core.OComponent;
import omni.components.core.OTextBase;
import omni.components.core.OButtonBase;
import omni.components.utils.ComponentUtils;
import omni.components.style.OBackgroundStyle;

import nme.utils.Timer;
import nme.events.TimerEvent;
import nme.events.MouseEvent;

class NumericStepper extends OComponent
{
	public var step:Int;

	public var value(getValue, setValue):Int;
	public var _value:Int;

	public var max(getMax, setMax):Int;
	public var _max:Int;

	public var min(getMin, setMin):Int;
	public var _min:Int;

	private var _increasing:Bool;
	private var _timer:Timer;

	private var _textBase:OTextBase;
	private var _increase:OButtonBase;
	private var _decrease:OButtonBase;

	public var mouseWheel:OSignalMouse;
	public var onChange(default, null):OSignal<Int -> Void>;

	override public function createMembers():Void
	{
		//todo move to style layer and finish TextBase
		_max = max;
		_min = min;
		_value = value;
		this.step = step;

		onChange = new OSignal();
		mouseWheel = new OSignalMouse(OSignalMouse.WHEEL, this.sprite);

		var thisStyle = cast(_style, NumericStepperStyle);

		_textBase = new OTextBase(thisStyle.textStyle);
		_textBase.trackTheme = false;
		add(_textBase);

		_increase = new OButtonBase(thisStyle.increaseButtonStyle);
		_increase.trackTheme = false;
		add(_increase);

		_decrease = new OButtonBase(thisStyle.decreaseButtonStyle);
		_decrease.trackTheme = false;
		add(_decrease);

		_timer = new Timer(1000);
		_timer.addEventListener(TimerEvent.TIMER, onTimerTick);
	}

	override public function enableSignals():Void
	{
		_increase.mouseDown.add(onIncreaseClick);
		_decrease.mouseDown.add(onDecreaseClick);
		mouseWheel.add(onMouseWheel);
	}

	override public function disableSignals():Void
	{
		_increase.mouseDown.remove(onIncreaseClick);
		_decrease.mouseDown.remove(onDecreaseClick);
	}

	private function onMouseWheel(e:MouseEvent):Void
	{
		value += (e.delta > 0 ? 1 : - 1) * step;
	}

	private function onTimerTick(e:TimerEvent):Void
	{
		_timer.delay = 100;
		value += _increasing ? step : - step;
	}

	private function onIncreaseClick(e:MouseEvent):Void
	{
		value += step;

		_increasing = true;
		_timer.reset();
		_timer.start();
		OCore.onStageMouseUp.addOnce(onMouseUp);
	}

	private function onDecreaseClick(e:MouseEvent):Void
	{
		value -= step;

		_increasing = false;
		_timer.reset();
		_timer.start();
		OCore.onStageMouseUp.addOnce(onMouseUp);
	}

	private function onMouseUp(e:MouseEvent):Void
	{
		_timer.stop();
		_timer.delay = 1000;
	}

	override public function draw():Void
	{
		super.draw();
		updatePositions();
	}

	public function updatePositions():Void
	{
		_increase._width = _height;
		_decrease._width = _height;

		_increase.x = _width - _increase.width;
		_decrease.x = _width - _decrease.width;

		_decrease.y = _height * 0.5;

		ComponentUtils.VAlignToOther(_textBase, this);
		ComponentUtils.HAlignToOther(_textBase, this);
	}

	public function fixValue():Void
	{
		if(_max > _min)
		{
			if(_value > _max)_value = _max;
			if(_value < _min)_value = _min;
		}
		else
		{
			_value = _min = _max;
		}
		_textBase.text = Std.string(_value);
	}

	public function getValue():Int
	{
		return _value;
	}

	public function setValue(value:Int):Int
	{
		if(_value != value)
		{
			_value = value;
			fixValue();
			invalidate();
			onChange.dispatch(_value);
		}
		return _value;
	}

	public function setMax(value:Int):Int
	{
		if(_max != value)
		{
			_max = value;
			fixValue();
			invalidate();
		}
		return _max;
	}

	public function getMax():Int
	{
		return _max;
	}

	public function setMin(value:Int):Int
	{
		if(_min != value)
		{
			_min = value;
			fixValue();
			invalidate();
		}
		return _min;
	}

	public function getMin():Int
	{
		return _min;
	}

	override public function getStyleId():String
	{
		return NumericStepperStyle.styleString;
	}

}

/**
* 
* Numeric Stepper style
* 
* 
*/
class NumericStepperStyle extends OBackgroundStyle
{

	public static var styleString:String = "NumericStepperStyle";
	public static var STATE_ACTIVE:String = "STATE_ACTIVE";

	public var increaseButtonStyle:OButtonBaseStyle;
	public var decreaseButtonStyle:OButtonBaseStyle;
	public var textStyle:OTextBaseStyle;

	public function new()
	{
		super();
		styleID = styleString;
	}

	override public function initStyle(value:IOComponent):Void
	{
		super.initStyle(value);

		var instance = cast ( value, NumericStepper);

		if(instance._textBase != null)
		{
			var stylethis = cast ( instance._style, NumericStepperStyle);
			instance._textBase.style = stylethis.textStyle;
			instance._increase.style = stylethis.increaseButtonStyle;
			instance._decrease.style = stylethis.decreaseButtonStyle;
		}

	}

}