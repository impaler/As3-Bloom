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
package bloom {

import bloom.brushes.BMPBrush;
import bloom.brushes.ColorBrush;
import bloom.core.Component;
import bloom.core.ScaleBitmap;
import bloom.themes.ThemeBase;

import flash.display.DisplayObjectContainer;
import flash.display.Shape;
import flash.display.Sprite;
import flash.events.Event;

[Event(name="complete" , type="flash.events.Event")]

/**
 * ProgressBar
 *
 * @date 2012/1/17 23:52
 * @author sindney
 */ public class ProgressBar extends Component {

	private var _bg:Sprite;
	private var _progress:Shape;

	private var _value:int;

	public function ProgressBar ( p:DisplayObjectContainer = null , value:int = 0 ) {
		_value = value;

		_bg = new Sprite ();
		addChild ( _bg );

		_progress = new Shape ();
		addChild ( _progress );

		super ( p );

		size ( 100 , 20 );
	}

	override public function setCoreBrush ():void {
		super.setCoreBrush ();

		brush = ThemeBase.ProgressBar;
	}

	override protected function draw ( e:Event ):void {
		if ( _changed ) {
			_changed = false;
		} else {
			return;
		}

		_value = _value > 100 ? 100 : _value;
		_value = _value < 0 ? 0 : _value;

		var bmpBrush:BMPBrush;
		var colorBrush:ColorBrush;
		var scale:ScaleBitmap;

		_bg.graphics.clear ();
		_progress.graphics.clear ();

		if ( brush is ColorBrush ) {
			colorBrush = brush as ColorBrush;
			_bg.graphics.beginFill ( colorBrush.colors[0] );
			_progress.graphics.beginFill ( colorBrush.colors[1] );
		} else if ( brush is BMPBrush ) {
			bmpBrush = brush as BMPBrush;
			scale = bmpBrush.bitmap[0];
			scale.setSize ( _width , _height );
			_bg.graphics.beginBitmapFill ( scale.bitmapData );

			scale = bmpBrush.bitmap[1];
			scale.setSize ( (_width * _value) * 0.01 , _height );
			_progress.graphics.beginBitmapFill ( scale.bitmapData );
		}

		_bg.graphics.drawRect ( 0 , 0 , _width , _height );
		_bg.graphics.endFill ();

		_progress.graphics.drawRect ( 0 , 0 , (_width * _value) * 0.01 , _height );
		_progress.graphics.endFill ();
	}

	///////////////////////////////////
	// getter/setters
	///////////////////////////////////

	public function set value ( value:int ):void {
		if ( _value != value ) {
			_value = value;
			_changed = true;
			invalidate ();
			if ( _value >= 100 ) dispatchEvent ( new Event ( "complete" ) );
		}
	}

	public function get value ():int {
		return _value;
	}

	///////////////////////////////////
	// toString
	///////////////////////////////////

	override public function toString ():String {
		return "[bloom.ProgressBar]";
	}
}

}
