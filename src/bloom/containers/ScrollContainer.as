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

	import bloom.brushes.BMPBrush;
	import bloom.brushes.ColorBrush;
	import bloom.core.IChild;
	import bloom.core.ScaleBitmap;
	import bloom.themes.ThemeBase;
	import bloom.ScrollBar;

	/**
	 * ScrollContainer
	 *
	 * @date 2012/1/21 10:30
	 * @author sindney
	 */
	public class ScrollContainer extends FlowContainer {

		public static const VERTICALLY:int = 0;
		public static const HORIZONTALLY:int = 1;

		private var h_scrollBar_enabled:Boolean;
		private var v_scrollBar_enabled:Boolean;

		private var h_scrollBar:ScrollBar;
		private var v_scrollBar:ScrollBar;

		private var _rect:Rectangle;
		private var _content:Sprite;
		private var _bg:Sprite;

		public function ScrollContainer(p:DisplayObjectContainer = null) {

            _rect = new Rectangle(0, 0, 100, 100);

            _bg = new Sprite();
            addChild(_bg);

            _content = new Sprite();
            _content.scrollRect = _rect;
            addChild(_content);

            h_scrollBar = new ScrollBar(null, HORIZONTALLY);
            h_scrollBar.autoHide = false;
            h_scrollBar.step = 20;
            h_scrollBar.addEventListener(Event.CHANGE, onHScrollBarMove);
            h_scrollBar.addEventListener(Event.SCROLL, onHScrollBarMove);

            v_scrollBar = new ScrollBar(null, VERTICALLY);
            v_scrollBar.autoHide = false;
            v_scrollBar.step = 20;
            v_scrollBar.addEventListener(Event.CHANGE, onVScrollBarMove);
            v_scrollBar.addEventListener(Event.SCROLL, onVScrollBarMove);

            super(p);

			graphics.clear();

            _target = _content;

			h_scrollBar_enabled = v_scrollBar_enabled = true;

			setContentSize(100, 100);

			drawDirectly();
		}

        override public function setCoreBrush ():void {
            brush = ThemeBase.ScrollContainer;
            h_scrollBar.brush = ThemeBase.SC_ScrollBar;
            h_scrollBar.button.brush = ThemeBase.SC_ScrollBarButton;
            v_scrollBar.brush = ThemeBase.SC_ScrollBar;
            v_scrollBar.button.brush = ThemeBase.SC_ScrollBarButton;
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
			var component:IChild;
			var i:int, j:int = _content.numChildren;
			for (i = 0; i < j; i++) {
				object = _content.getChildAt(i);
				if (object is IChild) {
					component = object as IChild;
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

			h_scrollBar.move(0, _height - 20);
			v_scrollBar.move(_width - 20, 0);

			setScrollBar(h_scrollBar_enabled, v_scrollBar_enabled);

			update();
		}

		private function onVScrollBarMove(e:Event):void {
			if (v_scrollBar_enabled) {
				_rect.y = v_scrollBar.value;
				_content.scrollRect = _rect;
			}
		}

		private function onHScrollBarMove(e:Event):void {
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
