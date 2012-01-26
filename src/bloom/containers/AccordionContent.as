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
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import bloom.core.IChild;
	import bloom.core.Margin;
	import bloom.themes.ThemeBase;
	
	[Event(name = "select", type = "flash.events.Event")]
	
	[Event(name = "change", type = "flash.events.Event")]
	
	/**
	 * AccordionContent
	 * 
	 * @author sindney
	 */
	public class AccordionContent extends Sprite implements IChild {
		
		private var _selected:Boolean;
		private var _enabled:Boolean;
		private var _margin:Margin;
		
		private var _title:FlowContainer;
		private var _content:FlowContainer;
		
		public function AccordionContent(p:DisplayObjectContainer = null) {
			super();
			_margin = new Margin();
			if (p) p.addChild(this);
			
			_title = new FlowContainer(this);
			_title.buttonMode = true;
			_title.tabEnabled = false;
			_title.brush = ThemeBase.AC_Title;
			_title.size(100, 30);
			_title.addEventListener(MouseEvent.CLICK, onMouseClick);
			
			_content = new FlowContainer();
			_content.brush = ThemeBase.AC_Content;
			_content.direction = FlowContainer.VERTICALLY;
			
			_enabled = true;
			_selected = false;
		}
		
		private function onMouseClick(e:MouseEvent):void {
			selected = !_selected;
		}
		
		///////////////////////////////////
		// getter/setters
		///////////////////////////////////
		
		override public function get height():Number {
			return _title.height + (_selected ? _content.height : 0);
		}
		
		public function set selected(value:Boolean):void {
			if (_selected != value) {
				_selected = value;
				if (_selected) {
					_content.y = _title.height;
					addChild(_content);
					dispatchEvent(new Event("select"));
				} else {
					removeChild(_content);
				}
				dispatchEvent(new Event("change"));
			}
		}
		
		public function get selected():Boolean {
			return _selected;
		}
		
		public function get title():FlowContainer {
			return _title;
		}
		
		public function get content():FlowContainer {
			return _content;
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
			return "[bloom.containers.AccordionContent]";
		}
	}

}