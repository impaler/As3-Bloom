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
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import bloom.brushes.BMPBrush;
	import bloom.brushes.ColorBrush;
	import bloom.core.Component;
	import bloom.core.ScaleBitmap;
	import bloom.themes.ThemeBase;
	
	/**
	 * FormItem
	 * 
	 * @date 2012/1/10 20:11
	 * @author sindney
	 */
	public class FormItem extends Component {
		
		protected var _data:Array = null;
		protected var _selected:Boolean = false;
		
		protected var _bg:Shape;
		
		public function FormItem(p:DisplayObjectContainer = null) {
			super(p);
			
			_bg = new Shape();
			addChild(_bg);
			
			size(100, 20);
			
			tabChildren = false;
			addEventListener(MouseEvent.CLICK, onMouseClick);
		}
		
		/**
		 * Call this when data:Array is modified.
		 */
		public function dataChanged():void {
			_changed = true;
			invalidate();
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
				_bg.graphics.beginFill(colorBrush.colors[_selected ? 0 : 1]);
			} else if (brush is BMPBrush) {
				bmpBrush = brush as BMPBrush;
				scale = bmpBrush.bitmap[_selected ? 0 : 1];
				scale.setSize(_width, _height);
				_bg.graphics.beginBitmapFill(scale.bitmapData);
			}
			
			_bg.graphics.drawRect(0, 0, _width, _height);
			_bg.graphics.endFill();
		}
		
		private function onMouseClick(e:MouseEvent):void {
			selected = !_selected;
		}
		
		///////////////////////////////////
		// getter/setters
		///////////////////////////////////
		
		public function set data(a:Array):void {
			if (_data != a) {
				_data = a;
				_changed = true;
				invalidate();
			}
		}
		
		public function get data():Array {
			return _data;
		}
		
		public function set selected(value:Boolean):void {
			if (_selected != value) {
				_selected = value;
				_changed = true;
				invalidate();
			}
		}
		
		public function get selected():Boolean {
			return _selected;
		}
		
		///////////////////////////////////
		// toString
		///////////////////////////////////
		
		override public function toString():String {
			return "[bloom.FormItem]";
		}
	}

}