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

import bloom.brushes.BMPBrush;
import bloom.brushes.ColorBrush;
import bloom.core.Component;
import bloom.core.ScaleBitmap;
import bloom.themes.ThemeBase;

import flash.display.DisplayObjectContainer;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.Rectangle;

/**
 * Window
 *
 * @date 2012/1/20 14:16
 * @author sindney
 */
public class Window extends Component {

	public var liveResize:Boolean;

	private var _moveable:Boolean;
	private var _resizeable:Boolean;

	private var _maxWidth:Number;
	private var _minWidth:Number;
	private var _maxHeight:Number;
	private var _minHeight:Number;

	private var _headerSize:Number;
	private var _footerSize:Number;

	private var _rect:Rectangle;

	private var _header:FlowContainer;
	private var _content:FlowContainer;
	private var _footer:FlowContainer;
	private var _scaler:Sprite;

	private var _xOffset:Number;
	private var _yOffset:Number;

	private var _autoOpen:Boolean;

	public function Window ( p:DisplayObjectContainer = null , content:FlowContainer = null , moveable:Boolean = true ,
	                         resizeable:Boolean = true , autoOpen:Boolean = true ) {
		_maxWidth = Number.MAX_VALUE;
		_minWidth = 100;
		_maxHeight = Number.MAX_VALUE;
		_minHeight = 100;
		_headerSize = 30;
		_footerSize = 30;
		_autoOpen = autoOpen;
		liveResize = false;

		_rect = new Rectangle ();

		_header = new FlowContainer ();
		_header.tabEnabled = false;
		_header.addEventListener ( MouseEvent.MOUSE_DOWN , onStartWindowDrag );
		addChild ( _header );

		_content = content;
		if ( _content ) addChild ( _content );

		_scaler = new Sprite ();
		_scaler.buttonMode = true;
		_scaler.useHandCursor = true;
		_scaler.tabEnabled = false;
		_scaler.addEventListener ( MouseEvent.MOUSE_DOWN , onScaleWindowMouseDown );

		_footer = new FlowContainer ();
		addChild ( _footer );

		super ( p );

		this.moveable = moveable;
		this.resizeable = resizeable;
		size ( 100 , 100 );

		_autoOpen ? open () : close ();
	}

	public function open ():void {
		this.visible = true;
	}

	public function close ():void {
		this.visible = false;
	}

	override public function setCoreBrush ():void {
		super.setCoreBrush ();

		brush = ThemeBase.Window;
		_header.brush = ThemeBase.Window_Header;
		_footer.brush = ThemeBase.Window_Footer;
	}

	private function onStartWindowDrag ( e:MouseEvent ):void {
		if ( moveable ) {
			_xOffset = e.stageX - this.x;
			_yOffset = e.stageY - this.y;
			stage.addEventListener ( MouseEvent.MOUSE_MOVE , onWindowDragMouseMove );
			stage.addEventListener ( MouseEvent.MOUSE_UP , onWindowDragMouseUp );
		}
	}

	private function onWindowDragMouseMove ( e:MouseEvent ):void {
		this.x = e.stageX - _xOffset;
		this.y = e.stageY - _yOffset;
		e.updateAfterEvent ();
	}

	private function onWindowDragMouseUp ( event:MouseEvent ):void {
		stage.removeEventListener ( MouseEvent.MOUSE_MOVE , onWindowDragMouseMove );
		stage.removeEventListener ( MouseEvent.MOUSE_UP , onWindowDragMouseUp );
	}

	private function onScaleWindowMouseDown ( e:MouseEvent ):void {
		if ( liveResize ) {
			_xOffset = e.stageX - _scaler.x;
			_yOffset = e.stageY - _scaler.y;
			stage.addEventListener ( MouseEvent.MOUSE_MOVE , onScaleWindowMouseMove );
			stage.addEventListener ( MouseEvent.MOUSE_UP , onScaleWindowMouseUp );
		}
	}

	private function onScaleWindowMouseMove ( e:MouseEvent ):void {
		_scaler.x = e.stageX - _xOffset;
		_scaler.y = e.stageY - _yOffset;
		size ( _scaler.x + _footerSize , _scaler.y + _footerSize );
		e.updateAfterEvent ();
	}

	private function onScaleWindowMouseUp ( e:MouseEvent ):void {
		stage.removeEventListener ( MouseEvent.MOUSE_UP , onScaleWindowMouseUp );
		stage.removeEventListener ( MouseEvent.MOUSE_MOVE , onScaleWindowMouseMove );
		size ( _scaler.x + _footerSize , _scaler.y + _footerSize );
		_scaler.stopDrag ();
	}

	/**
	 * Update child's layout.
	 */
	public function update ():void {
		_header.size ( _width , _headerSize );
		if ( _content ) {
			_content.move ( _content.margin.left , _headerSize + _content.margin.top );
			_content.size ( _width - _content.margin.left - content.margin.right ,
			                _height - _content.margin.top - _content.margin.bottom - _headerSize - _footerSize );
		}
		_footer.move ( 0 ,
		               _headerSize + (_content ? _content.height + _content.margin.top + _content.margin.bottom : 0) );
		_footer.size ( _width , _footerSize );
		_scaler.x = _width - _footerSize;
		_scaler.y = _height - _footerSize;
	}

