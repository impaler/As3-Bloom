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
import bloom.core.IComponent;

import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.Sprite;
import flash.geom.Rectangle;

/**
	* FlowContainer
	* 
	* @author sindney
	*/
	public class FlowContainer extends Container {
		
		public static const LEFT:int = 0;
		public static const RIGHT:int = 1;
		public static const TOP:int = 2;
		public static const BOTTOM:int = 3;
		public static const CENTRE:int = 4;
		
		public static const VERTICALLY:int = 0;
		public static const HORIZONTALLY:int = 1;
		public static const GRID:int = 2;

		protected var _direction:int;
		protected var _target:Sprite;
		protected var _mask:Boolean;
		
		protected var _hAlignment:int;
		protected var _vAlignment:int;
		
		public function FlowContainer(p:DisplayObjectContainer = null) {
			_target = new Sprite ();
			super(p);
			
			addChild ( _target );
			
			_direction = VERTICALLY;
			_hAlignment = LEFT;
			_vAlignment = TOP;
			_mask = false;
			
			style = BloomCore.theme.flowContainerStyle;
		}
	
		public function addContent ( cont:IComponent ):void {
			cont.drawDirectly();
			_target.addChild ( DisplayObject ( cont ) );
			drawDirectly();
			invalidate();
		}
		
		override public function update():void {
			var last:Number = 0;
			var rows:Number = 0;
			var rowLength:Number = 0;
			
			var object:DisplayObject;
			var component:IComponent;
			var i:int, j:int = _target.numChildren;
			for (i = 0; i < j; i++) {
				object = _target.getChildAt(i);
				if (object is IComponent) {
					component = object as IComponent;
					
					if (_direction == HORIZONTALLY) {
						component.x = last ;
						
						component.y = 0;
						last = component.x + component.width + component.margin.right;
					} else if (_direction == VERTICALLY) {
						
						component.x = 0;
						component.y = last;
						last = component.y + component.height + component.margin.bottom;
						
					} else if ( _direction == GRID ) {
						
						component.x = last + component.margin.left;
						if ( rows == 0 ) {
							component.y = ( component.margin.top );
						} else {
							component.y = (component.margin.top * (rows + 1)) + ( component.height * rows);
						}
						last = component.x + component.width;
						if ( rows == 1 ) component.y = (component.margin.top * (rows + 1)) + ( component.height * rows);
						if ( width <= last + component.margin.left + component.width + component.margin.right ) {
							last = 0;
							if ( rowLength == 0 ) rowLength = i + 1;
							rows += 1;
						}
						
					}
					
				}
			}
			
			switch ( _hAlignment ) {
					case CENTRE:
						_target.x = Math.round ( (width * .5) - (_target.width * .5) );
						break;
					case LEFT:
						_target.x = 0;
						break;
					case RIGHT:
						_target.x = Math.round ( (width) - (_target.width) );
						break;
			}
				
			switch ( _vAlignment ) {
				case TOP:
					_target.y = 0;
					break;
				case CENTRE:
					_target.y = Math.round ( (height * .5) - (_target.height * .5) );
					break;
				case BOTTOM:
					_target.y = (height) - (_target.height) ;
					break;
			}			
			
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
		
		public function set hAlignment ( hAlignment:int ):void {
			_hAlignment = hAlignment;
			update();
		}
	
		public function set vAlignment ( value:int ):void {
			_vAlignment = value;
			update();
		}
		
		public function set target(value:Sprite):void {
			if (_target != value) {
				_target = value;
				update();
			}
		}
	
		public function set maskContent(value:Boolean):void {
			_mask = value;
			if ( value ) {
				update();
				this.scrollRect = new Rectangle(0,0,_width,_height);
			} else {
				this.scrollRect = null;
			}
		}
	
		public function get target():Sprite {
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