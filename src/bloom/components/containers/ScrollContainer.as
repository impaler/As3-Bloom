package bloom.components.containers {

import bloom.components.controls.ScrollBar;
import bloom.components.controls.Slider;
import bloom.core.ComponentConstants;
import bloom.core.IComponent;

import flash.display.DisplayObjectContainer;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.Rectangle;

import org.osflash.signals.natives.NativeSignal;

/**
 * ScrollContainer
 */
public class ScrollContainer extends Container {

	private var h_scrollBar_enabled:Boolean;
	private var v_scrollBar_enabled:Boolean;

	private var h_scrollBar:ScrollBar;
	private var v_scrollBar:ScrollBar;
	private var h_mouseWheel:NativeSignal;
	private var v_mouseWheel:NativeSignal;
	private var h_eventAdded:Boolean;
	private var v_eventAdded:Boolean;

	private var _rect:Rectangle;

	public function ScrollContainer (p:DisplayObjectContainer = null) {
		super (p);
	}

	override protected function initDefaultStyle ():void {
		super.initDefaultStyle ();
		v_scrollBar.autoHide = false;
		v_scrollBar.step = 20;
		h_scrollBar.autoHide = false;
		h_scrollBar.step = 20;
		h_eventAdded = v_eventAdded = false;

		h_scrollBar_enabled = v_scrollBar_enabled = true;
	}

	override public function enableSignals ():void {
		super.enableSignals ();
		v_scrollBar.scrolling.add (onVScrollBarMove);
		v_scrollBar.valueChanged.add (onVScrollBarMove);
		h_scrollBar.scrolling.add (onHScrollBarMove);
		h_scrollBar.valueChanged.add (onHScrollBarMove);
	}

	override public function disableSignals ():void {
		super.disableSignals ();
		v_scrollBar.scrolling.remove (onVScrollBarMove);
		v_scrollBar.valueChanged.remove (onVScrollBarMove);
		h_scrollBar.scrolling.remove (onHScrollBarMove);
		h_scrollBar.valueChanged.remove (onHScrollBarMove);
	}

	override protected function createAssets ():void {
//		_bg = new Sprite ();
//		addChild (_bg);

		super.createAssets ();

		content.scrollRect = _rect;

		_rect = new Rectangle (0,0,0,0);

		h_scrollBar = new ScrollBar (null,ComponentConstants.HORIZONTALLY);
		v_scrollBar = new ScrollBar (null,ComponentConstants.VERTICALLY);

		h_mouseWheel = new NativeSignal (_bg,MouseEvent.MOUSE_WHEEL,MouseEvent);
		v_mouseWheel = new NativeSignal (_bg,MouseEvent.MOUSE_WHEEL,MouseEvent);
	}

	override protected function draw (e:Event = null):void {
		if (! _changed) return;
		_changed = false;

		containerStyle.background.update (_state,bg,getDimensionObject);
		setScrollBar (h_scrollBar_enabled,v_scrollBar_enabled);
	}

	override public function addContent (value:IComponent):void {
		super.addContent (value);
		setContentSize (content.width,content.height);
	}

	public function setScrollBar (horizontal:Boolean = true,vertical:Boolean=true):void {
		h_scrollBar_enabled = horizontal;
		v_scrollBar_enabled = vertical;

		if (horizontal) {
			if (vertical) {

				_rect.width = _width - v_scrollBar.width;
				h_scrollBar.width = _width - v_scrollBar.width;

				_rect.height = _height - h_scrollBar.height;
				v_scrollBar.height = _height - h_scrollBar.height;

				h_scrollBar.y = v_scrollBar.height;
				v_scrollBar.x = h_scrollBar.width;


				if (h_eventAdded) {
					h_eventAdded = false;
					h_mouseWheel.remove (h_scrollBar.onMouseWheel);
				}
				if (! h_eventAdded && horizontal) {
					h_eventAdded = true;
					h_mouseWheel.add (h_scrollBar.onMouseWheel);
				}
				if (! v_eventAdded) {
					v_eventAdded = true;
					v_mouseWheel.add (v_scrollBar.onMouseWheel);
				}
				if (! v_scrollBar.parent) addChild (v_scrollBar);

			} else {
				_rect.width = _width;
				_rect.height = _height - h_scrollBar.height;
				h_scrollBar.width = _width;
				h_scrollBar.y = _height - h_scrollBar.height;
				if (! h_eventAdded) {
					h_eventAdded = true;
					h_mouseWheel.add (h_scrollBar.onMouseWheel);
				}
				if (v_eventAdded) {
					v_eventAdded = false;
					v_mouseWheel.remove (v_scrollBar.onMouseWheel);
				}
				if (v_scrollBar.parent) removeChild (v_scrollBar);
			}
			if (! h_scrollBar.parent) addChild (h_scrollBar);
		} else {
			if (vertical) {
				_rect.width = _width - v_scrollBar.width;
				_rect.height = _height;
				v_scrollBar.height = _height;
				v_scrollBar.x = _width - v_scrollBar.width;
				if (h_eventAdded) {
					h_eventAdded = false;
					h_mouseWheel.remove (h_scrollBar.onMouseWheel);
				}
				if (! v_eventAdded) {
					v_eventAdded = true;
					v_mouseWheel.add (v_scrollBar.onMouseWheel);
				}
				if (! v_scrollBar.parent) addChild (v_scrollBar);
			} else {
				_rect.width = _width;
				_rect.height = _height;
				if (h_eventAdded) {
					h_eventAdded = false;
					h_mouseWheel.remove (h_scrollBar.onMouseWheel);
				}
				if (v_eventAdded) {
					v_eventAdded = false;
					v_mouseWheel.remove (v_scrollBar.onMouseWheel);
				}
				if (v_scrollBar.parent) removeChild (v_scrollBar);
			}
			if (h_scrollBar.parent) removeChild (h_scrollBar);
		}

		h_scrollBar.pageSize = _rect.width;
		v_scrollBar.pageSize = _rect.height;




//		h_scrollBar.drawDirectly();



//		_rect.height = _height;
//		v_scrollBar.height = _height;

		content.scrollRect = _rect;


//		if ( !h_scrollBar.visible ) {
//			_rect.width = _width;
//			h_scrollBar.width = _width;
//		}
//
	}

	public function setContentSize (width:Number,height:Number):void {
		h_scrollBar.contentSize = width;
		v_scrollBar.contentSize = height;
	}

	private function onVScrollBarMove (target:Slider):void {
		if (v_scrollBar_enabled) {
			_rect.y = v_scrollBar.value;
			content.scrollRect = _rect;
		}
	}

	private function onHScrollBarMove (target:Slider):void {
		if (h_scrollBar_enabled) {
			_rect.x = h_scrollBar.value;
			content.scrollRect = _rect;
		}
	}

	public function getScrollBar (direction:int):ScrollBar {
		var result:ScrollBar;
		if (direction == ComponentConstants.VERTICALLY) result = v_scrollBar;
		if (direction == ComponentConstants.HORIZONTALLY) result = h_scrollBar;
		return result;
	}

	override public function dispose (gc:Boolean = false):void {
		super.dispose ();

		_bg.graphics.clear ();
		_bg = null;

		h_scrollBar.dispose ();
		h_scrollBar = null;

		v_scrollBar.dispose ();
		v_scrollBar = null;

		v_mouseWheel.removeAll ();
		v_mouseWheel = null;
		h_mouseWheel.removeAll ();
		h_mouseWheel = null;
	}

	override public function get width ():Number {
		return _width;
	}

	override public function get height ():Number {
		return _height;
	}

	///////////////////////////////////
	// toString
	///////////////////////////////////

	override public function toString ():String {
		return "[bloom.components.ScrollContainer]";
	}
}

}
