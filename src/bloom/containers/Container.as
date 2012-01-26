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
package bloom.containers 
{	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	
	import bloom.brushes.BMPBrush;
	import bloom.brushes.Brush;
	import bloom.brushes.ColorBrush;
	import bloom.core.Component;
	import bloom.core.IComponent;
	import bloom.core.ScaleBitmap;
	import bloom.themes.ThemeBase;
	
	/**
	 * Conatiner
	 * 
	 * @author sindney
	 */
	public class Container extends Component {
		
		public function Container(p:DisplayObjectContainer = null) {
			super(p);
			brush = ThemeBase.Container;
			size(100, 100);
		}
		
		/**
		 * Update child's layout.
		 */
		public function update():void {
			
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
			
			graphics.clear();
			
			if (brush is ColorBrush) {
				colorBrush = brush as ColorBrush;
				graphics.beginFill(colorBrush.colors[0]);
			} else if (brush is BMPBrush) {
				bmpBrush = brush as BMPBrush;
				scale = bmpBrush.bitmap[0];
				scale.setSize(_width, _height);
				graphics.beginBitmapFill(scale.bitmapData);
			}
			
			graphics.drawRect(0, 0, _width, _height);
			graphics.endFill();
			
			update();
		}
		
		///////////////////////////////////
		// getter/setters
		///////////////////////////////////
		
		override public function set enabled(value:Boolean):void {
			if (_enabled != value) {
				_enabled = tabChildren = mouseEnabled = mouseChildren = value;
				
				// make changes in it's childs.
				var i:int;
				var child:DisplayObject;
				for (i = 0; i < numChildren; i++) {
					child = getChildAt(i);
					if (child is IComponent) (child as IComponent).enabled = value;
				}
			}
		}
		
		///////////////////////////////////
		// toString
		///////////////////////////////////
		
		override public function toString():String {
			return "[bloom.conatiners.Container]";
		}
		
	}

}