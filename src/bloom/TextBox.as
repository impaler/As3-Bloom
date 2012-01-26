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
	import flash.events.MouseEvent;
	import flash.text.TextFormat;
	
	import bloom.brushes.BMPBrush;
	import bloom.brushes.ColorBrush;
	import bloom.core.Component;
	import bloom.core.TextBase;
	import bloom.core.ScaleBitmap;
	import bloom.events.BrushEvent;
	import bloom.themes.ThemeBase;
	import bloom.ScrollBar;
	
	/**
	 * TextBox
	 * 
	 * @author sindney
	 */
	public class TextBox extends Component {
		
		private var _scrollBar:ScrollBar;
		private var _textBase:TextBase;
		private var _bg:Shape;
		
		private var moving:Boolean = false;
		private var _editable:Boolean = true;
		
		public function TextBox(p:DisplayObjectContainer = null, text:String = "", editable:Boolean = true) {
			super(p);
			
			_bg = new Shape();
			addChild(_bg);
			
			_textBase = new TextBase(this);
			_textBase.multiline = true;
			_textBase.wordWrap = true;
			_textBase.selectable = true;
			_textBase.brush = ThemeBase.Text_TextBox;
			_textBase.text = text;
			_textBase.addEventListener(Event.CHANGE, onTextChange);
			_textBase.addEventListener(Event.SCROLL, onTextScroll);
			_textBase.addEventListener(FocusEvent.FOCUS_IN, onFocusIn);
			_textBase.addEventListener(FocusEvent.FOCUS_OUT, onFocusOut);
			_textBase.addEventListener(BrushEvent.REDRAW, onTextChange);
			
			_scrollBar = new ScrollBar(this, 0, 0, 0);
			_scrollBar.brush = ThemeBase.TB_ScrollBar;
			_scrollBar.button.brush = ThemeBase.TB_ScrollBarButton;
			_scrollBar.step = 1;
			_scrollBar.autoHide = false;
			_scrollBar.addEventListener(Event.CHANGE, onScrollBarChange);
			_scrollBar.addEventListener(Event.SCROLL, onScrollBarMove);
			
			brush = ThemeBase.TextBox;
			
			this.editable = editable;
			
			size(100, 100);
		}
		
		public function appendText(text:String):void {
			_textBase.appendText(text);
			onTextChange();
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
			
			_textBase.tabEnabled = _enabled;
			_textBase.size(_width - 20, _height);
			
			_scrollBar.size(20, _height);
			_scrollBar.move(_width - 20, 0);
			
			onScrollBarChange();
			onTextChange();
		}
		
		///////////////////////////////////
		// scrollBar handles
		///////////////////////////////////
		
		private function onScrollBarChange(e:Event = null):void {
			_textBase.scrollV = _scrollBar.value + 1;
			moving = false;
		}
		
		private function onScrollBarMove(e:Event = null):void {
			_textBase.scrollV = _scrollBar.value + 1;
			moving = true;
		}
		
		///////////////////////////////////
		// text handle
		///////////////////////////////////
		
		private function onTextChange(e:Event = null):void {
			_scrollBar.pageSize = _textBase.numLines - _textBase.maxScrollV + 1;
			_scrollBar.contentSize = _textBase.numLines;
		}
		
		private function onTextScroll(e:Event = null):void {
			if (!moving) _scrollBar.value = _textBase.scrollV - 1;
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
		
		override public function set enabled(value:Boolean):void {
			if (_enabled != value) {
				_enabled = _textBase.tabEnabled = mouseEnabled = mouseChildren = value;
				alpha = _enabled ? 1 : ThemeBase.ALPHA;
			}
		}
		
		public function get scrollBar():ScrollBar {
			return _scrollBar;
		}
		
		public function get textBase():TextBase {
			return _textBase;
		}
		
		public function set text(value:String):void {
			_textBase.text = value;
			onTextChange();
		}
		
		public function get text():String {
			return _textBase.text;
		}
		
		public function set editable(value:Boolean):void {
			_editable = value;
			_textBase.type = _editable ? "input" : "dynamic";
		}
		
		public function get editable():Boolean {
			return _editable;
		}
		
		///////////////////////////////////
		// toString
		///////////////////////////////////
		
		override public function toString():String {
			return "[bloom.TextBox]";
		}
		
	}

}