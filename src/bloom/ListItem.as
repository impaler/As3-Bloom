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
	import flash.events.Event;
	
	import bloom.core.ThemeBase;
	import bloom.events.BrushEvent;
	
	/**
	 * ListItem
	 * 
	 * @date 2012/1/10 20:12
	 * @author sindney
	 */
	public class ListItem extends FormItem {
		
		private var _title:Label;
		
		public function ListItem(p:DisplayObjectContainer = null) {
			super(p);
			
			_title = new Label(this);
			_title.brush = ThemeBase.Text_List;
			_title.addEventListener(Event.CHANGE, onTitleChanged);
			_title.addEventListener(BrushEvent.REDRAW, onTitleChanged);
		}
		
		protected function onTitleChanged(e:Event):void {
			_title.move(5, (_height - _title.height) * 0.5);
		}
		
		/**
		 * Call this when data:Array is modified.
		 */
		override public function dataChanged():void {
			_title.text = String(_data[0]);
			_changed = true;
			invalidate();
		}
		
		override protected function draw(e:Event):void {
			super.draw(null);
			_title.move(5, (_height - _title.height) * 0.5);
		}
		
		///////////////////////////////////
		// getter/setters
		///////////////////////////////////
		
		override public function set data(a:Array):void {
			if (_data != a) {
				_data = a;
				_title.text = String(_data[0]);
				_changed = true;
				invalidate();
			}
		}
		
		///////////////////////////////////
		// toString
		///////////////////////////////////
		
		override public function toString():String {
			return "[bloom.ListItem]";
		}
		
	}

}