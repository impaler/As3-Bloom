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
	
	import bloom.core.IChild;
	
	/**
	 * FlowContainer
	 * 
	 * @author sindney
	 */
	public class FlowContainer extends Container {
		
		public static const VERTICALLY:int = 0;
		public static const HORIZONTALLY:int = 1;
		public static const GRID:int = 2;

		protected var _direction:int;
		protected var _target:DisplayObjectContainer;
		
		public function FlowContainer(p:DisplayObjectContainer = null) {
			super(p);
			_direction = HORIZONTALLY;
			_target = this;
		}
		
		override public function update():void {
			var last:Number = 0;
			var rows:Number = 0;
			var rowLength:Number = 0;
			
			var object:DisplayObject;
			var component:IChild;
			var i:int, j:int = _target.numChildren;
			for (i = 0; i < j; i++) {
				object = _target.getChildAt(i);
				if (object is IChild) {
					component = object as IChild;
					if (_direction == HORIZONTALLY) {
						component.x = last + component.margin.left;
						component.y = component.margin.top;
						last = component.x + component.width + component.margin.right;
					} else if (_direction == VERTICALLY) {
						component.x = component.margin.left;
						component.y = last + component.margin.top;
						last = component.y + component.height + component.margin.bottom;
					} else if ( _direction == GRID ) {
						component.x = last + component.margin.left;
						if ( rows == 0 ) {
							component.y = ( component.margin.top );
						} else {
							component.y = (component.margin.top * (rows + 1)) + ( component.height * rows);
						}
						last = component.x + component.width + component.margin.right;
						if ( rows == 1 ) component.y = (component.margin.top * (rows + 1)) + ( component.height * rows);
						if ( width <= last + component.margin.left + component.width + component.margin.right ) {
							last = 0;
							if ( rowLength==0 ) rowLength =i+1;
							rows += 1;
						}
					}
				}
			}
					
			trace( "row length - " + rowLength );
		}
		
		///////////////////////////////////
		// getter/setters
		///////////////////////////////////
		
		public function set direction(value:int):void {
			if (_direction != value) {
				_direction = value;
				update();
			}
		}
		
		public function get direction():int {
			return _direction;
		}
		
		/**
		 * Default Target is FlowContainer itself.
		 */
		public function set target(value:DisplayObjectContainer):void {
			if (_target != value) {
				_target = value;
				update();
			}
		}
		
		public function get target():DisplayObjectContainer {
			return _target;
		}
		
		///////////////////////////////////
		// toString
		///////////////////////////////////
		
		override public function toString():String {
			return "[bloom.containers.FlowContainer]";
		}
		
	}

}