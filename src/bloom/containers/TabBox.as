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

	import bloom.brushes.Brush;
	import bloom.brushes.TextBrush;
	import bloom.core.IChild;
	import bloom.core.Margin;
	import bloom.themes.ThemeBase;
	import bloom.CheckBoxGroup;
	import bloom.ToggleButton;

	/**
	 * TabBox
	 *
	 * @date 2012/1/21 11:01
	 * @author sindney
	 */
	public class TabBox extends Container {

		private var _headerSize:Number;
        private var _headerPadding:Number;

		private var _group:CheckBoxGroup;

		private var _header:FlowContainer;
		private var _content:Container;
		private var _contents:Vector.<IChild>;

		private var _pool:Vector.<IChild>;

		public function TabBox(p:DisplayObjectContainer = null) {
			super(p);
			_header = new FlowContainer(this);
			_header.brush = ThemeBase.TabBox;

			_contents = new Vector.<IChild>();
			_pool = new Vector.<IChild>();

			_group = new CheckBoxGroup(-1);
			_group.addEventListener(Event.CHANGE, onTabChanged);

			_headerSize = 30;
			_headerPadding = 20;

			update();
		}

		/**
		 * Use to change titles' Brush.
		 */
		public function changeTitlesBrush(toggleButton:Brush, title:TextBrush):void {
			var object:ToggleButton;
			for each(object in _header) {
				object.brush = toggleButton;
				object.title.brush = title;
			}
			for each(object in _pool) {
				object.brush = toggleButton;
				object.title.brush = title;
			}
		}

		public function addContent(name:String, value:Container, margin:Margin = null):void {
			var title:ToggleButton = getToggleButton();
			margin ? title.margin.copyForm(margin) : title.margin.reset(0, 0, 0, 0);
			title.title.text = name;
			title.brush = ThemeBase.TabBox_Title;
			title.title.brush = ThemeBase.Text_TabBox;

			title.size(title.title.width + _headerPadding, _headerSize - title.margin.top);

			_group.addChild(title);
			_header.addChild(title);

			_header.update();
			_contents.push(value);
		}

		public function removeContentAt(index:int):Container {
			var result:Container;
			var title:ToggleButton = _header.getChildAt(index) as ToggleButton;
			if (title) {
				result = Container ( _contents.splice ( index , 1 )[0] );
				returnToggleButton(title);
				_header.update();
			}
			return result;
		}

		public function removeContentByName(name:String):Container {
			var result:Container;
			var title:ToggleButton;
			var i:int, j:int = _header.numChildren;
			for (i = 0; i < j; i++) {
				title = _header.getChildAt(i) as ToggleButton;
				if (title.title.text == name) {
					result = Container ( _contents.splice ( i , 1 )[0] );
					returnToggleButton(title);
					_header.update();
					break;
				}
			}
			return result;
		}

		public function getContentAt(index:int):Container {
			return _contents[index] as Container;
		}

		public function getContentByName(name:String):Container {
			var title:ToggleButton;
			var i:int, j:int = _header.numChildren;
			for (i = 0; i < j; i++) {
				title = _header.getChildAt(i) as ToggleButton;
				if (title.title.text == name) return _contents[i] as Container;
			}
			return null;
		}

		/**
		 * Toggle a certain tab.
		 * @param	name Name of the tab.
		 */
		public function toggleTab(name:String):void {
			var content:Container;
			var title:ToggleButton;
			var i:int, j:int = _header.numChildren;
			for (i = 0; i < j; i++) {
				title = _header.getChildAt(i) as ToggleButton;
				if (title.title.text == name) {
					_group.index = i;
					if (_content) removeChild(_content);
					_content = _contents[i] as Container;
					update();
				}
			}
		}

		override public function update():void {
			_header.size(_width, _headerSize);
			if (_content) {
				if (!_content.parent) addChild(_content);
				_content.y = _headerSize;
				_content.width = _width;
				_content.height = _height - _headerSize;
			}
		}

		override protected function draw(e:Event):void {
			if (_changed) {
				_changed = false;
			} else {
				return;
			}

			update();
		}

		private function updateTitlesSize():void {
			var title:ToggleButton;
			for each(title in _header) {
				title.size(title.title.width + _headerPadding, _headerSize - title.margin.top);
			}
		}

		private function onTabChanged(e:Event):void {
			if (_content) removeChild(_content);
			_content = _contents[_group.index] as Container;
			update();
		}

		private function returnToggleButton(value:ToggleButton):void {
			_group.removeChild(value);
			_header.removeChild(value);
			_pool.push(value);
		}

		private function getToggleButton():ToggleButton {
			return _pool.length > 0 ? ToggleButton ( _pool.pop () ) : new ToggleButton();
		}

		///////////////////////////////////
		// getter/setters
		///////////////////////////////////

		public function get targetName():String {
			if (_group.target)return _group.target.title.text;
			return "";
		}

		public function set headerSize(value:Number):void {
			if (_headerSize != value) {
				_headerSize = value;
				updateTitlesSize();
				update();
			}
		}

		public function get headerSize():Number {
			return _headerSize;
		}

		public function set headerPadding(value:Number):void {
			if (_headerPadding != value) {
				_headerPadding = value;
				updateTitlesSize();
			}
		}

		public function get headerPadding():Number {
			return _headerPadding;
		}

		///////////////////////////////////
		// toString
		///////////////////////////////////

		override public function toString():String {
			return "[bloom.containers.TabBox]";
		}

	}

}
