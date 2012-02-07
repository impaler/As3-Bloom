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
import bloom.components.ButtonModel;

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

	public static const UP:int = 0;
	public static const OVER:int = 1;
	public static const DOWN:int = 2;

	protected var _state:int = 0;
	protected var _bg:Shape;

	protected var _model:ButtonModel;

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

		onOver.add ( onMouseOver );
		onDown.add ( onMouseDown );

		super ( p );
	}

	override public function applyModel ():void {
		var _prevModel:ButtonModel = _model;
		if ( ! _customModel ) {
			_model = Registry.theme.Button_Model;
		}
		brush = _model.brush;

		if ( width == 0 && height == 0 || width == _prevModel.defaultWidth && height == _prevModel.defaultHeight ) {
			if ( width != _model.defaultWidth )
				width = _model.defaultWidth;

			if ( height != _model.defaultHeight )
				height = _model.defaultHeight;
		}
	}

	public function set model ( value:ButtonModel ):void {
		_model = value;
		_customModel = true;
		super.applyModel ();
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

		if ( brush is ColorBrush ) {
			colorBrush = brush as ColorBrush;
			switch ( _state ) {
				case 0:
					_bg.graphics.beginFill ( colorBrush.colors[0] );
					break;
				case 1:
					_bg.graphics.beginFill ( colorBrush.colors[1] );
					break;
				case 2:
					_bg.graphics.beginFill ( colorBrush.colors[2] );
					break;
			}
		} else if ( brush is BMPBrush ) {
			bmpBrush = brush as BMPBrush;
			switch ( _state ) {
				case 0:
					scale = bmpBrush.bitmap[Bloom.NORM];
					scale.setSize ( _width , _height );
					_bg.graphics.beginBitmapFill ( scale.bitmapData );
					break;
				case 1:
					scale = bmpBrush.bitmap[Bloom.OVER];
					scale.setSize ( _width , _height );
					_bg.graphics.beginBitmapFill ( scale.bitmapData );
					break;
				case 2:
					scale = bmpBrush.bitmap[Bloom.DOWN];
					scale.setSize ( _width , _height );
					_bg.graphics.beginBitmapFill ( scale.bitmapData );
					break;
			}
		}

		_bg.graphics.drawRect ( 0 , 0 , _width , _height );
		_bg.graphics.endFill ();
	}

	protected function onMouseOver ( e:MouseEvent ):void {
		if ( _state != OVER ) {
			_state = OVER;
			_changed = true;
			invalidate ();
			onOut.add ( onMouseOut );
		}
	}

	protected function onMouseDown ( e:MouseEvent ):void {
		if ( _state != DOWN ) {
			_state = DOWN;
			_changed = true;
			invalidate ();
			onStageUp.addOnce ( onMouseUp );
			onOver.remove ( onMouseOver );
		}
	}

	protected function onMouseUp ( e:MouseEvent ):void {
		_state = UP;
		_changed = true;
		invalidate ();
		onOver.add ( onMouseOver );
		onOut.remove ( onMouseOut );
	}

	protected function onMouseOut ( e:MouseEvent ):void {
		if ( _state != DOWN ) onMouseUp ( e );
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
		_model = null;
	}
}

}