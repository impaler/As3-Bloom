/**
 * Copyright (c) 2011 - 2100 Impaler, Sindney
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */
package bloom 
{

import bloom.brushes.Brush;

import flash.display.DisplayObjectContainer;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import bloom.brushes.BMPBrush;
	import bloom.brushes.ColorBrush;
	import bloom.core.ButtonBase;
	import bloom.core.Component;
	import bloom.core.TextBase;
	import bloom.core.ScaleBitmap;
	import bloom.themes.ThemeBase;
	
	/**
	 * Dispatched when the value has changed.
	 * @eventType flash.events.Event
	 */
	[Event(name="change" , type="flash.events.Event")]
	
	/**
	 * NumericStepper
	 * 
	 * @date 2012/1/13 11:52
	 * @author impaler
	 */
	public class NumericStepper extends Component {
		
		public var step:Number;
		
		protected var _value:Number;
		protected var _max:Number;
		protected var _min:Number;
		
		protected var _increasing:Boolean;
		protected var _timer:Timer;
		
		protected var _bg:Shape;
		protected var _textBase:TextBase;
		
		protected var _increase_shape:Shape;
		protected var _decrease_shape:Shape;
		
		protected var _increase:ButtonBase;
		protected var _decrease:ButtonBase;
		
		public function NumericStepper(p:DisplayObjectContainer = null, value:Number = 0, max:Number = 1000, min:Number = -1000, step:Number = 1) {
			super(p);
			
			this.step = step;

            // Move to Effects Brush?
			_bg = new Shape();
//			_bg.filters = [ThemeBase.SHADOW];
			addChild(_bg);
			
			_textBase = new TextBase(this);
			_textBase.selectable = true;
			_textBase.multiline = false;
			_textBase.type = "input";
			_textBase.brush = ThemeBase.Text_NumericStepper;
			_textBase.restrict = "0-9.\\-";
			_textBase.addEventListener(Event.CHANGE, onTextChange);
			
			_increase = new ButtonBase(this);
			_increase.brush = ThemeBase.NS_INCREASE_Button;
			_increase.addEventListener(MouseEvent.CLICK, onIncreaseClick);
			_increase.addEventListener(MouseEvent.MOUSE_DOWN, onIncreasePress);
			
			_decrease = new ButtonBase(this);
			_decrease.brush = ThemeBase.NS_DECREASE_Button;
			_decrease.addEventListener(MouseEvent.CLICK, onDecreaseClick);
			_decrease.addEventListener(MouseEvent.MOUSE_DOWN, onDecreasePress);
			
			_increase_shape = new Shape();
			_increase.addChild(_increase_shape);
			_decrease_shape = new Shape();
			_decrease.addChild(_decrease_shape);
			
			brush = ThemeBase.NumericStepper;
			
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
		
		override protected function draw(e:Event):void {
			if (_changed) {
				_changed = false;
			} else {
				return;
			}
			
			var bmpBrush:BMPBrush;
			var colorBrush:ColorBrush;
			var scale:ScaleBitmap;
			
			_bg.graphics.clear();
			_increase_shape.graphics.clear();
			_decrease_shape.graphics.clear();
			
			_increase.x = _decrease.x = _width - _height;
			_increase.width = _decrease.width = _height;
			_increase.height = _decrease.height = _decrease.y = _height * 0.5;
			
			if (brush is ColorBrush) {
				colorBrush = brush as ColorBrush;
				_bg.graphics.beginFill(colorBrush.colors[0]);
				
				_increase_shape.graphics.beginFill(colorBrush.colors[1]);
				_increase_shape.graphics.moveTo(3, 0);
				_increase_shape.graphics.lineTo(6, 5);
				_increase_shape.graphics.lineTo(0, 5);
				_increase_shape.graphics.lineTo(3, 0);
				_increase_shape.graphics.endFill();
				
				_decrease_shape.graphics.beginFill(colorBrush.colors[1]);
				_decrease_shape.graphics.moveTo(0, 0);
				_decrease_shape.graphics.lineTo(6, 0);
				_decrease_shape.graphics.lineTo(3, 5);
				_decrease_shape.graphics.lineTo(0, 0);
				_decrease_shape.graphics.endFill();
				
				_increase_shape.x = (_increase.width - _increase_shape.width) * 0.5;
				_increase_shape.y = (_increase.height - _increase_shape.height) * 0.5;
				_decrease_shape.x = (_decrease.width - _decrease_shape.width) * 0.5;
				_decrease_shape.y = (_decrease.height - _decrease_shape.height) * 0.5;
			} else if (brush is BMPBrush) {
				bmpBrush = brush as BMPBrush;

                var _increase_size:BMPBrush = ThemeBase.NS_INCREASE_Button as BMPBrush;
                scale = _increase_size.bitmap[0];
                _increase.width = _decrease.width = scale.getOriginalBitmapData().width;
                _increase.height = _decrease.height = scale.getOriginalBitmapData().height;

				scale = bmpBrush.bitmap[0];
				scale.setSize(_width - _height, _height);
				_bg.graphics.beginBitmapFill(scale.bitmapData);
			}
			
			_bg.graphics.drawRect(0, 0, _width - _height, _height);
			_bg.graphics.endFill();

			_textBase.size(_width - _height, _textBase.height = _decrease.height);
            _textBase.y = _height*.5 - _textBase.height *.5;
            _textBase.x = 10;

		}
		
		protected function fixValue():void {
			if (_max > _min) {
				if (_value > _max)_value = _max;
				if (_value < _min)_value = _min;
				_textBase.text = String(_value);
				dispatchEvent(new Event("change"));
			} else {
				_value = _min = _max;
			}
		}
		
		protected function onFocusIn(e:FocusEvent):void {
			graphics.clear();
			graphics.lineStyle(2, ThemeBase.FOCUS);
			graphics.drawRect( -1, -1, _width + 2, _height + 2);
			graphics.endFill();
		}
		
		protected function onFocusOut(e:FocusEvent):void {
			graphics.clear();
		}
		
		///////////////////////////////////
		// getter/setters
		///////////////////////////////////
		
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
		
		///////////////////////////////////
		// toString
		///////////////////////////////////
		
		override public function toString():String {
			return "[bloom.NumericStepper]";
		}
		
	}

}