	override public function size ( w:Number , h:Number ):void {
		if ( _width != w || _height != h ) {
			_width = w;
			if ( _width > _maxWidth )_width = _maxWidth;
			if ( _width < _minWidth )_width = _minWidth;
			_height = h;
			if ( _height > _maxHeight )_height = _maxHeight;
			if ( _height < _minHeight )_height = _minHeight;
			_changed = true;
			invalidate ();
			dispatchEvent ( new Event ( "resize" ) );
		}
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

		graphics.clear ();
		_scaler.graphics.clear ();

		if ( brush is ColorBrush ) {
			colorBrush = brush as ColorBrush;
			graphics.beginFill ( colorBrush.colors[0] );

			_scaler.graphics.beginFill ( colorBrush.colors[1] );
			_scaler.graphics.moveTo ( 0 , _footerSize );
			_scaler.graphics.lineTo ( _footerSize , _footerSize );
			_scaler.graphics.lineTo ( _footerSize , 0 );
			_scaler.graphics.lineTo ( 0 , _footerSize );
			_scaler.graphics.endFill ();
		} else if ( brush is BMPBrush ) {
			bmpBrush = brush as BMPBrush;
			scale = bmpBrush.bitmap[0];
			scale.setSize ( _width , _height - _headerSize - _footerSize );
			graphics.beginBitmapFill ( scale.bitmapData );

			scale = bmpBrush.bitmap[1];
			scale.setSize ( _footerSize , _footerSize );
			_scaler.graphics.beginBitmapFill ( scale.bitmapData );
			_scaler.graphics.drawRect ( 0 , 0 , _footerSize , _footerSize );
			_scaler.graphics.endFill ();
		}

		graphics.drawRect ( 0 , _headerSize , _width , _height - _headerSize - _footerSize );
		graphics.endFill ();

		update ();
	}

	///////////////////////////////////
	// getter/setters
	///////////////////////////////////

	public function set headerSize ( value:Number ):void {
		if ( _headerSize != value ) {
			_headerSize = value;
			update ();
		}
	}

	public function get headerSize ():Number {
		return _headerSize;
	}

	public function set footerSize ( value:Number ):void {
		if ( _footerSize != value ) {
			_footerSize = value;
			_changed = true;
			invalidate ();
		}
	}

	public function get footerSize ():Number {
		return _footerSize;
	}

	public function set resizeable ( value:Boolean ):void {
		if ( _resizeable != value ) {
			_resizeable = value;
			_resizeable ? addChild ( _scaler ) : removeChild ( _scaler );
			update ();
		}
	}

	public function get resizeable ():Boolean {
		return _resizeable;
	}

	public function get header ():FlowContainer {
		return _header;
	}

	public function get footer ():FlowContainer {
		return _footer;
	}

	public function get content ():FlowContainer {
		return _content;
	}

	public function set maxWidth ( value:Number ):void {
		if ( _maxWidth != value ) {
			_maxWidth = value;
			if ( _width > _maxWidth )_width = _maxWidth;
		}
	}

	public function get maxWidth ():Number {
		return _maxWidth;
	}

	public function set minWidth ( value:Number ):void {
		if ( _minWidth != value ) {
			_minWidth = value;
			if ( _width < _minWidth )_width = _minWidth;
		}
	}

	public function get minWidth ():Number {
		return _minWidth;
	}

	public function set maxHeight ( value:Number ):void {
		if ( _maxHeight != value ) {
			_maxHeight = value;
			if ( _height > _maxHeight )_height = _maxHeight;
		}
	}

	public function get maxHeight ():Number {
		return _maxHeight;
	}

	public function set minHeight ( value:Number ):void {
		if ( _minHeight != value ) {
			_minHeight = value;
			if ( _height < _minHeight )_height = _minHeight;
		}
	}

	public function get minHeight ():Number {
		return _minHeight;
	}

	override public function set width ( value:Number ):void {
		if ( _width != value ) {
			if ( _width > _maxWidth )_width = _maxWidth;
			if ( _width < _minWidth )_width = _minWidth;
			_changed = true;
			invalidate ();
			dispatchEvent ( new Event ( "resize" ) );
		}
	}

	override public function set height ( value:Number ):void {
		if ( _height != value ) {
			if ( _height > _maxHeight )_height = _maxHeight;
			if ( _height < _minHeight )_height = _minHeight;
			_changed = true;
			invalidate ();
			dispatchEvent ( new Event ( "resize" ) );
		}
	}

	public function set moveable ( value:Boolean ):void {
		if ( _moveable != value ) {
			_moveable = _header.buttonMode = _header.useHandCursor = value;
		}
	}

	public function get moveable ():Boolean {
		return _moveable;
	}

	///////////////////////////////////
	// toString
	///////////////////////////////////

	override public function toString ():String {
		return "[bloom.containers.Window]";
	}

}

}
