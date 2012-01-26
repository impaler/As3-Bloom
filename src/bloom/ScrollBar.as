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
	import flash.events.Event;
	import flash.events.MouseEvent;

	/**
	 * ScrollBar
	 * 
	 * @author sindney
	 */
	public class ScrollBar extends Slider {
		
		private var _realSize:Number;
		private var _minSize:Number;
		private var _contentSize:Number;
		private var _pageSize:Number;
		
		private var _working:Boolean = true;
		private var _autoHide:Boolean = true;
		
		public function ScrollBar(p:DisplayObjectContainer = null, type:int = 0, page:Number = 100, content:Number = 100) {
			super(p, type, 0, content);
			
			_realSize = 0;
			_minSize = 20;
			_pageSize = page;
			_contentSize = content;
		}
		
		override protected function refresh():void {
			_max = Math.max(_contentSize - _pageSize, 0);
			if (_max > 0) {
				if (_type == HORIZONTALLY) {
					_realSize = (_pageSize * _width) / (_max + _pageSize);
					_bt.size(Math.max(_realSize, _minSize), _height);
					_rect.width = Math.ceil(_width - _bt.width);
					_bt.x = _value / _max * _rect.width;
					if (_bt.x + _bt.width > _width) _bt.x = _width - _bt.width;
				} else {
					_realSize = (_pageSize * _height) / (_max + _pageSize);
					_bt.size(_width, Math.max(_realSize, _minSize));
					_rect.height = Math.ceil(_height - _bt.height);
					_bt.y = _value / _max * _rect.height;
					if (_bt.y + _bt.height > _height) _bt.y = _height - _bt.height;
				}
				_working = true;
			} else {
				value = 0;
				_rect.width = 0;
				_rect.height = 0;
				_bt.move(0, 0);
				_bt.size(0, 0);
				if(_autoHide) _bg.graphics.clear();
				_working = false;
			}
		}
		
		///////////////////////////////////
		// Mouse Handle
		///////////////////////////////////
		
		override protected function onMouseMove(e:MouseEvent):void {
			if (_type == HORIZONTALLY) {
				_value = Math.ceil(_bt.x / _rect.width * _max);
			} else {
				_value = Math.ceil(_bt.y / _rect.height * _max);
			}
			fixValue();
            e.updateAfterEvent();
			
			dispatchEvent(new Event("scroll"));
		}
		
		override protected function clickOnBg(e:MouseEvent):void {
			if (_type == HORIZONTALLY) {
				value = (mouseX - (_bt.width >> 1)) / _rect.width * _max;
			} else {
				value = (mouseY - (_bt.height >> 1)) / _rect.height * _max;
			}
            _bt.startDrag(false, _rect);
            stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
            stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			
            e.updateAfterEvent();
			
            dispatchEvent(new Event("scroll"));
		}
		
		override protected function onMouseWheel(e:MouseEvent):void {
			if (_type == HORIZONTALLY) {
				value += e.delta > 0 ? step : - step;
			} else {
				value -= e.delta > 0 ? step : - step;
			}
            e.updateAfterEvent();
		}
		
		///////////////////////////////////
		// getter/setters
		///////////////////////////////////
		
		public function set contentSize(value:Number):void {
			if (_contentSize != value) {
				_contentSize = value;
				drawDirectly();
			}
		}
		
		public function get contentSize():Number {
			return _contentSize;
		}
		
		public function set pageSize(value:Number):void {
			if (_pageSize != value) {
				_pageSize = value;
				drawDirectly();
			}
		}
		
		public function get pageSize():Number {
			return _pageSize;
		}
		
		public function set minSize(value:Number):void {
			if (_minSize != value) {
				_minSize = value;
				refresh();
			}
		}
		
		public function get minSize():Number {
			return _minSize;
		}
		
		public function set autoHide(value:Boolean):void {
			if (_autoHide != value) {
				_autoHide = value;
				drawDirectly();
			}
		}
		
		public function get autoHide():Boolean {
			return _autoHide;
		}
		
		public function get working():Boolean {
			return _working;
		}
		
		///////////////////////////////////
		// toString
		///////////////////////////////////
		
		override public function toString():String {
			return "[bloom.ScrollBar]";
		}
		
	}

}
