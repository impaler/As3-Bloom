package bloom.components 
{
	import flash.display.DisplayObjectContainer;
	import flash.events.MouseEvent;
	
	import bloom.core.ThemeBase;
	
	/**
	 * ScrollBar
	 */
	public class ScrollBar extends Slider {
		
		private var _realSize:Number;
		private var _minSize:Number;
		private var _contentSize:Number;
		private var _pageSize:Number;
		
		private var _working:Boolean = true;
		private var _autoHide:Boolean = true;
		
		public function ScrollBar(p:DisplayObjectContainer = null, type:int = 0, page:Number = 100, content:Number = 100) {
			_realSize = 0;
			_minSize = 20;
			_pageSize = page;
			_contentSize = content;
			super(p, type, 0, content);
		}
		
		override protected function refresh():void {
			_max = Math.max(_contentSize - _pageSize, 0);
			if (_max > 0) {
				if (_type == HORIZONTALLY) {
					_realSize = (_pageSize * _width) / (_max + _pageSize);
					_button.size(Math.max(_realSize, _minSize), _height);
					_rect.width = Math.ceil(_width - _button.width);
					_button.x = _value / _max * _rect.width;
					if (_button.x + _button.width > _width) _button.x = _width - _button.width;
				} else {
					_realSize = (_pageSize * _height) / (_max + _pageSize);
					_button.size(_width, Math.max(_realSize, _minSize));
					_rect.height = Math.ceil(_height - _button.height);
					_button.y = _value / _max * _rect.height;
					if (_button.y + _button.height > _height) _button.y = _height - _button.height;
				}
				_working = true;
			} else {
				value = 0;
				_rect.width = 0;
				_rect.height = 0;
				_button.move(0, 0);
				_button.size(0, 0);
				if(_autoHide) _bg.graphics.clear();
				_working = false;
			}
		}
		
		///////////////////////////////////
		// Mouse Handle
		///////////////////////////////////
		
		override protected function onMouseMove(e:MouseEvent):void {
			if (_type == HORIZONTALLY) {
				_value = Math.ceil(_button.x / _rect.width * _max);
			} else {
				_value = Math.ceil(_button.y / _rect.height * _max);
			}
			fixValue();
            e.updateAfterEvent();
			
			_scrolling.dispatch(this);
		}
		
		override protected function clickOnBg(e:MouseEvent):void {
			if (_type == HORIZONTALLY) {
				value = (mouseX - (_button.width >> 1)) / _rect.width * _max;
			} else {
				value = (mouseY - (_button.height >> 1)) / _rect.height * _max;
			}
            _button.startDrag(false, _rect);
			ThemeBase.onStageMouseMove.add(onMouseMove);
			ThemeBase.onStageMouseUp.add(onMouseUp);
			
            e.updateAfterEvent();
		}
		
		override protected function onMouseWheel(e:MouseEvent):void {
			if (_type == HORIZONTALLY) {
				value += e.delta > 0 ? step : - step;
			} else {
				value -= e.delta > 0 ? step : - step;
			}
            e.updateAfterEvent();
		}
		
		///////////////////////////////////
		// getter/setters
		///////////////////////////////////
		
		public function set contentSize(value:Number):void {
			if (_contentSize != value) {
				_contentSize = value;
				_changed = true;
				invalidate();
			}
		}
		
		public function get contentSize():Number {
			return _contentSize;
		}
		
		public function set pageSize(value:Number):void {
			if (_pageSize != value) {
				_pageSize = value;
				_changed = true;
				invalidate();
			}
		}
		
		public function get pageSize():Number {
			return _pageSize;
		}
		
		public function set minSize(value:Number):void {
			if (_minSize != value) {
				_minSize = value;
				refresh();
			}
		}
		
		public function get minSize():Number {
			return _minSize;
		}
		
		public function set autoHide(value:Boolean):void {
			if (_autoHide != value) {
				_autoHide = value;
				_changed = true;
				invalidate();
			}
		}
		
		public function get autoHide():Boolean {
			return _autoHide;
		}
		
		public function get working():Boolean {
			return _working;
		}
		
		///////////////////////////////////
		// toString
		///////////////////////////////////
		
		override public function toString():String {
			return "[bloom.components.ScrollBar]";
		}
		
	}

}