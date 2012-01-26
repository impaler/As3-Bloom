/**
 * Copyright (c) 2012 - 2100 Sindney
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
	import flash.display.DisplayObjectContainer;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;

	import bloom.brushes.BMPBrush;
	import bloom.brushes.ColorBrush;
	import bloom.core.ButtonBase;
	import bloom.core.Component;
	import bloom.core.ScaleBitmap;
	import bloom.themes.ThemeBase;

	/**
	 * Dispatched when the value has changed.
	 * @eventType flash.events.Event
	 */
	[Event(name = "change", type = "flash.events.Event")]

	/**
	 * Dispatched when scrolling.
	 * @eventType flash.events.Event
	 */
	[Event(name = "scroll", type = "flash.events.Event")]

	/**
	 * Slider
	 *
	 * @author sindney
	 */
	public class Slider extends Component {
		
		public static const VERTICALLY:int = 0;
		public static const HORIZONTALLY:int = 1;
		
		public var step:Number = 10;
		
		protected var _bg:Sprite;
		protected var _bt:ButtonBase;
		
		protected var _mouseWheelTarget:DisplayObject;
		
		protected var _value:Number;
		protected var _max:Number;
		protected var _min:Number;
		protected var _rect:Rectangle;
		protected var _type:int;
		
		public function Slider(p:DisplayObjectContainer = null, type:int = 0, value:Number = 0, max:Number = 100, min:Number = 0) {
			super(p);
			
			_bg = new Sprite();
			_bg.buttonMode = true;
			_bg.tabEnabled = tabEnabled = false;
			
			_type = type;
			_max = max;
			_min = min;
			_value = value;
			
			addChild(_bg);
			
			_bt = new ButtonBase(this);
			_bt.brush = ThemeBase.SliderButton;
			
			brush = ThemeBase.Slider;
			
			_rect = new Rectangle(0, 0, 0, 0);
			
			_type == VERTICALLY ? size(20, 100) : size(100, 20);
			
			_bt.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			_bg.addEventListener(MouseEvent.MOUSE_DOWN, clickOnBg);
			addEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheel);
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
			
			if (brush is ColorBrush) {
				colorBrush = brush as ColorBrush;
				_bg.graphics.beginFill(colorBrush.colors[0]);
			} else if (brush is BMPBrush) {
				bmpBrush = brush as BMPBrush;
				scale = bmpBrush.bitmap[0];
				scale.setSize(_width, _height);
				_bg.graphics.beginBitmapFill(scale.bitmapData);
			}
			
			_bg.graphics.drawRect(0, 0, _width, _height);
			_bg.graphics.endFill();
			
			refresh();
		}
		
		protected function refresh():void {
			if (_type == HORIZONTALLY) {
				_bt.size(_height, _height);
				_rect.width = _width - _height;
				_bt.move((_value - _min) / (_max - _min) * _rect.width, 0);
			} else {
				_bt.size(_width, _width);
				_rect.height = _height - _width;
				_bt.move(0, _rect.height - (_value - _min) / (_max - _min) * _rect.height);
			}
		}
		
		protected function fixValue():void {
			if (_max > _min) {
				if (_value > _max)_value = _max;
				if (_value < _min)_value = _min;
			} else {
				_value = _min = _max;
			}
		}
		
		///////////////////////////////////
		// Mouse Handle
		///////////////////////////////////
		
		protected function onMouseDown(e:MouseEvent):void {
			_bt.startDrag(false, _rect);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		}
		
		protected function onMouseMove(e:MouseEvent):void {
			if (_type == HORIZONTALLY) {
				_value = _bt.x / (_width - _height) * (_max - _min) + _min;
			} else {
				_value = (_height - _width - _bt.y) / (_height - _width) * (_max - _min) + _min;
			}
            e.updateAfterEvent();
			
			fixValue();
			dispatchEvent(new Event("scroll"));
		}
		
		protected function onMouseUp(e:MouseEvent):void {
			_bt.stopDrag();
			dispatchEvent(new Event("change"));
			stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
		}
		
		protected function clickOnBg(e:MouseEvent):void {
			if (_type == HORIZONTALLY) {
				value = ((mouseX - (_height >> 1)) / (_width - _height)) * (_max - _min) + _min;
			} else {
				value = (_height - (_width >> 1) - mouseY) / (_height - _width) * (_max - _min) + _min;
			}
            _bt.startDrag(false, _rect);
            stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
            stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			
            e.updateAfterEvent();
		}
		
        protected function onMouseWheel(e:MouseEvent):void {
			// step does the same thing as wheelSensitivity method.
            value += (e.delta > 0 ? step : - step);
            e.updateAfterEvent();
		}
		
		///////////////////////////////////
		// getter/setters
		//////////////////////////////////
		
		public function set mouseWheelTarget(value:DisplayObject):void {
			if (_mouseWheelTarget != value) {
				if (_mouseWheelTarget) _mouseWheelTarget.removeEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheel);
				_mouseWheelTarget = value;
				if (_mouseWheelTarget) _mouseWheelTarget.addEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheel);
			}
		}
		
		public function get mouseWheelTarget():DisplayObject {
			return _mouseWheelTarget;
		}
		
		public function get button():ButtonBase {
			return _bt;
		}
		
		public function set max(value:Number):void {
			if (_max != value) {
				_max = value;
				fixValue();
				refresh();
			}
		}
		
		public function get max():Number {
			return _max;
		}
		
		public function set min(value:Number):void {
			if (_min != value) {
				_min = value;
				fixValue();
				refresh();
			}
		}
		
		public function get min():Number {
			return _min;
		}
		
		public function set value(value:Number):void {
			if (_value != value) {
				_value = value;
				fixValue();
				refresh();
				dispatchEvent(new Event("change"));
			}
		}
		
		public function get value():Number {
			return _value;
		}
		
		public function set type(value:int):void {
			if (_type != value) {
				_type = value;
				_rect = new Rectangle(0, 0, 0, 0);
				_changed = true;
				invalidate();
			}
		}
		
		public function get type():int {
			return _type;
		}
		
		///////////////////////////////////
		// toString
		///////////////////////////////////
		
		override public function toString():String {
			return "[bloom.Slider]";
		}
	}

}
