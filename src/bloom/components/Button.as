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
import bloom.core.ButtonBase;
import bloom.events.BrushEvent;

import flash.display.DisplayObjectContainer;
import flash.events.Event;
import flash.events.MouseEvent;

/**
 * Button
 *
 * @author sindney
 */
public class Button extends ButtonBase {

	private var _title:Label;

	public function Button ( p:DisplayObjectContainer = null , text:String = "" , down:Function = null ) {
		_title = new Label ( this , text );
		_title.registerComponent = false;

		super ( p );
		addChild ( _title );

		_title.addEventListener ( Event.CHANGE , onTitleChanged );
		_title.addEventListener ( BrushEvent.REDRAW , onTitleChanged );

		if ( down != null ) onDown.add( down );
	}

	override public function applyModel ():void {
		if ( ! _customModel )
			_model = Registry.theme.Button_Model;
		
		super.applyModel ();
		_title.brush = _model.Text_Button;
	}

	protected function onTitleChanged ( e:Event ):void {
		_title.move ( (_width - _title.width) * 0.5 , (_height - _title.height) * 0.5 );
	}

	override protected function draw ( e:Event ):void {
		super.draw ( null );

		switch ( _state ) {
			case Bloom.NORM:
				_title.brush = _model.Text_Button;
				break;
			case Bloom.OVER:
				_title.brush = _model.Text_Button_Over;
				break;
			case Bloom.DOWN:
				_title.brush = _model.Text_Button_Down;
				break;
		}

		_title.move ( (_width - _title.width) * 0.5 , (_height - _title.height) * 0.5 );
	}

	///////////////////////////////////
	// getter/setters
	///////////////////////////////////

	public function get title ():Label {
		return _title;
	}

	///////////////////////////////////
	// toString
	///////////////////////////////////

	override public function toString ():String {
		return "[bloom.Button]";
	}

	override public function destroy ():void {
		super.destroy ();

		_title = null;
	}

}

}