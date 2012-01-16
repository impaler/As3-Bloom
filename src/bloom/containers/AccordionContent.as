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
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import bloom.themes.ThemeBase;
	
	/** 
	 * Dispatched when this Component is selected.
	 * @eventType flash.events.Event
	 */
	[Event(name = "select", type = "flash.events.Event")]
	
	/**
	 * AccordionContent
	 * 
	 * @date 2012/1/16 14:08
	 * @author sindney
	 */
	public class AccordionContent extends Container {
		
		private var _selected:Boolean;
		private var _headerSize:Number;
		private var _contentSize:Number;
		
		private var _title:FlowContainer;
		private var _content:FlowContainer;
		
		public function AccordionContent(p:DisplayObjectContainer = null) {
			super(p);
			_title = new FlowContainer(this);
			_title.brush = ThemeBase.AC_Title;
			_title.addEventListener(MouseEvent.CLICK, onMouseClick);
			
			_content = new FlowContainer();
			_content.brush = ThemeBase.AC_Content;
			_content.direction = FlowContainer.VERTICALLY;
			
			_selected = false;
			_headerSize = 30;
			_content.height = _contentSize = 100;
			
			size(100, 30);
		}
		
		private function onMouseClick(e:MouseEvent):void {
			selected = !_selected;
		}
		
		override public function update():void {
			_title.size(_width, _headerSize);
			_content.y = _headerSize;
			_content.width = _width;
			_height = _headerSize + _selected ? _contentSize : 0;
		}
		
		override protected function draw(e:Event):void {
			if (_changed) {
				_changed = false;
			} else {
				return;
			}
			
			update();
		}
		
		///////////////////////////////////
		// getter/setters
		///////////////////////////////////
		
		public function set selected(value:Boolean):void {
			if (_selected != value) {
				_selected = value;
				if (_selected) {
					addChild(_content);
					dispatchEvent(new Event("select"));
				} else {
					removeChild(_content);
				}
				update();
			}
		}
		
		public function get selected():Boolean {
			return _selected;
		}
		
		public function set headerSize(value:Number):void {
			if (_headerSize != value) {
				_headerSize = value;
				update();
			}
		}
		
		public function get headerSize():Number {
			return _headerSize;
		}
		
		public function set contentSize(value:Number):void {
			if (_contentSize != value) {
				_content.height = _contentSize = value;
				update();
			}
		}
		
		public function get contentSize():Number {
			return _contentSize;
		}
		
		public function get title():FlowContainer {
			return _title;
		}
		
		public function get content():FlowContainer {
			return _content;
		}
		
		///////////////////////////////////
		// toString
		///////////////////////////////////
		
		override public function toString():String {
			return "[bloom.containers.AccordionContent]";
		}
	}

}