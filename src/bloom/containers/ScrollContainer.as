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
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Rectangle;
	
	import bloom.brushes.BMDBrush;
	import bloom.brushes.ColorBrush;
	import bloom.core.IComponent;
	import bloom.core.ThemeBase;
	import bloom.ScrollBar;
	
	/**
	 * ScrollContainer
	 * 
	 * @date 2012/1/14 22:36
	 * @author sindney
	 */
	public class ScrollContainer extends FlowContainer {
		
		public static const VERTICALLY:int = 0;
		public static const HORIZONTALLY:int = 1;
		
		protected var h_scrollBar_enabled:Boolean;
		protected var v_scrollBar_enabled:Boolean;
		
		protected var h_scrollBar:ScrollBar;
		protected var v_scrollBar:ScrollBar;
		
		protected var _rect:Rectangle;
		protected var _content:Sprite;
		protected var _bg:Sprite;
		
		public function ScrollContainer(p:DisplayObjectContainer = null) {
			super(p);
			graphics.clear();
			
			_rect = new Rectangle(0, 0, 100, 100);
			
			_bg = new Sprite();
			addChild(_bg);
			
			_content = new Sprite();
			_content.scrollRect = _rect;
			addChild(_content);
			
			_target = _content;
			
			h_scrollBar = new ScrollBar(null, "h");
			h_scrollBar.autoHide = false;
			h_scrollBar.step = 20;
			h_scrollBar.brush = ThemeBase.SC_ScrollBar;
			h_scrollBar.button.brush = ThemeBase.SC_ScrollBarButton;
			h_scrollBar.addEventListener(Event.CHANGE, onHScrollBarMove);
			h_scrollBar.addEventListener(Event.SCROLL, onHScrollBarMove);
			
			v_scrollBar = new ScrollBar(null, "v");
			v_scrollBar.autoHide = false;
			v_scrollBar.step = 20;
			v_scrollBar.brush = ThemeBase.SC_ScrollBar;
			v_scrollBar.button.brush = ThemeBase.SC_ScrollBarButton;
			v_scrollBar.addEventListener(Event.CHANGE, onVScrollBarMove);
			v_scrollBar.addEventListener(Event.SCROLL, onVScrollBarMove);
			
			brush = ThemeBase.ScrollContainer;
			
			h_scrollBar_enabled = v_scrollBar_enabled = true;
			
			setContentSize(100, 100);
			
			size(100, 100);
		}
		
		public function getScrollBar(direction:int):ScrollBar {
			var result:ScrollBar;
			if (direction == VERTICALLY) result = v_scrollBar;
			if (direction == HORIZONTALLY) result = h_scrollBar;
			return result;
		}
		
		public function setScrollBar(horizontal:Boolean, vertical:Boolean):void {
			h_scrollBar_enabled = horizontal;
			v_scrollBar_enabled = vertical;
			
			if (horizontal) {
				if (vertical) {
					_rect.width = _width - 20;
					_rect.height = _height - 20;
					h_scrollBar.size(_width - 20, 20);
					v_scrollBar.size(20, _height - 20);
					v_scrollBar.mouseWheelTarget = _bg;
					if (!v_scrollBar.parent) addChild(v_scrollBar);
				} else {
					_rect.width = _width;
					_rect.height = _height - 20;
					h_scrollBar.size(_width, 20);
					v_scrollBar.size(0, 0);
					v_scrollBar.mouseWheelTarget = null;
					if (v_scrollBar.parent) removeChild(v_scrollBar);
				}
				if (!h_scrollBar.parent) addChild(h_scrollBar);
			} else {
				if (vertical) {
					_rect.width = _width - 20;
					_rect.height = _height;
					h_scrollBar.size(0, 0);
					v_scrollBar.size(20, _height);
					v_scrollBar.mouseWheelTarget = _bg;
					if (!v_scrollBar.parent) addChild(v_scrollBar);
				} else {
					_rect.width = _width;
					_rect.height = _height;
					h_scrollBar.size(0, 0);
					v_scrollBar.size(0, 0);
					v_scrollBar.mouseWheelTarget = null;
					if (v_scrollBar.parent) removeChild(v_scrollBar);
				}
				if (h_scrollBar.parent) removeChild(h_scrollBar);
			}
			
			h_scrollBar.pageSize = _rect.width;
			v_scrollBar.pageSize = _rect.height;
			
			_content.scrollRect = _rect;
		}
		
		public function setContentSize(width:Number, height:Number):void {
			h_scrollBar.contentSize = width;
			v_scrollBar.contentSize = height;
		}
		
		/**
		 * Calculate content's size by it's children's size and margin.
		 */
		public function calculateContentSize():void {
			var width:Number = 0;
			var height:Number = 0;
			
			var object:DisplayObject;
			var component:IComponent;
			var i:int, j:int = _content.numChildren;
			for (i = 0; i < j; i++) {
				object = _content.getChildAt(i);
				if (object is IComponent) {
					component = object as IComponent;
					if (_direction == HORIZONTALLY) {
						width += component.width + component.margin.left + component.margin.right;
						height = Math.max(component.height + component.margin.top + component.margin.bottom, height);
					} else if (_direction == VERTICALLY) {
						width = Math.max(component.width + component.margin.left + component.margin.right, width);
						height += component.height + component.margin.top + component.margin.bottom;
					}
				} else {
					if (_direction == HORIZONTALLY) {
						width += object.width;
						height = Math.max(object.height, height);
					} else if (_direction == VERTICALLY) {
						width = Math.max(object.width, width);
						height += object.height;
					}
				}
			}
			
			setContentSize(width, height);
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
			
			if (brush is ColorBrush) {
				colorBrush = brush as ColorBrush;
				_bg.graphics.beginFill(colorBrush.colors[0]);
			} else if (brush is BMDBrush) {
				bmdBrush = brush as BMDBrush;
				_bg.graphics.beginBitmapFill(bmdBrush.bitmapData[0], null, bmdBrush.repeat);
			}
			
			_bg.graphics.drawRect(0, 0, _width, _height);
			_bg.graphics.endFill();
			
			h_scrollBar.move(0, _height - 20);
			v_scrollBar.move(_width - 20, 0);
			
			setScrollBar(h_scrollBar_enabled, v_scrollBar_enabled);
			
			update();
		}
		
		protected function onVScrollBarMove(e:Event):void {
			if (v_scrollBar_enabled) {
				_rect.y = v_scrollBar.value;
				_content.scrollRect = _rect;
			}
		}
		
		protected function onHScrollBarMove(e:Event):void {
			if (h_scrollBar_enabled) {
				_rect.x = h_scrollBar.value;
				_content.scrollRect = _rect;
			}
		}
		
		///////////////////////////////////
		// getter/setters
		///////////////////////////////////
		
		public function get content():Sprite {
			return _content;
		}
		
		///////////////////////////////////
		// toString
		///////////////////////////////////
		
		override public function toString():String {
			return "[bloom.containers.ScrollContainer]";
		}
		
	}

}