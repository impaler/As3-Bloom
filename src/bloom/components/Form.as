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
package bloom.components 
{

import bloom.control.BloomCore;
import bloom.core.Component;
import bloom.core.IStyleBase;
import bloom.style.FormStyle;

import com.bit101.components.Style;

import flash.display.DisplayObjectContainer;
import flash.display.Sprite;
import flash.events.Event;

import org.osflash.signals.Signal;

	/**
	 * Form
	 * <p>It's just a base class for you to extend, so that you can create your own Form.</p>
	 * 
	 * @author sindney
	 */
	public class Form extends Component {
		
		protected var _data:Array;
		protected var _target:Array;
		protected var _index:int = 0;
		
		protected var _bg:Sprite;
		protected var _content:Sprite;
		protected var _scrollBar:ScrollBar;
		
		protected var _itemHeight:int = 20;
		
		private var _pool:Array;
		private var _showLines:uint = 0;
		private var _lines:uint;
	
		public static const NORMAL:int = 0;
	
		public var onChange:Signal;
		
		/**
		 * Constructor
		 * 
		 * @param	p Parent.
		 * @param	d An Array saving item's data.
		 */
		public function Form(p:DisplayObjectContainer = null, d:Array = null) {
			super(p);
			
			_content = new Sprite();
			_bg = new Sprite();
			
			_data = d;
			_pool = new Array();
			
			_scrollBar = new ScrollBar();
			_scrollBar.mouseWheelTarget = this;
			_scrollBar.step = 1;
			_scrollBar.autoHide = false;
			_scrollBar.width = 20;
			
			addChild(_bg);
			addChild(_content);
			addChild(_scrollBar);
			
			onChange = new Signal();
			
			style = BloomCore.theme.formStyle;
			
			size(100, 100);
			
			_scrollBar.onScroll.add(scroll);
			_scrollBar.onChange.add(scroll);
		}
		
		/**
		 * Use to change FormItems' Brush.
		 * @param	value
		 */
		public function changeItemsBrush(value:Style):void {
			var tmp:*;
			var i:int, j:int = _content.numChildren;
			for (i = 0; i < j; i++) {
				tmp = _content.getChildAt(i);
				tmp.style = value;
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
			
			formStyle.backgroundBrush.update( NORMAL, _bg , dimensionObject);
			
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
			
			var tmp:FormItem;
			var l:int = 0, i:int = 0;
			if (_old > 0) {
				l = _old - _pool.length;
				if (l > 0) {
					for (i = 0; i < l; i++) {
						tmp = newItem();
						tmp.onClick.add(onItemClick);
						_pool.push(tmp);
					}
				}
				l = _old;
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
			var b:Boolean = true;
			l = _content.numChildren;
			for (i = 0; i < l; i++) {
				tmp = _content.getChildAt(i) as FormItem;
				tmp.move(0, k);
				tmp.size(_width - _scrollBar.width, itemHeight);
				k = tmp.y + itemHeight;
			}
			
		}
		
		private function scroll(e:* = null):void {
			
			var a:int = _scrollBar.value + (_showLines < _lines ? _showLines : _lines);
			var i:int = _scrollBar.value, j:int = 0;
			var tmp:*;
			while (i < a) {
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
			var target:FormItem = e.currentTarget as FormItem;
			_index = _scrollBar.value + _content.getChildIndex(target);
			_target = target.data;
			
			onChange.dispatch();
			scroll();
		}
		
		///////////////////////////////////
		// getter/setters
		///////////////////////////////////

		override public function set style ( value:IStyleBase ):void {
			super.style = value;
			
			_scrollBar.style = formStyle.scrollBar;
		}
		
		public function get formStyle ():FormStyle {
			return _style as FormStyle;
		}	

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

		override public function destroy ():void {
			super.destroy ();
			
			onChange.removeAll();
			onChange = null;
			
			_scrollBar.destroy();
			
			var tmp:FormItem;
			var l:int = _pool.length, i:int = 0;
			if (l > 0) {
				for (i = 0; i < l; i++) {
					tmp = _pool[i];
					tmp.destroy();
				}
			}
			
			
		}
		
		
	}

}
