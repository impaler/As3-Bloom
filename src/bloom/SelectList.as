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
import flash.events.MouseEvent;
import flash.geom.Point;
import flash.geom.Point;

/**
 * List
 *
 * @author sindney, impaler
 */
public class SelectList extends Component {

	private var _display:Label;
	private var _list:List;
	protected var _bg:Sprite;
	protected var _state:int = 0;
	private var _downButton:Button;
	private var _arrow_down_shape:Shape;
	private var _target:Array;

	public function SelectList ( p:DisplayObjectContainer = null , d:Array = null , label:String = "None" ) {
		super ( p );
		brush = ThemeBase.SelectList;

		_list = new List ( null , d );
		_list.height = 160;

		_bg = new Sprite ();
		_bg.buttonMode = true;
		addChild ( _bg );

		_display = new Label ( this , label );
		_display.brush = ThemeBase.Text_SelectList;

		_downButton = new Button ( this );
		_downButton.size ( 20 , 20 );

		_arrow_down_shape = new Shape ();
		addChild ( _arrow_down_shape );

		size ( 100 , 20 );

		_bg.addEventListener ( MouseEvent.MOUSE_DOWN , showList );
		_downButton.addEventListener ( MouseEvent.MOUSE_DOWN , showList );

	}

	private function showList ( event:MouseEvent ):void {
		_bg.removeEventListener ( MouseEvent.MOUSE_DOWN , showList );
		_downButton.removeEventListener ( MouseEvent.MOUSE_DOWN , showList );

		_downButton.addEventListener ( MouseEvent.MOUSE_DOWN , listChoiceDone );
		_bg.addEventListener ( MouseEvent.MOUSE_DOWN , listChoiceDone );
		_list.addEventListener ( Event.CHANGE , listChoiceMade );

		var pos:Point = localToGlobal( new Point ( _bg.x,  _bg.y+ _bg.height ) );
		_list.y = pos.y;
		_list.x = pos.x;
		
		ThemeBase.stage.addChild ( _list );
	}

	private function listChoiceMade ( event:Event ):void {
		listChoiceDone ( );
		_display.text = _list.target.toString ();

		_target = _list.target;
		dispatchEvent ( new Event ( "change" ) );
	}

	private function listChoiceDone ( event:MouseEvent = null ):void {
		_bg.addEventListener ( MouseEvent.MOUSE_DOWN , showList );
		_downButton.addEventListener ( MouseEvent.MOUSE_DOWN , showList );

		_bg.removeEventListener ( MouseEvent.MOUSE_DOWN , listChoiceDone );
		_downButton.removeEventListener ( MouseEvent.MOUSE_DOWN , listChoiceDone );

		ThemeBase.stage.removeChild ( _list );
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

		_arrow_down_shape.graphics.beginFill ( 0xffffff );
		_arrow_down_shape.graphics.moveTo ( 0 , 0 );
		_arrow_down_shape.graphics.lineTo ( 6 , 0 );
		_arrow_down_shape.graphics.lineTo ( 3 , 5 );
		_arrow_down_shape.graphics.lineTo ( 0 , 0 );
		_arrow_down_shape.graphics.endFill ();

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
					scale = bmpBrush.bitmap[0];
					scale.setSize ( _width , _height );
					_bg.graphics.beginBitmapFill ( scale.bitmapData );
					break;
				case 1:
					scale = bmpBrush.bitmap[1];
					scale.setSize ( _width , _height );
					_bg.graphics.beginBitmapFill ( scale.bitmapData );
					break;
				case 2:
					scale = bmpBrush.bitmap[2];
					scale.setSize ( _width , _height );
					_bg.graphics.beginBitmapFill ( scale.bitmapData );
					break;
			}
		}

		_bg.graphics.drawRect ( 0 , 0 , _width , _height );
		_bg.graphics.endFill ();

		_list.y = _bg.height;
		_downButton.x = _bg.width - _downButton.width;
		_arrow_down_shape.x = _downButton.x + _arrow_down_shape.width;
		_arrow_down_shape.y = _downButton.height * .5 - _arrow_down_shape.height * .5;

	}

	///////////////////////////////////
	// toString
	///////////////////////////////////

	override public function toString ():String {
		return "[bloom.SelectList]";
	}

}

}
