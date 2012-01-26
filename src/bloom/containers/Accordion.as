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
	import flash.events.MouseEvent;
	
	import bloom.core.Margin;
	import bloom.core.IChild;
	import bloom.themes.ThemeBase;
	
	/**
	 * Accordion
	 * 
	 * @author sindney
	 */
	public class Accordion extends Sprite implements IChild {
		
		private var _multiSelect:Boolean;
		private var _enabled:Boolean;
		
		private var _margin:Margin;
		private var _last:AccordionContent;
		private var _target:AccordionContent;
		private var _objects:Vector.<AccordionContent>;
		
		public function Accordion(p:DisplayObjectContainer = null) {
			super();
			_margin = new Margin();
			if (p) p.addChild(this);
			
			_multiSelect = false;
			_enabled = true;
			
			_objects = new Vector.<AccordionContent>();
		}
		
		public function addContent(value:AccordionContent):void {
			_objects.push(value);
			value.title.addEventListener(MouseEvent.CLICK, onContentClick);
			addChild(value);
		}
		
		public function removeContent(value:AccordionContent):void {
			removeContentAt(_objects.indexOf(value));
		}
		
		public function removeContentAt(index:int):AccordionContent {
			var object:AccordionContent = _objects[index];
			if (object) {
				_objects.splice(index, 1)[0];
				object.title.removeEventListener(MouseEvent.CLICK, onContentClick);
				removeChild(object);
			}
			return object;
		}
		
		public function getContentAt(index:int):AccordionContent {
			return _objects[index];
		}
		
		/**
		 * Call update() after addContent/removeContent ... 
		 */
		public function update():void {
			var last:Number = 0;
			
			var object:AccordionContent;
			for each(object in _objects) {
				if (!_multiSelect) if (object != _target) object.selected = false;
				object.y = last;
				last = object.y + object.height;
			}
			dispatchEvent(new Event("resize"));
		}
		
		private function onContentClick(e:Event):void {
			_target = e.target.parent as AccordionContent;
			update();
		}
		
		///////////////////////////////////
		// getter/setters
		///////////////////////////////////
		
		public function set multiSelect(value:Boolean):void {
			if (_multiSelect != value) {
				_multiSelect = value;
			}
		}
		
		public function get multiSelect():Boolean {
			return _multiSelect;
		}
		
		public function set enabled(value:Boolean):void {
			if (_enabled != value) {
				_enabled = mouseEnabled = mouseChildren = value;
				alpha = _enabled ? 1 : ThemeBase.ALPHA;
			}
		}
		
		public function get enabled():Boolean {
			return _enabled;
		}
		
		public function get margin():Margin {
			return _margin;
		}
		
		///////////////////////////////////
		// toString
		///////////////////////////////////
		
		override public function toString():String {
			return "[bloom.containers.Accordion]";
		}
		
	}

}