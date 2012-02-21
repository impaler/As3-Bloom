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
import bloom.style.ContainerStyle;

import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.events.Event;

import bloom.core.Component;
import bloom.core.IComponent;

	
	/**
	 * Container
	 * 
	 * @author sindney
	 */
	public class Container extends Component {
		
		public static const NORMAL:int = 0;
		
		public function Container(p:DisplayObjectContainer = null) {
			super(p);
			
			style = BloomCore.theme.containerStyle;
			
			size(100, 100);
		}
		
		/**
		 * Update child's layout.
		 */
		public function update():void {
			
		}
		
		override protected function draw(e:Event):void {
			if (_changed) {
				_changed = false;
			} else {
				return;
			}
			
			containerStyle.backgroundBrush.update ( NORMAL , this , dimensionObject );

			update();
		}

		///////////////////////////////////
		// getter/setters
		///////////////////////////////////
		
		private function get containerStyle ():ContainerStyle {
			return _style as ContainerStyle;
		}
		
		
		override public function set enabled(value:Boolean):void {
			if (_enabled != value) {
				_enabled = tabChildren = mouseEnabled = mouseChildren = value;
				
				// make changes in it's children.
				var i:int;
				var child:DisplayObject;
				for (i = 0; i < numChildren; i++) {
					child = getChildAt(i);
					if (child is IComponent) (child as IComponent).enabled = value;
				}
			}
		}
		
		///////////////////////////////////
		// toString
		///////////////////////////////////
		
		override public function toString():String {
			return "[bloom.containers.Container]";
		}
		
		override public function destroy () : void {
			super.destroy();
			
		}
		
	}

}