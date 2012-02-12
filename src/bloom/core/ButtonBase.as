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
import bloom.brushes.ColorBrush;

import flash.display.DisplayObjectContainer;
import flash.display.Shape;
import flash.events.Event;
import flash.events.MouseEvent;

import org.osflash.signals.natives.NativeSignal;

/**
 * ButtonBase
 *
 * @author sindney
 */
public class ButtonBase extends Component {

	protected var _state:int = BloomConstants.NORM;
	protected var _bg:Shape;

	public var onDown:NativeSignal;
	public var onOver:NativeSignal;
	public var onStageUp:NativeSignal;
	public var onOut:NativeSignal;

	public function ButtonBase ( p:DisplayObjectContainer = null ) {
		buttonMode = true;
		tabEnabled = false;

		_bg = new Shape ();
		addChild ( _bg );

		onStageUp = new NativeSignal ( Bloom.core ().stage , MouseEvent.MOUSE_UP , MouseEvent );
		onOver = new NativeSignal ( this , MouseEvent.MOUSE_OVER , MouseEvent );
		onDown = new NativeSignal ( this , MouseEvent.MOUSE_DOWN , MouseEvent );
		onOut = new NativeSignal ( this , MouseEvent.MOUSE_OUT , MouseEvent );

		super ( p );
		style = Bloom.core ().styleRegistry.getObject ( Bloom.core ().currentTheme.BUTTONBASE_STYLE );

		onOver.add ( onMouseOver );
		onDown.add ( onMouseDown );

	}

	protected function get getButtonBaseStyle ():ButtonBaseStyle {
		return _style as ButtonBaseStyle;
	}

	override protected function draw ( e:Event ):void {
		if ( _changed ) {
			_changed = false;
		} else {
			return;
		}

		var bmpBrush:BMPBrush;
		var colorBrush:ColorBrush;
		var scale:ScaleBitmap;

		_bg.graphics.clear ();

		if ( getButtonBaseStyle.backgroundBrush is ColorBrush ) {
			colorBrush = getButtonBaseStyle.backgroundBrush as ColorBrush;
			switch ( _state ) {
				case BloomConstants.NORM:
					_bg.graphics.beginFill ( colorBrush.colors[BloomConstants.NORM] );
					break;
				case BloomConstants.OVER:
					_bg.graphics.beginFill ( colorBrush.colors[BloomConstants.OVER] );
					break;
				case BloomConstants.DOWN:
					_bg.graphics.beginFill ( colorBrush.colors[BloomConstants.DOWN] );
					break;
			}
		} else if ( getButtonBaseStyle.backgroundBrush is BMPBrush ) {
			bmpBrush = getButtonBaseStyle.backgroundBrush as BMPBrush;
			switch ( _state ) {
				case BloomConstants.NORM:
					scale = bmpBrush.bitmap[BloomConstants.NORM];
					scale.setSize ( _width , _height );
					_bg.graphics.beginBitmapFill ( scale.bitmapData );
					break;
				case BloomConstants.OVER:
					scale = bmpBrush.bitmap[BloomConstants.OVER];
					scale.setSize ( _width , _height );
					_bg.graphics.beginBitmapFill ( scale.bitmapData );
					break;
				case BloomConstants.DOWN:
					scale = bmpBrush.bitmap[BloomConstants.DOWN];
					scale.setSize ( _width , _height );
					_bg.graphics.beginBitmapFill ( scale.bitmapData );
					break;
			}
		}

		_bg.graphics.drawRect ( 0 , 0 , _width , _height );
		_bg.graphics.endFill ();
	}

	protected function onMouseOver ( e:MouseEvent ):void {
		if ( _state != BloomConstants.OVER ) {
			_state = BloomConstants.OVER;
			_changed = true;
			invalidate ();
			onOut.add ( onMouseOut );
		}
	}

	protected function onMouseDown ( e:MouseEvent ):void {
		if ( _state != BloomConstants.DOWN ) {
			_state = BloomConstants.DOWN;
			_changed = true;
			invalidate ();
			onStageUp.addOnce ( onMouseUp );
			onOver.remove ( onMouseOver );
		}
	}

	protected function onMouseUp ( e:MouseEvent ):void {
		_state = BloomConstants.NORM;
		_changed = true;
		invalidate ();
		onOver.add ( onMouseOver );
		onOut.remove ( onMouseOut );
	}

	protected function onMouseOut ( e:MouseEvent ):void {
		if ( _state != BloomConstants.DOWN ) onMouseUp ( e );
	}

///////////////////////////////////
// getter/setters
///////////////////////////////////

	public function get state ():int {
		return _state;
	}

///////////////////////////////////
// toString
///////////////////////////////////

	public override function toString ():String {
		return "[bloom.core.ButtonBase]";
	}

	override public function destroy ():void {
		super.destroy ();

		onStageUp.removeAll ();
		onStageUp = null;
		onOver.removeAll ();
		onOver = null;
		onDown.removeAll ();
		onDown = null;
		onOut.removeAll ();
		onOut = null;

		_bg = null;
	}

}

}
