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
package bloom.components {

import bloom.core.Bloom;
import bloom.core.TextBase;

import flash.display.DisplayObjectContainer;

/**
 * Label
 *
 * @author sindney
 */
public class Label extends TextBase {

	public function Label ( p:DisplayObjectContainer = null , text:String = "" ) {
		selectable = mouseEnabled = tabEnabled = false;
		type = "dynamic";
		autoSize = "left";

		this.text = text;

		super ( p );

	}

	override public function applyModel ():void {
		if ( ! _customModel )
		_model = Registry.theme.Label_Model;
		brush = _model.Text_Label;
	}

	
//	override public function get registerComponent ():Boolean {
//		return _registerComponent;
//	}
//
//	override public function set registerComponent ( value:Boolean ):void {
//		//todo
////		Bloom.core ().lookupCoreComponent ( this , true );
//		_registerComponent = value;
//
//	}

	///////////////////////////////////
	// toString
	///////////////////////////////////

	override public function toString ():String {
		return "[bloom.Label]";
	}

	override public function destroy ():void {
		_model = null;
	}

}

}