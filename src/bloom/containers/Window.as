package bloom.containers {

import bloom.core.Component;
import bloom.core.OmniCore;

import flash.display.BitmapData;
import flash.display.DisplayObjectContainer;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.Rectangle;

import org.osflash.signals.natives.NativeSignal;

/**
 * Window
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

	private var background:BitmapData;
	private var scaler:BitmapData;

	private var onHeaderClicked:NativeSignal;
	private var onScalerClicked:NativeSignal;

	private var xOffset:Number;
	private var yOffset:Number;

	public function Window (p:DisplayObjectContainer = null,content:FlowContainer = null,moveable:Boolean = true,
	                        resizeable:Boolean = true) {
		super (p);

		_maxWidth = Number.MAX_VALUE;
		_minWidth = 100;
		_maxHeight = Number.MAX_VALUE;
		_minHeight = 100;

		_header = new FlowContainer (this,FlowContainer.HORIZONTALLY);
		_header.tabEnabled = false;

		onHeaderClicked = new NativeSignal (_header,MouseEvent.MOUSE_DOWN,MouseEvent);
		onHeaderClicked.add (onStartWindowDrag);

		_content = content;
		if (_content) addChild (_content);

		_scaler = new Sprite ();
		_scaler.buttonMode = true;
		_scaler.tabEnabled = false;

		onScalerClicked = new NativeSignal (_scaler,MouseEvent.MOUSE_DOWN,MouseEvent);
		onScalerClicked.add (onScalerMouseDown);

		_footer = new FlowContainer (this,FlowContainer.HORIZONTALLY);

		_headerSize = 30;
		_footerSize = 30;

		this.moveable = moveable;
		this.resizeable = resizeable;
		liveResize = false;

		_rect = new Rectangle ();

		style = OmniCore.defaultTheme.window;

		size (200,100);
	}

	private function onStartWindowDrag (e:MouseEvent):void {
		if (moveable) {
			xOffset = e.stageX - this.x;
			yOffset = e.stageY - this.y;
			OmniCore.onStageMouseMove.add (onWindowMouseMove);
			OmniCore.onStageMouseUp.add (onWindowMouseUp);
		}
	}

	private function onWindowMouseMove (e:MouseEvent):void {
		this.x = e.stageX - xOffset;
		this.y = e.stageY - yOffset;
		e.updateAfterEvent ();
	}

	private function onWindowMouseUp (event:MouseEvent):void {
		OmniCore.onStageMouseMove.remove (onWindowMouseMove);
		OmniCore.onStageMouseUp.remove (onWindowMouseUp);
	}

	private function onScalerMouseDown (e:MouseEvent):void {
		xOffset = e.stageX - _scaler.x;
		yOffset = e.stageY - _scaler.y;
		OmniCore.onStageMouseMove.add (onScalerMouseMove);
		OmniCore.onStageMouseUp.add (onScalerMouseUp);
	}

	private function onScalerMouseMove (e:MouseEvent):void {
		_scaler.x = e.stageX - xOffset;
		_scaler.y = e.stageY - yOffset;
		if (liveResize) size (_scaler.x + _footerSize,_scaler.y + _footerSize);
		e.updateAfterEvent ();
	}

	private function onScalerMouseUp (e:MouseEvent):void {
		OmniCore.onStageMouseMove.remove (onScalerMouseMove);
		OmniCore.onStageMouseUp.remove (onScalerMouseUp);
		size (_scaler.x + _footerSize,_scaler.y + _footerSize);
		_scaler.stopDrag ();
	}

	/**
	 * Update window's layout.
	 */
	public function update ():void {
		_header.size (_width,_headerSize);
		if (_content) {
			_content.move (_content.margin.left,_headerSize + _content.margin.top);
			_content.size (_width - _content.margin.left - content.margin.right,
			               _height - _content.margin.top - _content.margin.bottom - _headerSize - _footerSize);
		}
		_footer.move (0,_headerSize + (_content ? _content.height + _content.margin.top + _content.margin.bottom : 0));
		_footer.size (_width,_footerSize);
		_scaler.x = _width - _footerSize;
		_scaler.y = _height - _footerSize;
	}

	override public function size (width:Number,height:Number):void {
		if (_width != width || _height != height) {
			_width = width;
			if (_width > _maxWidth)_width = _maxWidth;
			if (_width < _minWidth)_width = _minWidth;
			_height = height;
			if (_height > _maxHeight)_height = _maxHeight;
			if (_height < _minHeight)_height = _minHeight;
			_changed = true;
			invalidate ();
			_onResized.dispatch ();
		}
	}

	override public function dispose (gc:Boolean = false):void {
		super.dispose (gc);
		if (background) background.dispose ();
		background = null;
		if (scaler) scaler.dispose ();
		scaler = null;
		graphics.clear ();
		_scaler.graphics.clear ();
		removeChild (_scaler);
		removeChild (_header);
		_header.dispose (false);
		removeChild (_footer);
		_footer.dispose (false);
		if (_content) {
			removeChild (_content);
			_content.dispose (false);
		}
		onHeaderClicked.removeAll ();
		onHeaderClicked = null;
		onScalerClicked.removeAll ();
		onScalerClicked = null;
	}

	override protected function onThemeChanged ():void {
		style = OmniCore.defaultTheme.window;
	}

	override protected function draw (e:Event = null):void {
		if (! _changed) return;
		_changed = false;

		var style:WindowStyle = _style as WindowStyle;
		if (background) background.dispose ();
		if (scaler) scaler.dispose ();

		_header.style = style.header;
		_footer.style = style.footer;

		graphics.clear ();
		style.background.setSize (_width,_height - _headerSize - _footerSize);
		background = style.background.bitmapData.clone ();
		graphics.beginBitmapFill (background);
		graphics.drawRect (0,_headerSize,_width,_height - _headerSize - _footerSize);
		graphics.endFill ();

		_scaler.graphics.clear ();
		style.scaler.setSize (_footerSize,_footerSize);
		scaler = style.scaler.bitmapData.clone ();
		_scaler.graphics.beginBitmapFill (scaler);
		_scaler.graphics.drawRect (0,0,_footerSize,_footerSize);
		_scaler.graphics.endFill ();

		update ();
	}

	///////////////////////////////////
	// getter/setters
	///////////////////////////////////

	public function set headerSize (value:Number):void {
		if (_headerSize != value) {
			_headerSize = value;
			update ();
		}
	}

	public function get headerSize ():Number {
		return _headerSize;
	}

	public function set footerSize (value:Number):void {
		if (_footerSize != value) {
			_footerSize = value;
			_changed = true;
			invalidate ();
		}
	}

	public function get footerSize ():Number {
		return _footerSize;
	}

	public function set resizeable (value:Boolean):void {
		if (_resizeable != value) {
			_resizeable = value;
			_resizeable ? addChild (_scaler) : removeChild (_scaler);
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

	public function set maxWidth (value:Number):void {
		if (_maxWidth != value) {
			_maxWidth = value;
			if (_width > _maxWidth)_width = _maxWidth;
		}
	}

	public function get maxWidth ():Number {
		return _maxWidth;
	}

	public function set minWidth (value:Number):void {
		if (_minWidth != value) {
			_minWidth = value;
			if (_width < _minWidth)_width = _minWidth;
		}
	}

	public function get minWidth ():Number {
		return _minWidth;
	}

	public function set maxHeight (value:Number):void {
		if (_maxHeight != value) {
			_maxHeight = value;
			if (_height > _maxHeight)_height = _maxHeight;
		}
	}

	public function get maxHeight ():Number {
		return _maxHeight;
	}

	public function set minHeight (value:Number):void {
		if (_minHeight != value) {
			_minHeight = value;
			if (_height < _minHeight)_height = _minHeight;
		}
	}

	public function get minHeight ():Number {
		return _minHeight;
	}

	override public function set width (value:Number):void {
		if (_width != value) {
			if (_width > _maxWidth)_width = _maxWidth;
			if (_width < _minWidth)_width = _minWidth;
			_changed = true;
			invalidate ();
			dispatchEvent (new Event ("resize"));
		}
	}

	override public function set height (value:Number):void {
		if (_height != value) {
			if (_height > _maxHeight)_height = _maxHeight;
			if (_height < _minHeight)_height = _minHeight;
			_changed = true;
			invalidate ();
			dispatchEvent (new Event ("resize"));
		}
	}

	public function set moveable (value:Boolean):void {
		if (_moveable != value) {
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
		return "[bloom.components.Window]";
	}

}

}
