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

import flash.display.DisplayObjectContainer;
import flash.display.Sprite;
import flash.events.Event;
import flash.utils.getDefinitionByName;
import flash.utils.getQualifiedClassName;

import org.osflash.signals.natives.NativeSignal;

/**
 * Component
 *
 * @author sindney
 */
public class Component extends Sprite implements IComponent {

	protected var _enabled:Boolean = true;
	protected var _changed:Boolean = false;

	protected var _width:Number = 0;
	protected var _height:Number = 0;

	protected var _onAddedToStage:NativeSignal;
	protected var _onStageDraw:NativeSignal;
	protected var _onResize:NativeSignal;

	protected var _style:ComponentStyle;

	public function Component ( p:DisplayObjectContainer = null ) {
		super ();

		_onAddedToStage = new NativeSignal ( this , Event.ADDED_TO_STAGE , Event );
		_onResize = new NativeSignal ( this , Event.RESIZE , Event );
		_onStageDraw = Bloom.core ().onStageDraw;

		_onAddedToStage.addOnce ( onAddedToStage );

		if ( p != null ) p.addChild ( this );
	}

	public function set style ( style:ComponentStyle ):void {
		if ( style != null ) {
			var newStyle:Class = getDefinitionByName ( getQualifiedClassName ( style ) ) as Class;
			if ( _style != null ) {
				var current:Class = getDefinitionByName ( getQualifiedClassName ( _style ) ) as Class;
				if ( newStyle == current ) return;
			}
			_style = Bloom.core ().styleRegistry.getObject ( newStyle ) as ComponentStyle;
			style.initialize ( this );
			_changed = true;
			invalidate ();
		}
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
			_onResize.dispatch ( new Event ( "resize" ) );
		}
	}

	public function drawDirectly ():void {
		_changed = true;
		draw ( null );
	}

	protected function draw ( e:Event ):void {

	}

	protected function invalidate ():void {
		if ( Bloom.core ().stage ) Bloom.core ().stage.invalidate ();
	}

	private function onAddedToStage ( e:Event ):void {
		_onStageDraw.add ( draw );
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
			_onResize.dispatch ( new Event ( "resize" ) );
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
			_onResize.dispatch ( new Event ( "resize" ) );
		}
	}

	override public function get height ():Number {
		return _height;
	}

	public function set enabled ( value:Boolean ):void {
		if ( _enabled != value ) {
			_enabled = mouseEnabled = mouseChildren = value;
			alpha = _enabled ? 1 : .4;
		}
	}

	public function get enabled ():Boolean {
		return _enabled;
	}

	public function destroy ():void {
		_onStageDraw.remove ( draw );
	}

///////////////////////////////////
// toString
///////////////////////////////////

	override public function toString ():String {
		return "[bloom.core.Component]";
	}

}

}
