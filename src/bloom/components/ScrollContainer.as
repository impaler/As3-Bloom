package bloom.components 
{

import bloom.core.IObjectBase;
import bloom.core.OmniCore;
import bloom.components.ScrollContainerStyle;

import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.Rectangle;

import org.osflash.signals.natives.NativeSignal;

/**
	 * ScrollContainer
	 */
	public class ScrollContainer extends FlowContainer {
		
		private var h_scrollBar_enabled:Boolean;
		private var v_scrollBar_enabled:Boolean;
		
		private var h_scrollBar:ScrollBar;
		private var v_scrollBar:ScrollBar;
		private var h_mouseWheel:NativeSignal;
		private var v_mouseWheel:NativeSignal;
		private var h_eventAdded:Boolean;
		private var v_eventAdded:Boolean;
		
		private var _rect:Rectangle;
		private var _bg:Sprite;
		
		public function ScrollContainer(p:DisplayObjectContainer = null, direction:int = 0) {
			super(p, direction);
			
			_rect = new Rectangle(0, 0, 100, 100);
			_content.scrollRect = _rect;
			
			_bg = new Sprite();
			addChild(_bg);
			
			removeChild(_content);
			addChild(_content);
			
			h_scrollBar = new ScrollBar(null, HORIZONTALLY);
			h_scrollBar.autoHide = false;
			h_scrollBar.step = 20;
			h_scrollBar.scrolling.add(onHScrollBarMove);
			h_scrollBar.valueChanged.add(onHScrollBarMove);
			
			v_scrollBar = new ScrollBar(null, VERTICALLY);
			v_scrollBar.autoHide = false;
			v_scrollBar.step = 20;
			v_scrollBar.scrolling.add(onVScrollBarMove);
			v_scrollBar.valueChanged.add(onVScrollBarMove);
			
			h_mouseWheel = new NativeSignal(_bg, MouseEvent.MOUSE_WHEEL, MouseEvent);
			v_mouseWheel = new NativeSignal(_bg, MouseEvent.MOUSE_WHEEL, MouseEvent);
			
			h_eventAdded = v_eventAdded = false;
			
			style = OmniCore.defaultTheme.scrollContainer;
			
			h_scrollBar_enabled = v_scrollBar_enabled = true;
			
			setContentSize(100, 100);
			
			_changed = true;
			invalidate();
		}
		
		override public function dispose (gc:Boolean = false):void {
			super.dispose (gc);
			if (background) background.dispose();
			background = null;
			removeChild(_content);
			_content = null;
			_bg.graphics.clear();
			removeChild(_bg);
			_bg = null;
			if (h_scrollBar_enabled) removeChild(h_scrollBar);
			h_scrollBar.dispose (false);
			h_scrollBar = null;
			if (v_scrollBar_enabled) removeChild(v_scrollBar);
			v_scrollBar.dispose (false);
			v_scrollBar = null;
			v_mouseWheel.removeAll();
			v_mouseWheel = null;
			h_mouseWheel.removeAll();
			h_mouseWheel = null;
		}
		
		override protected function onThemeChanged():void {
			style = OmniCore.defaultTheme.scrollContainer;
		}
		
		public function getScrollBar(direction:int):ScrollBar {
			var result:ScrollBar;
			if (direction == VERTICALLY) result = v_scrollBar;
			if (direction == HORIZONTALLY) result = h_scrollBar;
			return result;
		}
		
		public function setScrollBar(horizontal:Boolean, vertical:Boolean):void {
			h_scrollBar_enabled = horizontal;
			v_scrollBar_enabled = vertical;
			
			if (horizontal) {
				if (vertical) {
					_rect.width = _width - v_scrollBar.width;
					_rect.height = _height - h_scrollBar.height;
					h_scrollBar.width = _width - v_scrollBar.width;
					v_scrollBar.height = _height - h_scrollBar.height;
					h_scrollBar.y = v_scrollBar.height;
					v_scrollBar.x = h_scrollBar.width;
					if (h_eventAdded) {
						h_eventAdded = false;
						h_mouseWheel.remove(h_scrollBar.onMouseWheel);
					}
					if (!v_eventAdded) {
						v_eventAdded = true;
						v_mouseWheel.add(v_scrollBar.onMouseWheel);
					}
					if (!v_scrollBar.parent) addChild(v_scrollBar);
				} else {
					_rect.width = _width;
					_rect.height = _height - h_scrollBar.height;
					h_scrollBar.width = _width;
					h_scrollBar.y = _height - h_scrollBar.height;
					if (!h_eventAdded) {
						h_eventAdded = true;
						h_mouseWheel.add(h_scrollBar.onMouseWheel);
					}
					if (v_eventAdded) {
						v_eventAdded = false;
						v_mouseWheel.remove(v_scrollBar.onMouseWheel);
					}
					if (v_scrollBar.parent) removeChild(v_scrollBar);
				}
				if (!h_scrollBar.parent) addChild(h_scrollBar);
			} else {
				if (vertical) {
					_rect.width = _width - v_scrollBar.width;
					_rect.height = _height;
					v_scrollBar.height = _height;
					v_scrollBar.x = _width - v_scrollBar.width;
					if (h_eventAdded) {
						h_eventAdded = false;
						h_mouseWheel.remove(h_scrollBar.onMouseWheel);
					}
					if (!v_eventAdded) {
						v_eventAdded = true;
						v_mouseWheel.add(v_scrollBar.onMouseWheel);
					}
					if (!v_scrollBar.parent) addChild(v_scrollBar);
				} else {
					_rect.width = _width;
					_rect.height = _height;
					if (h_eventAdded) {
						h_eventAdded = false;
						h_mouseWheel.remove(h_scrollBar.onMouseWheel);
					}
					if (v_eventAdded) {
						v_eventAdded = false;
						v_mouseWheel.remove(v_scrollBar.onMouseWheel);
					}
					if (v_scrollBar.parent) removeChild(v_scrollBar);
				}
				if (h_scrollBar.parent) removeChild(h_scrollBar);
			}
			
			h_scrollBar.pageSize = _rect.width;
			v_scrollBar.pageSize = _rect.height;
			
			_content.scrollRect = _rect;
		}
		
		public function setContentSize(width:Number, height:Number):void {
			h_scrollBar.contentSize = width;
			v_scrollBar.contentSize = height;
		}
		
		/**
		 * Calculate content's size by it's children's size and margin.
		 */
		public function calculateContentSize():void {
			var width:Number = 0;
			var height:Number = 0;
			
			var object:DisplayObject;
			var component:IObjectBase;
			var i:int, j:int = _content.numChildren;
			for (i = 0; i < j; i++) {
				object = _content.getChildAt(i);
				if (object is IObjectBase) {
					component = object as IObjectBase;
					if (_direction == HORIZONTALLY) {
						width += component.width + component.margin.left + component.margin.right;
						height = Math.max(component.height + component.margin.top + component.margin.bottom, height);
					} else if (_direction == VERTICALLY) {
						width = Math.max(component.width + component.margin.left + component.margin.right, width);
						height += component.height + component.margin.top + component.margin.bottom;
					}
				} else {
					if (_direction == HORIZONTALLY) {
						width += object.width;
						height = Math.max(object.height, height);
					} else if (_direction == VERTICALLY) {
						width = Math.max(object.width, width);
						height += object.height;
					}
				}
			}
			
			setContentSize(width, height);
		}
		
		override protected function draw (e:Event = null):void {
			if (!_changed) return;
			_changed = false;
			
			var style:ScrollContainerStyle = _style as ScrollContainerStyle;
			if (background) background.dispose();
			
			style.background.setSize(_width, _height);
			background = style.background.bitmapData.clone();
			
			_bg.graphics.clear();
			_bg.graphics.beginBitmapFill(background);
			_bg.graphics.drawRect(0, 0, _width, _height);
			_bg.graphics.endFill();
			
			h_scrollBar.style = style.h_scrollBar;
			v_scrollBar.style = style.v_scrollBar;
			
			setScrollBar(h_scrollBar_enabled, v_scrollBar_enabled);
		}
		
		private function onVScrollBarMove(target:Slider):void {
			if (v_scrollBar_enabled) {
				_rect.y = v_scrollBar.value;
				_content.scrollRect = _rect;
			}
		}
		
		private function onHScrollBarMove(target:Slider):void {
			if (h_scrollBar_enabled) {
				_rect.x = h_scrollBar.value;
				_content.scrollRect = _rect;
			}
		}
		
		///////////////////////////////////
		// toString
		///////////////////////////////////
		
		override public function toString():String {
			return "[bloom.components.ScrollContainer]";
		}
	}

}