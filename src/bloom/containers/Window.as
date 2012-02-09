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
import bloom.components.Button;
import bloom.core.Bloom;
import bloom.core.Component;
import bloom.core.ScaleBitmap;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;

/**
 * Window
 *
 * @author sindney
 */
public class Window extends Component {

	public var _liveResize:Boolean;

	protected var _moveable:Boolean;
	protected var _resizeable:Boolean;

	protected var _maxWidth:Number;
	protected var _minWidth:Number;
	protected var _maxHeight:Number;
	protected var _minHeight:Number;

	protected var _headerHeight:Number;
	protected var _footerHeight:Number;
	
	protected var _header:FlowContainer;
	protected var _content:FlowContainer;
	protected var _footer:FlowContainer;
	protected var _scaler:Sprite;

	protected var _closeBtn:Button;
	
	
	protected var xOffset:Number;

	protected var yOffset:Number;
	
	protected var _window_model:WindowModel;

	public function Window ( content:FlowContainer = null ) {
		_content = content;
		if ( _content == null ) {
			_content = new FlowContainer ();
			_content.direction = Bloom.VERTICALLY;
			_content.hAlignment = Bloom.CENTRE;
			_content.tabEnabled = false;
			_content.registerComponent = false;
		}
		addChild ( _content );

		_scaler = new Sprite ();
		_scaler.buttonMode = true;
		_scaler.tabEnabled = false;

		_footer = new FlowContainer ();
		_footer.registerComponent = false;
		addChild ( _footer );
		
		_header = new FlowContainer ();
		_header.direction = Bloom.HORIZONTALLY;
		_header.hAlignment = Bloom.RIGHT;
		_header.tabEnabled = false;
		_header.registerComponent = false;
		addChild ( _header );
		
		_closeBtn = new Button(null, "x", closeWindow );
		_closeBtn.registerComponent = false;
		_closeBtn.size(20,20);
		_header.addContent ( _closeBtn );

		super ( null );

	}

	public function openWindow (e:Event=null):void {
		Bloom.core().stage.addChild(this);
	}
	
	public function closeWindow (e:Event=null):void {
		Bloom.core().stage.removeChild(this);
	}	

	override public function applyModel ():void {
		super.applyModel ();
		
		var _prevModel:WindowModel = _window_model;
		if ( ! _customModel ) {
			_window_model = Registry.theme.Window_Model;
		}
		brush = _window_model.brush;

		_maxWidth = _window_model.maxWidth;
		_minWidth = _window_model.minWidth;
		_maxHeight = _window_model.maxHeight;
		_minHeight = _window_model.minHeight;
		
		_header.brush = _window_model.Window_Header;
		_footer.brush = _window_model.Window_Footer;
		_headerHeight = _window_model.headerHeight;
		_footerHeight = _window_model.footerHeight;
		
		liveResize = _window_model.liveResize;
		resizeable = _window_model.resizeable;
		moveable = _window_model.moveable;
		
		if ( width == 0 && height == 0 || width == _prevModel.defaultWidth && height == _prevModel.defaultHeight ) {
			if ( width != _window_model.defaultWidth && height != _window_model.defaultHeight) {
				size ( _window_model.defaultWidth , _window_model.defaultHeight );
			}
		}

		
	}

	private function set liveResize ( liveResize:Boolean ):void {_liveResize = liveResize;}

	private function onStartWindowDrag ( e:MouseEvent ):void {
		if ( moveable ) {
			xOffset = e.stageX - this.x;
			yOffset = e.stageY - this.y;
			Bloom.core().stage.addEventListener ( MouseEvent.MOUSE_MOVE , onWindowDragMouseMove );
			Bloom.core().stage.addEventListener ( MouseEvent.MOUSE_UP , onWindowDragMouseUp );
		}
	}

	private function onWindowDragMouseMove ( e:MouseEvent ):void {
		this.x = e.stageX - xOffset;
		this.y = e.stageY - yOffset;
		e.updateAfterEvent ();
	}

	private function onWindowDragMouseUp ( event:MouseEvent ):void {
		Bloom.core().stage.removeEventListener ( MouseEvent.MOUSE_MOVE , onWindowDragMouseMove );
		Bloom.core().stage.removeEventListener ( MouseEvent.MOUSE_UP , onWindowDragMouseUp );
	}

