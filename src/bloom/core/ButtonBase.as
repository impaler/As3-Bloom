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
package bloom.core 
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import bloom.brushes.BMDBrush;
	import bloom.brushes.ColorBrush;
	import bloom.core.ScaleBitmap;
	import bloom.events.BrushEvent;
	import bloom.themes.ThemeBase;
	
	/**
	 * ButtonBase
	 * 
	 * @date 2012/1/10 20:17
	 * @author sindney
	 */
	public class ButtonBase extends Component {
		
		public static const UP:int = 0;
		public static const OVER:int = 1;
		public static const DOWN:int = 2;
		
		protected var _state:int = 0;
		protected var _bg:Shape;
		
		public function ButtonBase(p:DisplayObjectContainer = null) {
			super(p);
			buttonMode = true;
			tabEnabled = false;
			
			_bg = new Shape();
			addChild(_bg);
			
			brush = ThemeBase.Button;
			
			size(100, 20);
			
			addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
		}
		
		override protected function draw(e:Event):void {
			if (_changed) {
				_changed = false;
			} else {
				return;
			}
			
			var bmdBrush:BMDBrush;
			var colorBrush:ColorBrush;
			var scale:ScaleBitmap;
			
			_bg.graphics.clear();
			
			if (brush is ColorBrush) {
				colorBrush = brush as ColorBrush;
				switch(_state) {
					case 0:
						_bg.graphics.beginFill(colorBrush.colors[0]);
						break;
					case 1:
						_bg.graphics.beginFill(colorBrush.colors[1]);
						break;
					case 2:
						_bg.graphics.beginFill(colorBrush.colors[2]);
						break;
				}
			} else if (brush is BMDBrush) {
				bmdBrush = brush as BMDBrush;
				switch(_state) {
					case 0:
						scale = bmdBrush.bitmapData[0];
						scale.setSize(_width, _height);
						_bg.graphics.beginBitmapFill(scale.bitmapData);
						break;
					case 1:
						scale = bmdBrush.bitmapData[1];
						scale.setSize(_width, _height);
						_bg.graphics.beginBitmapFill(scale.bitmapData);
						break;
					case 2:
						scale = bmdBrush.bitmapData[2];
						scale.setSize(_width, _height);
						_bg.graphics.beginBitmapFill(scale.bitmapData);
						break;
				}
			}
			
			_bg.graphics.drawRect(0, 0, _width, _height);
			_bg.graphics.endFill();
		}
		
		protected function onMouseOver(e:MouseEvent):void {
			if (_state != OVER) {
				_state = OVER;
				_changed = true;
				invalidate();
				addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			}
		}
		
		protected function onMouseDown(e:MouseEvent):void {
			if (_state != DOWN) {
				_state = DOWN;
				_changed = true;
				invalidate();
				stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
				removeEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			}
		}
		
		protected function onMouseUp(e:MouseEvent):void {
			_state = UP;
			_changed = true;
			invalidate();
			addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			removeEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			stage.removeEventListener (MouseEvent.MOUSE_UP, onMouseUp);
		}
		
		protected function onMouseOut(e:MouseEvent):void {
			if (_state != DOWN) onMouseUp(e);
		}
		
		///////////////////////////////////
		// getter/setters
		///////////////////////////////////
		
		public function get state():int {
			return _state;
		}
		
		///////////////////////////////////
		// toString
		///////////////////////////////////
		
		public override function toString():String {
			return "[bloom.core.ButtonBase]";
		}
	}

}