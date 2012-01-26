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
	import flash.events.FocusEvent;
	
	import bloom.brushes.BMPBrush;
	import bloom.brushes.ColorBrush;
	import bloom.core.Component;
	import bloom.core.ScaleBitmap;
	import bloom.core.TextBase;
	import bloom.themes.ThemeBase;
	
	/**
	 * TextInput
	 * 
	 * @author sindney
	 */
	public class TextInput extends Component {
		
		protected var _bg:Shape;
		protected var _textBase:TextBase;
		
		public function TextInput(p:DisplayObjectContainer = null, text:String = "") {
			super(p);
			
			_bg = new Shape();
			addChild(_bg);
			
			_textBase = new TextBase(this);
			_textBase.selectable = true;
			_textBase.multiline = false;
			_textBase.type = "input";
			_textBase.brush = ThemeBase.Text_TextInput;
			_textBase.text = text;
			
			brush = ThemeBase.TextInput;
			
			size(100, 20);
			
			_textBase.addEventListener(FocusEvent.FOCUS_IN, onFocusIn);
			_textBase.addEventListener(FocusEvent.FOCUS_OUT, onFocusOut);
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
			
			_textBase.size(_width, _height);
		}
		
		///////////////////////////////////
		// protected methods
		///////////////////////////////////
		
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
		
		override public function set enabled(value:Boolean):void {
			if (_enabled != value) {
				_enabled = _textBase.tabEnabled = mouseEnabled = mouseChildren = value;
				alpha = _enabled ? 1 : ThemeBase.ALPHA;
			}
		}
		
		public function set text(value:String):void {
			_textBase.text = value;
		}
		
		public function get text():String {
			return _textBase.text;
		}
		
		public function get textBase():TextBase {
			return _textBase;
		}
		
		///////////////////////////////////
		// toString
		///////////////////////////////////
		
		override public function toString():String {
			return "[bloom.TextInput]";
		}
	}

}