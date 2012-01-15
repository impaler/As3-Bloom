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
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	
	import bloom.brushes.BMDBrush;
	import bloom.brushes.ColorBrush;
	import bloom.core.Component;
	import bloom.core.ThemeBase;
	
	[Event(name = "complete", type = "flash.events.Event")]
	
	/**
	 * ProgressBar
	 * 
	 * @date 2012/1/6 22:21
	 * @author sindney
	 */
	public class ProgressBar extends Component {
		
		private var _bg:Sprite;
		private var _progress:Shape;
		
		private var _value:int;
		
		public function ProgressBar(p:DisplayObjectContainer = null, value:int = 0) {
			super(p);
			
			_bg = new Sprite();
			_bg.filters = [ThemeBase.SHAOW];
			_progress = new Shape();
			addChild(_bg);
			addChild(_progress);
			
			_value = value;
			
			brush = ThemeBase.ProgressBar;
			
			size(100, 20);
		}
		
		override protected function draw(e:Event):void {
			if (_changed) {
				_changed = false;
			} else {
				return;
			}
			
			var bmdBrush:BMDBrush;
			var colorBrush:ColorBrush;
			
			_bg.graphics.clear();
			_progress.graphics.clear();
			
			if (brush is ColorBrush) {
				colorBrush = brush as ColorBrush;
				_bg.graphics.beginFill(colorBrush.colors[0]);
				_progress.graphics.beginFill(colorBrush.colors[1]);
			} else if (brush is BMDBrush) {
				bmdBrush = brush as BMDBrush;
				_bg.graphics.beginBitmapFill(bmdBrush.bitmapData[0], null, bmdBrush.repeat);
				_progress.graphics.beginBitmapFill(bmdBrush.bitmapData[1], null, bmdBrush.repeat);
			}
			
			_bg.graphics.drawRect(0, 0, _width, _height);
			_bg.graphics.endFill();
			
			_progress.graphics.drawRect(0, 0, 10, _height);
			_progress.graphics.endFill();
			
			update();
		}
		
		private function update():void {
			_value = Math.min(100, _value);
			_value = Math.max(0, _value);
			
			_progress.width = (_width * _value) * 0.01;
			_progress.height = height;
			
			if (_value == 100) dispatchEvent(new Event("complete"));
		}
		
		///////////////////////////////////
		// getter/setters
		///////////////////////////////////
		
		public function set value(value:int):void {
			if (_value != value) {
				_value = value;
				update();
			}
		}
		
		public function get value():int {
			return _value;
		}
		
		///////////////////////////////////
		// toString
		///////////////////////////////////
		
		override public function toString():String {
			return "[bloom.ProgressBar]";
		}
	}

}