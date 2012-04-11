package bloom.components.containers {

import bloom.components.controls.ButtonBase;
import bloom.core.Component;
import bloom.core.ComponentConstants;
import bloom.core.ObjectBase;
import bloom.core.OmniCore;
import bloom.style.components.containers.WindowStyle;

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

	protected var _liveResize:Boolean;
	protected var _autoOpen:Boolean;
	protected var _moveable:Boolean;
	protected var _resizeable:Boolean;
	protected var _titleText:String;
	protected var _maxWidth:Number;
	protected var _minWidth:Number;
	protected var _maxHeight:Number;
	protected var _minHeight:Number;
	protected var _headerSize:Number;
	protected var _footerSize:Number;
	protected var _windowOpen:Boolean;
	protected var _rect:Rectangle;
	protected var _xOffset:Number;
	protected var _yOffset:Number;
	protected var _maximized:Boolean;
	protected var _restoreWindow:ObjectBase;

	protected var _header:TitleBar;
	protected var _footer:Container;
	protected var _scaler:ButtonBase;
	protected var _contentContainer:Container;
	protected var _scrollContainer:ScrollContainer;

	protected var onHeaderClicked:NativeSignal;
	protected var onScalerClicked:NativeSignal;
	protected var onHeaderMaximize:NativeSignal;

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
		positionBehaviour ();
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

		_scrollContainer.setScrollBar (true,true);
		_scrollContainer.getScrollBar (ComponentConstants.HORIZONTALLY).height = windowStyle.scrollbarSize;
		_scrollContainer.getScrollBar (ComponentConstants.VERTICALLY).width = windowStyle.scrollbarSize;
		_scrollContainer.addContent (_contentContainer);
		_scrollContainer.drawDirectly ();
	}

	public function onMaximize (e:* = null):void {
		if (! _maximized) {
			_maximized = true;
			_restoreWindow = getDimensionObject;

			OmniCore.onStageResize.add (maximize);
			onHeaderClicked.remove (onStartWindowDrag);
			onScalerClicked.remove (onScalerMouseDown);
			maximize ();

		} else {
			_maximized = false;
			OmniCore.onStageResize.remove (maximize);
			onHeaderClicked.add (onStartWindowDrag);
			onScalerClicked.add (onScalerMouseDown);

			move (_restoreWindow.x,_restoreWindow.y);
			size (_restoreWindow.width,_restoreWindow.height);
		}

	}

	public function maximize (e:* = null):void {
		move (0,0);
		size (OmniCore.stage.stageWidth,OmniCore.stage.stageHeight);
	}

	public function positionBehaviour ():void {
		setToCentreTop ();
	}

	public function setToCentreTop (topPadding:Number = 30):void {
		var Xpos:Number = ((OmniCore.stage.stageWidth * .5) - (this.width * .5));
		move (Xpos,topPadding);

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
		_liveResize = false;
		_maximized = false;
	}

	override protected function onStyleChanged ():void {

		_style = OmniCore.defaultTheme.windowStyle;
		_scaler.style = windowStyle.scaler;
		_scaler.size(windowStyle.scaler.defaultWidth, windowStyle.scaler.defaultHeight);

		super.onStyleChanged ();
	}

	override protected function createAssets ():void {
		super.createAssets ();

		_header = new TitleBar ();
		addChild (_header);
		_header.customStyle = true;
		_header.tabEnabled = false;
		_header.closeButton.mouseDown.add (closeWindow);
		_header.maximizeButton.mouseDown.add (onMaximize);
		_header.bg.doubleClickEnabled = true;

		onHeaderMaximize = new NativeSignal (_header.bg,MouseEvent.DOUBLE_CLICK,MouseEvent);
		onHeaderMaximize.add (onMaximize);

		_footer = new HBox (this);
		_footer.customStyle = true;
		_footer.tabEnabled = false;
		_footer.autoWidth = false;
		_footer.autoHeight = false;

		_scaler = new ButtonBase ();
		_scaler.customStyle = true;
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
			_xOffset = e.stageX - this.x;
			_yOffset = e.stageY - this.y;
			OmniCore.onStageMouseMove.add (onWindowMouseMove);
			OmniCore.onStageMouseUp.add (onWindowMouseUp);
		}
	}

	private function onWindowMouseMove (e:MouseEvent):void {
		this.x = e.stageX - _xOffset;
		this.y = e.stageY - _yOffset;
		e.updateAfterEvent ();
	}

	private function onWindowMouseUp (event:MouseEvent):void {
		OmniCore.onStageMouseMove.remove (onWindowMouseMove);
		OmniCore.onStageMouseUp.remove (onWindowMouseUp);
	}

	private function onScalerMouseDown (e:MouseEvent):void {
		_xOffset = e.stageX - _scaler.x;
		_yOffset = e.stageY - _scaler.y;
		OmniCore.onStageMouseMove.add (onScalerMouseMove);
		OmniCore.onStageMouseUp.add (onScalerMouseUp);
	}

	private function onScalerMouseMove (e:MouseEvent):void {
		_scaler.x = e.stageX - _xOffset;
		_scaler.y = e.stageY - _yOffset;
		if (_liveResize) size (_scaler.x + _footerSize,_scaler.y + _footerSize);
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

		windowStyle.update(this);
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
		if (title != _titleText) {
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

	public function get scaler ():ButtonBase {
		return _scaler;
	}

	public function get scrollContainer ():ScrollContainer {
		return _scrollContainer;
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

	public function set liveResize (liveResize:Boolean):void {_liveResize = liveResize;}
}

}
