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

import bloom.core.IComponent;
import bloom.core.Margin;
import bloom.core.ScaleBitmap;
import bloom.themes.ThemeBase;

import flash.display.BitmapData;

/**
 * IconBox
 * <p>You can add iconBox to Window's title. And use it's margin method.</p>
 *
 * @date 2012/1/16 10:47
 * @author sindney
 */
public class IconBox extends ScaleBitmap implements IComponent {

	private var _enabled:Boolean = true;
	protected var _margin:Margin;

	public function IconBox ( bitmapData:BitmapData = null , pixelSnapping:String = "auto" ,
	                          smoothing:Boolean = false ) {
		super ( bitmapData , pixelSnapping , smoothing );
		_margin = new Margin ();
	}

	public function move ( _x:Number , _y:Number ):void {
		x = _x;
		y = _y;
	}

	public function size ( w:Number , h:Number ):void {
		width = w;
		height = h;
	}

	///////////////////////////////////
	// getter/setters
	///////////////////////////////////

	public function set enabled ( value:Boolean ):void {
		if ( _enabled != value ) {
			_enabled = value;
			alpha = _enabled ? 1 : ThemeBase.ALPHA;
		}
	}

	public function get enabled ():Boolean {
		return _enabled;
	}

	public function get margin ():Margin {
		return _margin;
	}

	///////////////////////////////////
	// toString
	///////////////////////////////////

	override public function toString ():String {
		return "[bloom.IconBox]";
	}

}

}
