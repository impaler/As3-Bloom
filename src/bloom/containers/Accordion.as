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
	import flash.events.MouseEvent;
	
	import bloom.core.IComponent;
	import bloom.themes.ThemeBase;
	
	/**
	 * Accordion
	 * 
	 * @date 2012/1/16 14:08
	 * @author sindney
	 */
	public class Accordion extends Container {
		
		private var _index:int;
		
		private var _multiSelect:Boolean;
		
		private var _target:AccordionContent;
		
		private var _content:Vector.<AccordionContent>;
		
		public function Accordion(p:DisplayObjectContainer = null) {
			super(p);
			
			_index = 0;
			_multiSelect = false;
			
			_content = new Vector.<AccordionContent>();
			
			brush = ThemeBase.Accordion;
		}
		
		public function addContent(value:AccordionContent):void {
			_content.push(value);
			value.title.addEventListener(MouseEvent.CLICK, onContentClick);
			addChild(value);
			update();
		}
		
		public function removeContent(value:AccordionContent):void {
			removeContentAt(_content.indexOf(value));
		}
		
		public function removeContentAt(index:int):AccordionContent {
			var object:AccordionContent = _content[index];
			if (object) {
				_content.splice(index, 1)[0];
				object.title.removeEventListener(MouseEvent.CLICK, onContentClick);
				removeChild(object);
				update();
			}
			return object;
		}
		
		public function getContentAt(index:int):AccordionContent {
			return _content[index];
		}
		
		override public function update():void {
			var last:Number = 0;
			
			var object:AccordionContent;
			for each(object in _content) {
				if (!_multiSelect) if (object != _target) object.selected = false;
				object.x = object.margin.left;
				object.y = last + object.margin.top;
				object.width = _width;
				last = object.y + object.margin.bottom + object.headerSize + (object.selected ? object.contentSize : 0);
			}
		}
		
		private function onContentClick(e:Event):void {
			_target = e.target.parent as AccordionContent;
			update();
		}
		
		///////////////////////////////////
		// getter/setters
		///////////////////////////////////
		
		public function get index():int {
			return _index;
		}
		
		public function set multiSelect(value:Boolean):void {
			if (_multiSelect != value) {
				_multiSelect = value;
				update();
			}
		}
		
		public function get multiSelect():Boolean {
			return _multiSelect;
		}
		
		///////////////////////////////////
		// toString
		///////////////////////////////////
		
		override public function toString():String {
			return "[bloom.containers.Accordion]";
		}
		
	}

}