	private function onScaleWindowMouseDown ( e:MouseEvent ):void {
		if ( _liveResize ) {
			xOffset = e.stageX - _scaler.x;
			yOffset = e.stageY - _scaler.y;
			Bloom.core().stage.addEventListener ( MouseEvent.MOUSE_MOVE , onScaleWindowMouseMove );
			Bloom.core().stage.addEventListener ( MouseEvent.MOUSE_UP , onScaleWindowMouseUp );
		}
	}

	private function onScaleWindowMouseMove ( e:MouseEvent ):void {
		_scaler.x = e.stageX - xOffset;
		_scaler.y = e.stageY - yOffset;
		size ( _scaler.x + _footerHeight , _scaler.y + _footerHeight );
		e.updateAfterEvent ();
	}

	private function onScaleWindowMouseUp ( e:MouseEvent ):void {
		Bloom.core().stage.removeEventListener ( MouseEvent.MOUSE_UP , onScaleWindowMouseUp );
		Bloom.core().stage.removeEventListener ( MouseEvent.MOUSE_MOVE , onScaleWindowMouseMove );
		size ( _scaler.x + _footerHeight , _scaler.y + _footerHeight );
		_scaler.stopDrag ();
	}

	/**
	 * Update child's layout.
	 */
	public function update ():void {
		_header.size ( _width , _headerHeight );
		
		if ( _content ) {
			_content.move ( _content.margin.left , _headerHeight + _content.margin.top );
			_content.size ( _width - _content.margin.left - content.margin.right ,
			                _height - _content.margin.top - _content.margin.bottom - _headerHeight - _footerHeight );
		}
		_footer.move ( 0 ,
		               _headerHeight + (_content ? _content.height + _content.margin.top + _content.margin.bottom : 0) );
		_footer.size ( _width , _footerHeight );
		_scaler.x = _width - _footerHeight;
		_scaler.y = _height - _footerHeight;
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
			_scaler.graphics.moveTo ( 0 , _footerHeight );
			_scaler.graphics.lineTo ( _footerHeight , _footerHeight );
			_scaler.graphics.lineTo ( _footerHeight , 0 );
			_scaler.graphics.lineTo ( 0 , _footerHeight );
			_scaler.graphics.endFill ();
		} else if ( brush is BMPBrush ) {
			bmpBrush = brush as BMPBrush;
			scale = bmpBrush.bitmap[0];
			scale.setSize ( _width , _height - _headerHeight - _footerHeight );
			graphics.beginBitmapFill ( scale.bitmapData );

			scale = bmpBrush.bitmap[1];
			scale.setSize ( _footerHeight , _footerHeight );
			_scaler.graphics.beginBitmapFill ( scale.bitmapData );
			_scaler.graphics.drawRect ( 0 , 0 , _footerHeight , _footerHeight );
			_scaler.graphics.endFill ();
		}

		graphics.drawRect ( 0 , _headerHeight , _width , _height - _headerHeight - _footerHeight );
		graphics.endFill ();

		update ();
	}

	///////////////////////////////////
	// getter/setters
	///////////////////////////////////

	public function set headerHeight ( value:Number ):void {
		if ( _headerHeight != value ) {
			_headerHeight = value;
			update ();
		}
	}

	public function get headerHeight ():Number {
		return _headerHeight;
	}

	public function set footerHeight ( value:Number ):void {
		if ( _footerHeight != value ) {
			_footerHeight = value;
			_changed = true;
			invalidate ();
		}
	}

	public function get footerHeight ():Number {
		return _footerHeight;
	}

	public function set resizeable ( value:Boolean ):void {
		if ( _resizeable != value ) {
			_resizeable = value;
			_resizeable ? addChild ( _scaler ) : removeChild ( _scaler );
			update ();
		}
		
		value ? _scaler.addEventListener ( MouseEvent.MOUSE_DOWN , onScaleWindowMouseDown ) : 		
		              _scaler.removeEventListener ( MouseEvent.MOUSE_DOWN , onScaleWindowMouseDown );
		
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
		if ( value ) {
			_header.addEventListener ( MouseEvent.MOUSE_DOWN , onStartWindowDrag );
		} else {
			_header.removeEventListener ( MouseEvent.MOUSE_DOWN , onStartWindowDrag );
		}
		
		_header.buttonMode = value;
		_header.useHandCursor = value;
		
		_moveable = value;
		
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
