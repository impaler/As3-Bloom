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
package bloom.core {

import bloom.brushes.BMPBrush;
import bloom.brushes.Brush;
import bloom.events.BrushEvent;

import flash.display.DisplayObjectContainer;
import flash.display.Sprite;
import flash.events.Event;

/**
 * Dispatched when this Component has resized.
 * @eventType flash.events.Event
 */
[Event(name="resize" , type="flash.events.Event")]

/**
 * Component
 *
 * @author sindney
 */ public class Component extends Sprite implements IComponent {

	protected var _enabled:Boolean = true;
	protected var _changed:Boolean = false;

	protected var _width:Number = 0;
	protected var _height:Number = 0;

	protected var _brush:Brush;

	protected var _margin:Margin;

	protected var _registerComponent:Boolean = true;
	
	protected var _customModel:Boolean = false;
	
	protected var _Reg:ComponentReg;

	public function Component ( p:DisplayObjectContainer = null ) {
		super ();
		Bloom.core ().registerComponent ( this );
		applyModel ();
		_margin = new Margin ();
		addEventListener ( Event.ADDED_TO_STAGE , onAddedToStage );
		if ( p != null ) p.addChild ( this );
	}

	public function applyModel ():void {
		_changed = true;
		invalidate ();
	}

	/**
	 * Move this component.
	 */
	public function move ( x:Number , y:Number ):void {
		this.x = x;
		this.y = y;
	}

	/**
	 * Resize this component.
	 */
	public function size ( w:Number , h:Number ):void {
		if ( _width != w || _height != h ) {
			_width = w;
			_height = h;
			_changed = true;
			invalidate ();
			dispatchEvent ( new Event ( "resize" ) );
		}
	}

	public function drawDirectly ():void {
		_changed = true;
		draw ( null );
	}

	protected function draw ( e:Event ):void {

	}

	protected function invalidate ():void {
		if ( stage ) stage.invalidate ();
	}

	protected function onBrushChanged ( e:BrushEvent ):void {
		_changed = true;
		invalidate ();
	}

	private function onAddedToStage ( e:Event ):void {
		removeEventListener ( Event.ADDED_TO_STAGE , onAddedToStage );
		stage.addEventListener ( Event.RENDER , draw );
		invalidate ();
	}

	///////////////////////////////////
	// getter/setters
	///////////////////////////////////

	override public function set width ( value:Number ):void {
		if ( _width != value ) {
			_width = value;
			_changed = true;
			invalidate ();
			dispatchEvent ( new Event ( "resize" ) );
		}
	}

	override public function get width ():Number {
		return _width;
	}

	override public function set height ( value:Number ):void {
		if ( _height != value ) {
			_height = value;
			_changed = true;
			invalidate ();
			dispatchEvent ( new Event ( "resize" ) );
		}
	}

	override public function get height ():Number {
		return _height;
	}

	public function set brush ( b:Brush ):void {
		if ( _brush != b ) {
			if ( _brush ) {
				if ( _brush is BMPBrush )_brush.destroy ();
				_brush.removeEventListener ( BrushEvent.REDRAW , onBrushChanged );
			}
			_brush = b;
			if ( _brush is BMPBrush )_brush = b.clone ();
			if ( _brush ) {
				_changed = true;
				invalidate ();
				_brush.addEventListener ( BrushEvent.REDRAW , onBrushChanged );
			}
		}
	}

	public function get brush ():Brush {
		return _brush;
	}

	public function set enabled ( value:Boolean ):void {
		if ( _enabled != value ) {
			_enabled = mouseEnabled = mouseChildren = value;
			alpha = _enabled ? 1 : Registry.theme.ALPHA;
		}
	}

	public function get enabled ():Boolean {
		return _enabled;
	}

	public function get margin ():Margin {
		return _margin;
	}

	public function get registerComponent ():Boolean {
		return _registerComponent;
	}
	
	public function set registerComponent (value:Boolean):void {
		_registerComponent = value;
		
//		if ( !value ) {
//			Registry.removeComponent( this, true );
//		}
		
	}
	
	///////////////////////////////////
	// toString
	///////////////////////////////////

	override public function toString ():String {
		return "[bloom.core.Component]";
	}

	public function destroy ():void {
		_brush = null;
		_margin = null;
	}

	public function set Registry ( value:ComponentReg ):void {
		_Reg = value;
	}
	
	public function get Registry ( ):ComponentReg {
		return _Reg;
	}
	
}

}