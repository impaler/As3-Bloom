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
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;

	import bloom.brushes.BMPBrush;
	import bloom.brushes.Brush;
	import bloom.brushes.ColorBrush;
	import bloom.core.Component;
	import bloom.core.ScaleBitmap;
	import bloom.themes.ThemeBase;

	/**
	 * Dispatched when the target has changed.
	 * @eventType flash.events.Event
	 */
	[Event(name = "change", type = "flash.events.Event")]

	/**
	 * Form
	 * <p>It's just a base class for you to extend, so that you can create your own Form.</p>
	 *
	 * @date 2012/1/21 9:45
	 * @author sindney
	 */
	public class Form extends Component {

		protected var _data:Array;
		protected var _target:Array;
		protected var _index:int = 0;

		protected var _bg:Shape;
		protected var _content:Sprite;
		protected var _scrollBar:ScrollBar;

		protected var _itemHeight:int = 20;

		private var _pool:Array;
		private var _showLines:uint = 0;
		private var _lines:uint;

		/**
		 * Constructor
		 *
		 * @param	p Parent.
		 * @param	d An Array saving item's data.
		 */
		public function Form(p:DisplayObjectContainer = null, d:Array = null) {
			super(p);

			brush = ThemeBase.Form;

			_content = new Sprite();
			_bg = new Shape();

			_data = d;
			_pool = new Array();

			_scrollBar = new ScrollBar();
			_scrollBar.brush = ThemeBase.Form_ScrollBar;
			_scrollBar.button.brush = ThemeBase.Form_ScrollBarButton;
			_scrollBar.mouseWheelTarget = this;
			_scrollBar.step = 1;
			_scrollBar.autoHide = false;
			_scrollBar.addEventListener(Event.SCROLL, scroll);
			_scrollBar.addEventListener(Event.CHANGE, scroll);
			_scrollBar.width = 20;

			addChild(_bg);
			addChild(_content);
			addChild(_scrollBar);

			size(100, 100);
		}

		/**
		 * Use to change FormItems' Brush.
		 * @param	value
		 */
		public function changeItemsBrush(value:Brush):void {
			var tmp:*;
			var i:int, j:int = _content.numChildren;
			for (i = 0; i < j; i++) {
				tmp = _content.getChildAt(i);
				tmp.brush = value;
			}
			j = _pool.length;
			for (i = 0; i < j; i++) {
				tmp = _pool[i];
				tmp.brush = value;
			}
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

			_scrollBar.move(_width - 20, 0);
			_scrollBar.height = _height;

			update();
		}

		/**
		 * Call this once you modified the data array.
		 */
		public function update():void {
			if (_data) {
				refresh();
				scroll();
			}
		}

		///////////////////////////////////
		// protected methods
		///////////////////////////////////

		protected function newItem():* {
			return new FormItem();
		}

		///////////////////////////////////
		// private methods
		///////////////////////////////////

		private function refresh():void {

			// Calculate methods for scrollBar.
			var _old:int = _showLines;
			_lines = _data.length;
			_showLines = Math.min(_lines, Math.floor((_height) / (_itemHeight)));
			_old = _showLines - _old;

			_scrollBar.pageSize = _showLines;
			_scrollBar.contentSize = _lines;

			var tmp:*;
			var l:int = 0, i:int = 0;
			if (_old > 0) {
				l = _old - _pool.length;
				if (l > 0) {
					for (i = 0; i < l; i++) {
						tmp = newItem();
						if (!tmp.brush) tmp.brush = ThemeBase.FormItem;
						tmp.drawDirectly();
						tmp.addEventListener(MouseEvent.CLICK, onItemClick);
						_pool.push(tmp);
					}
				}
				for (i = 0; i < _old; i++) {
					_content.addChild(_pool.pop());
				}
			} else if (_old < 0) {
				for (i = 0; i < -_old; i++) {
					_pool.push(_content.removeChildAt(0));
				}
			}

			// Resize&Position items
			var k:Number = 0;
			l = _content.numChildren;
			for (i = 0; i < l; i++) {
				tmp = _content.getChildAt(i);
				tmp.move(0, k);
				tmp.size(_width - _scrollBar.width, itemHeight);
				k = tmp.y + itemHeight;
			}

		}

		private function scroll(e:Event = null):void {

			var a:int = _scrollBar.value + (_showLines < _lines ? _showLines : _lines);
			var i:int = _scrollBar.value, j:int = 0;
			var tmp:*;
			while (i < a) {
                //had a recurring error here that j is out of bounds but unable to reproduce
				tmp = _content.getChildAt(j);
				tmp.data = _data[i];
				tmp.selected = (i == _index);
				if (tmp.selected)_target = tmp.data;
				tmp.drawDirectly();
				i++;
				j++;
			}

		}

		private function onItemClick(e:Event):void {
			_index = _scrollBar.value + _content.getChildIndex(e.target as DisplayObject);
			_target = e.target.data;
			dispatchEvent(new Event("change"));
			scroll();
		}

		///////////////////////////////////
		// getter/setters
		///////////////////////////////////

		/**
		 * Returns the target item's data:Array.
		 */
		public function get target():Array {
			return _target;
		}

		public function set itemHeight(value:int):void {
			if (_itemHeight != value) {
				_itemHeight = value;
				if (data) refresh();
			}
		}

		public function get itemHeight():int {
			return _itemHeight;
		}

		public function set data(value:Array):void {
			if (_data != value) {
				_data = value;
				_index = 0;
				_target = _data[0];
				update();
			}
		}

		/**
		 * You should call update() after changing data via this.
		 */
		public function get data():Array {
			return _data;
		}

		public function set index(value:int):void {
			if (_index != value) {
				_index = value;
				_target = _data[value];
				scroll();
			}
		}

		public function get index():int {
			return _index;
		}

		public function get scrollBar():ScrollBar {
			return _scrollBar;
		}

		///////////////////////////////////
		// toString
		///////////////////////////////////

		override public function toString():String {
			return "[bloom.Form]";
		}
	}

}
