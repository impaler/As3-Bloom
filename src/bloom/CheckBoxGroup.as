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
	import flash.events.EventDispatcher;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import bloom.CheckBox;
	
	/** 
	 * Dispatched when the target has changed.
	 * @eventType flash.events.MouseEvent.CLICK
	 */
	[Event(name = "change", type = "flash.events.Event")]
	
	/**
	 * CheckBoxGroup
	 *  
	 * @date 2012/1/10 20:11
	 * @author sindney
	 */
	public class CheckBoxGroup extends EventDispatcher {
		
		private var _content:Array;
		
		private var _index:int;
		private var _target:CheckBox;
		
		public function CheckBoxGroup(index:int, ...rest) {
			_index = index;
		    
			if (rest.length == 1 && rest[0] is Array) {
				_content = rest[0];
			}
			
			if( rest.length > 1) {
				_content = rest;
			}
			
			var i:int, j:int = numChildren;
			for (i = 0; i < j; i++) {
				(_content[i] as CheckBox).addEventListener(MouseEvent.CLICK, onChange);
			}
			
			update();
		}
		
		public function addChild(target:CheckBox):void {
			_content.push(target);
			target.value = false;
			target.addEventListener(MouseEvent.CLICK, onChange);
		}
		
		public function removeChild(target:CheckBox):void {
			var index:int = _content.indexOf(target);
			if (index != -1) {
				if (_index == index) {
					_index = -1;
					_target = null;
				}
				_content.splice(index, 1);
				target.removeEventListener(MouseEvent.CLICK, onChange);
			}
		}
		
		public function removeChildAt(index:int):CheckBox {
			var target:CheckBox = _content[index];
			if (target) {
				if (_index == index) {
					_index = -1;
					_target = null;
				}
				_content.splice(index, 1);
				target.removeEventListener(MouseEvent.CLICK, onChange);
				
				return target;
			}
			return null;
		}
		
		///////////////////////////////////
		// private methods
		///////////////////////////////////
		
		private function update():void {
			var i:int, j:int = numChildren;
			for (i = 0; i < j; i++) {
				(_content[i] as CheckBox).value = false;
			}
			
			_target = _content[_index];
			if (_target)_target.value = true;
		}
		
		private function onChange(e:Event):void {
			_index = _content.indexOf(e.target as CheckBox);
			update();
			dispatchEvent(new Event("change"));
		}
		
		///////////////////////////////////
		// getter/setters
		///////////////////////////////////
		
		public function get target():CheckBox {
			return _target;
		}
		
		public function set index(value:int):void {
			_index = value;
			update();
		}
		
		public function get index():int {
			return _index;
		}
		
		public function get numChildren():int {
			return _content.length;
		}
		
		///////////////////////////////////
		// toString
		///////////////////////////////////
		
		override public function toString():String {
			return "[bloom.CheckBoxGroup]";
		}
		
	}

}