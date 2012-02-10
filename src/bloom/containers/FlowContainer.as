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
package bloom.containers {

import bloom.core.Bloom;
import bloom.core.Component;
import bloom.core.IChild;
import bloom.core.IComponent;

import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.Sprite;

/**
 * FlowContainer
 *
 * @author sindney
 */
public class FlowContainer extends Container {

	protected var _target:Sprite;
	protected var _direction:int;
	protected var _hAlignment:int;
	private var _vAlignment:int;

	public function FlowContainer ( p:DisplayObjectContainer = null ) {
		_direction = Bloom.HORIZONTALLY;
		_hAlignment = Bloom.LEFT;
		_vAlignment = Bloom.TOP;
		
		_target = new Sprite ();
		addChild ( _target );
		
		super ( p );
	}

	override public function addContent ( cont:IComponent ):void {
		cont.drawDirectly();
		_target.addChild ( DisplayObject ( cont ) );
		invalidate();
	}
	
	public function get content ( ):DisplayObjectContainer {
		return _target;
	}	

	override public function update ():void {
		var last:Number = 0;
		var rows:Number = 0;
		var rowLength:Number = 0;

		var object:DisplayObject;
		var component:IChild;
		var i:int, j:int = _target.numChildren;
		for ( i = 0 ; i < j ; i ++ ) {
			object = _target.getChildAt ( i );
			if ( object is IChild ) {
				component = object as IChild;
				if ( _direction == Bloom.HORIZONTALLY ) {
					component.x = last + component.margin.left;
					component.y = component.margin.top;
					last = component.x + component.width + component.margin.right;
				} else if ( _direction == Bloom.VERTICALLY ) {
					component.x = component.margin.left;
					component.y = last + component.margin.top;
					last = component.y + component.height + component.margin.bottom;
				} else if ( _direction == Bloom.GRID ) {
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

		//todo component margins not implimented in alignment, this may require another container components potentially all different
		switch ( _hAlignment ) {
			case Bloom.CENTRE:
				_target.x = Math.round ( (width * .5) - (_target.width * .5) );
				break;
			case Bloom.LEFT:
				_target.x = margin.left;
				break;
			case Bloom.RIGHT:
				_target.x = Math.round ( (width) - (_target.width) - margin.right - margin.left );
				break;
		}
		
		switch ( _vAlignment ) {
			case Bloom.TOP:
				_target.y = margin.top;
				break;
			case Bloom.CENTRE:
				_target.y = Math.round ( (height * .5) - (_target.height * .5) );
				break;
			case Bloom.BOTTOM:
				_target.y = (height) - (_target.height) - margin.top - margin.bottom;
				break;
		}			

	}

	///////////////////////////////////
	// getter/setters
	///////////////////////////////////

	public function set direction ( value:int ):void {
		if ( _direction != value ) {
			_direction = value;
			update ();
		}
	}

	public function get direction ():int {
		return _direction;
	}

	/**
	 * Default Target is FlowContainer itself.
	 */
	public function set target ( value:Sprite ):void {
		if ( _target != value ) {
			_target = value;
			update ();
		}
	}

	public function get target ():Sprite {
		return _target;
	}

	public function set hAlignment ( hAlignment:int ):void {
		_hAlignment = hAlignment;
		drawDirectly();
	}

	public function set vAlignment ( value:int ):void {
		_vAlignment = value;
		drawDirectly();
	}

	public function get hAlignment ( ):int {
		return _hAlignment;
	}

	///////////////////////////////////
	// toString
	///////////////////////////////////

	override public function toString ():String {
		return "[bloom.containers.FlowContainer]";
	}

}

}