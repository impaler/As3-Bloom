package bloom.components.containers {

import bloom.components.controls.Button;
import bloom.components.controls.ButtonBase;
import bloom.style.components.containers.WindowStyle;
import bloom.core.Component;
import bloom.core.ComponentConstants;
import bloom.core.ObjectBase;
import bloom.core.OmniCore;

import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.Rectangle;

import org.osflash.signals.natives.NativeSignal;

/**
 * Window
 *
 * @description Window Component with Container Content
 *
 */
public class Window extends Component {

	public var liveResize:Boolean;
	public var _autoOpen:Boolean;

	private var _moveable:Boolean;
	private var _resizeable:Boolean;

	private var _titleText:String;

	private var _maxWidth:Number;
	private var _minWidth:Number;
	private var _maxHeight:Number;
	private var _minHeight:Number;

	private var _headerSize:Number;
	private var _footerSize:Number;

	private var _rect:Rectangle;
	private var _windowOpen:Boolean;

	private var _header:TitleBar;
	private var _contentContainer:Container;
	private var _footer:Container;

	private var _scaler:ButtonBase;

	private var onHeaderClicked:NativeSignal;
	private var onScalerClicked:NativeSignal;

	private var xOffset:Number;
	private var yOffset:Number;

	private var _scrollContainer:ScrollContainer;
	private var _maximized:Boolean;

	private var _restoreWindow:ObjectBase;

	private var onHeaderMaximize:NativeSignal;

	public function Window (title:String = "",content:Container = null,autoOpen:Boolean = true,moveable:Boolean = true,
	                        resizeable:Boolean = true) {
		_windowOpen = false;

		super ();

		if (content) addScrollContent (content);

		_autoOpen = autoOpen;
		if (_autoOpen) openWindow ();

		this.title = title;
		this.moveable = moveable;
		this.resizeable = resizeable;
	}

	public function openWindow (e:* = null):void {
		OmniCore.stage.addChild (this);
		_windowOpen = true;
	}

	public function closeWindow (e:* = null):void {
		if (this.parent) OmniCore.stage.removeChild (this);
		_windowOpen = false;
	}

	public function addScrollContent (content:Container):void {
		if (_contentContainer) {
			removeChild (_contentContainer);
			_contentContainer.dispose ();
		}
		_contentContainer = content;

		_scrollContainer = new ScrollContainer ();
		addChild (_scrollContainer);

//		_scrollContainer.setScrollBar (true,true);
		_scrollContainer.getScrollBar (ComponentConstants.HORIZONTALLY).height = windowStyle.scrollbarSize;
		_scrollContainer.getScrollBar (ComponentConstants.VERTICALLY).width = windowStyle.scrollbarSize;
		_scrollContainer.addContent (_contentContainer);
		_scrollContainer.drawDirectly ();
	}

	public function onMaximize(e:*=null) :void {
		if (!_maximized) {
			_maximized = true;
			_restoreWindow = getDimensionObject;

			OmniCore.onStageResize.add(maximize);
			onHeaderClicked.remove (onStartWindowDrag);
			onScalerClicked.remove (onScalerMouseDown);
			maximize();

		} else {
			_maximized = false;
			OmniCore.onStageResize.remove(maximize);
			onHeaderClicked.add (onStartWindowDrag);
			onScalerClicked.add (onScalerMouseDown);

			move(_restoreWindow.x,_restoreWindow.y);
			size(_restoreWindow.width, _restoreWindow.height);
		}

	}

	public function maximize (e:*=null):void {
		move(0,0);
		size(OmniCore.stage.stageWidth, OmniCore.stage.stageHeight);
	}

	///////////////////////////////////
	// Base Component Methods
	///////////////////////////////////

	override protected function initDefaultStyle ():void {
		super.initDefaultStyle ();

		_maxWidth = windowStyle.maxWidth;
		_minWidth = windowStyle.minWidth;
		_maxHeight = windowStyle.maxHeight;
		_minHeight = windowStyle.minHeight;
		_headerSize = windowStyle.headerSize;
		_footerSize = windowStyle.footerSize;
		liveResize = false;
		_maximized=false;
	}

	override protected function onStyleChanged ():void {
		_style = OmniCore.defaultTheme.windowStyle;
		super.onStyleChanged ();
	}

	override protected function createAssets ():void {
		super.createAssets ();

		_header = new TitleBar ();
		addChild(_header);
		_header.customStyle = true;
		_header.tabEnabled = false;
		_header.closeButton.mouseDown.add(closeWindow);
		_header.maximizeButton.mouseDown.add(onMaximize);


		_header.bg.doubleClickEnabled = true;
		onHeaderMaximize = new NativeSignal (_header.bg,MouseEvent.DOUBLE_CLICK,MouseEvent);
		onHeaderMaximize.add(onMaximize);

		_footer = new HBox (this);
		_footer.customStyle = true;
		_footer.tabEnabled = false;
		_footer.autoWidth = false;
		_footer.autoHeight = false;

		_scaler = new ButtonBase ();
		_scaler.buttonMode = true;
		_scaler.tabEnabled = false;

		_rect = new Rectangle ();

		onHeaderClicked = new NativeSignal (_header.bg,MouseEvent.MOUSE_DOWN,MouseEvent);
		onScalerClicked = _scaler.mouseDown;
	}

	///////////////////////////////////
	// Signal Methods
	///////////////////////////////////

	override public function enableSignals ():void {
		super.enableSignals ();

		onHeaderClicked.add (onStartWindowDrag);
		onScalerClicked.add (onScalerMouseDown);
	}

	override public function disableSignals ():void {
		super.disableSignals ();

		onHeaderClicked.remove (onStartWindowDrag);
		onScalerClicked.remove (onScalerMouseDown);
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

	///////////////////////////////////
	// Draw Methods
	///////////////////////////////////

	override protected function draw (e:Event = null):void {
		if (! _changed) return;
		_changed = false;

//			var style:WindowStyle = _style as WindowStyle;
//			if (background) background.dispose();
//			if (scaler) scaler.dispose();
//
//			_header.style = style.header;
//			_footer.style = style.footer;
//
//			graphics.clear();
//			style.background.setSize(_width, _height - _headerSize - _footerSize);
//			background = style.background.bitmapData.clone();
//			graphics.beginBitmapFill(background);
//			graphics.drawRect(0, _headerSize, _width, _height - _headerSize - _footerSize);
//			graphics.endFill();
//
//			_scaler.graphics.clear();
//			style.scaler.setSize(_footerSize, _footerSize);
//			scaler = style.scaler.bitmapData.clone();
//			_scaler.graphics.beginBitmapFill(scaler);
//			_scaler.graphics.drawRect(0, 0, _footerSize, _footerSize);
//			_scaler.graphics.endFill();

		update ();
	}

	public function update ():void {
		_header.size (_width,_headerSize);

		if (_contentContainer) {

			var contentWidth:Number = _width - _contentContainer.padding.left - contentContainer.padding.right;
			var contentHeight:Number = _height - _contentContainer.padding.top - _contentContainer.padding.bottom - _headerSize - _footerSize;

			var contentX:Number = _contentContainer.padding.left;
			var contentY:Number = _headerSize + _contentContainer.padding.top;

			_scrollContainer.move (contentX,contentY);
			_scrollContainer.size (contentWidth,contentHeight);

			_scrollContainer.drawDirectly ();
			_contentContainer.drawDirectly ();
		}

		var footerX:Number = 0;
		var footerY:Number = _headerSize + (_scrollContainer ? _scrollContainer.height + _scrollContainer.padding.top + _scrollContainer.padding.bottom : 0);

		_footer.size (_width,_footerSize);
		_footer.move (footerX,footerY);
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
			onResized.dispatch ();
		}
	}

	///////////////////////////////////
	// getter/setters
	///////////////////////////////////

	public function get windowStyle ():WindowStyle {
		return _style as WindowStyle;
	}

	private function set title (title:String):void {
		if ( title != _titleText ) {
			_titleText = title;
			_header.title.text = _titleText;
		}
	}

	public function get contentContainer ():Container {
		return _contentContainer;
	}

	public function get header ():Container {
		return _header;
	}

	public function get footer ():Container {
		return _footer;
	}

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

	public function set moveable (value:Boolean):void {
		if (_moveable != value) {
			_moveable = _header.buttonMode = _header.useHandCursor = value;
		}
	}

	public function get moveable ():Boolean {
		return _moveable;
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

	///////////////////////////////////
	// Dispose
	///////////////////////////////////

	override public function dispose (gc:Boolean = false):void {
		_scaler.dispose ();
		_scaler = null;
		_header.dispose ();
		_header = null;
		_footer.dispose ();
		_footer = null;
		if (_contentContainer) _contentContainer.dispose ();
		_contentContainer = null;
		if (_scrollContainer) _scrollContainer.dispose ();
		_scrollContainer = null;

		onHeaderClicked.removeAll ();
		onHeaderClicked = null;
		onScalerClicked.removeAll ();
		onScalerClicked = null;

		super.dispose (gc);
	}

	///////////////////////////////////
	// toString
	///////////////////////////////////

	override public function toString ():String {
		return "[bloom.components.Window]";
	}

}

}
