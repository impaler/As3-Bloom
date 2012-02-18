package bloom.components 
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import org.osflash.signals.Signal;
	
	import bloom.control.ThemeBase;
	import bloom.core.Component;
	import bloom.core.TextBase;
	import bloom.themes.default.NumericStepperStyle;
	
	/**
	 * NumericStepper
	 */
	public class NumericStepper extends Component {
		
		public var step:Number;
		
		private var _value:Number;
		private var _max:Number;
		private var _min:Number;
		
		private var _increasing:Boolean;
		private var _timer:Timer;
		
		private var _bg:Shape;
		private var _textBase:TextBase;
		
		private var _increase_shape:Shape;
		private var _decrease_shape:Shape;
		
		private var _increase:ButtonBase;
		private var _decrease:ButtonBase;
		
		private var _signalChanged:Signal;
		
		private var _focused:Boolean = false;
		
		public function NumericStepper(p:DisplayObjectContainer = null, value:Number = 0, max:Number = 1000, min:Number = -1000, step:Number = 1) {
			super(p);
			
			this.step = step;
			
			_signalChanged = new Signal();
			
			_bg = new Shape();
			addChild(_bg);
			
			_textBase = new TextBase(this);
			_textBase.selectable = true;
			_textBase.multiline = false;
			_textBase.type = "input";
			_textBase.restrict = "0-9.\\-";
			_textBase.addEventListener(Event.CHANGE, onTextChange);
			
			_increase = new ButtonBase(this);
			_increase.addEventListener(MouseEvent.CLICK, onIncreaseClick);
			_increase.addEventListener(MouseEvent.MOUSE_DOWN, onIncreasePress);
			
			_decrease = new ButtonBase(this);
			_decrease.addEventListener(MouseEvent.CLICK, onDecreaseClick);
			_decrease.addEventListener(MouseEvent.MOUSE_DOWN, onDecreasePress);
			
			_increase_shape = new Shape();
			_increase.addChild(_increase_shape);
			_decrease_shape = new Shape();
			_decrease.addChild(_decrease_shape);
			
			style = ThemeBase.theme.numericStepper;
			
			_max = max;
			_min = min;
			_value = value;
			fixValue();
			
			_timer = new Timer(1000);
			_timer.addEventListener(TimerEvent.TIMER, onTimerTick);
			
			size(100, 20);
			
			_textBase.addEventListener(FocusEvent.FOCUS_IN, onFocusIn);
			_textBase.addEventListener(FocusEvent.FOCUS_OUT, onFocusOut);
			addEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheel);
		}
		
		private function onMouseWheel(e:MouseEvent):void {
			value += (e.delta > 0 ? 1 : -1) * step;
		}
		
		private function onTextChange(e:Event):void {
			if (Number(_textBase.text) is Number && !isNaN(Number(_textBase.text))) {
				value = Number(_textBase.text);
			} else {
				_textBase.text = value.toString();
			}
		}
		
		private function onTimerTick(e:TimerEvent):void {
			_timer.delay = 100;
			value += _increasing ? step : -step;
		}
		
		private function onIncreaseClick(e:MouseEvent):void {
			value += step;
		}
		
		private function onDecreaseClick(e:MouseEvent):void {
			value -= step;
		}
		
		private function onIncreasePress(e:MouseEvent):void {
			_increasing = true;
			_timer.reset();
			_timer.start();
			stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		}
		
		private function onDecreasePress(e:MouseEvent):void {
			_increasing = false;
			_timer.reset();
			_timer.start();
			stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		}
		
		private function onMouseUp(e:MouseEvent):void {
			stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			_timer.stop();
			_timer.delay = 1000;
		}
		
		protected function onThemeChanged():void {
			style = ThemeBase.theme.numericStepper;
		}
		
		override protected function draw(e:Event):void {
			if (_changed) {
				_changed = false;
			} else {
				return;
			}
			
			var style:NumericStepperStyle = _style as NumericStepperStyle;
			
			_increase_shape.graphics.clear();
			_decrease_shape.graphics.clear();
			
			_increase.style = style.bt_increase;
			_decrease.style = style.bt_decrease;
			
			_increase.x = _decrease.x = _width - _height;
			_increase.width = _decrease.width = _height;
			_increase.height = _decrease.height = _decrease.y = _height * 0.5;
			
            _increase_shape.graphics.beginFill(0xffffff);
            _increase_shape.graphics.moveTo(3, 0);
            _increase_shape.graphics.lineTo(6, 5);
            _increase_shape.graphics.lineTo(0, 5);
            _increase_shape.graphics.lineTo(3, 0);
            _increase_shape.graphics.endFill();
			
            _decrease_shape.graphics.beginFill(0xffffff);
            _decrease_shape.graphics.moveTo(0, 0);
            _decrease_shape.graphics.lineTo(6, 0);
            _decrease_shape.graphics.lineTo(3, 5);
            _decrease_shape.graphics.lineTo(0, 0);
            _decrease_shape.graphics.endFill();
			
            _increase_shape.x = (_increase.width - _increase_shape.width) * 0.5;
            _increase_shape.y = (_increase.height - _increase_shape.height) * 0.5;
            _decrease_shape.x = (_decrease.width - _decrease_shape.width) * 0.5;
            _decrease_shape.y = (_decrease.height - _decrease_shape.height) * 0.5;
			
			_bg.graphics.clear();
			if (_focused) {
				style.active.setSize(_width - _height, _height);
				_bg.graphics.beginBitmapFill(style.active.bitmapData);
				_textBase.style = style.text_active;
			} else {
				style.normal.setSize(_width - _height, _height);
				_bg.graphics.beginBitmapFill(style.normal.bitmapData);
				_textBase.style = style.text_normal;
			}
			_bg.graphics.drawRect(0, 0, _width - _height, _height);
			_bg.graphics.endFill();
			
			_textBase.size(_width - _height, _height);
		}
		
		protected function fixValue():void {
			if (_max > _min) {
				if (_value > _max)_value = _max;
				if (_value < _min)_value = _min;
			} else {
				_value = _min = _max;
			}
			_textBase.text = String(_value);
			_signalChanged.dispatch();
		}
		
		protected function onFocusIn(e:FocusEvent):void {
			_focused = true;
			_changed = true;
			invalidate();
		}
		
		protected function onFocusOut(e:FocusEvent):void {
			_focused = false;
			_changed = true;
			invalidate();
		}
		
		///////////////////////////////////
		// getter/setters
		///////////////////////////////////
		
		override public function set enabled(value:Boolean):void {
			if (_enabled != value) {
				_enabled = _textBase.tabEnabled = mouseEnabled = mouseChildren = value;
				alpha = _enabled ? 1 : ThemeBase.theme.alpha;
			}
		}
		
		public function get textBase():TextBase {
			return _textBase;
		}
		
		public function set value(value:Number):void {
			if (_value != value) {
				_value = value;
				fixValue();
			}
		}
		
		public function get value():Number {
			return _value;
		}
		
		public function set max(value:Number):void {
			if (_max != value) {
				_max = value;
				fixValue();
			}
		}
		
		public function get max():Number {
			return _max;
		}
		
		public function set min(value:Number):void {
			if (_min != value) {
				_min = value;
				fixValue();
			}
		}
		
		public function get min():Number {
			return _min;
		}
		
		public function get signalChanged():Signal {
			return _signalChanged;
		}
		
		///////////////////////////////////
		// toString
		///////////////////////////////////
		
		override public function toString():String {
			return "[bloom.components.NumericStepper]";
		}
		
	}

}
