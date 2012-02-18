package bloom.components 
{
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import bloom.control.ThemeBase;
	import bloom.themes.default.ButtonStyle;
	
	/**
	 * Button
	 */
	public class Button extends ButtonBase {
		
		private var _title:Label;
		
		public function Button(p:DisplayObjectContainer = null, text:String = "") {
			super(p);
			
			_title = new Label(this, text);
			_title.addEventListener(Event.CHANGE, onTitleChanged);
			
			style = ThemeBase.theme.button;
		}
		
		protected function onTitleChanged(e:Event):void {
			_title.move((_width - _title.width) * 0.5, (_height - _title.height) * 0.5);
		}
		
		override protected function onThemeChanged():void {
			style = ThemeBase.theme.button;
		}
		
		override protected function draw(e:Event):void {
			if (_changed) {
				_changed = false;
			} else {
				return;
			}
			
			if (!_title) return;
			
			var style:ButtonStyle = _style as ButtonStyle;
			
			_bg.graphics.clear();
			
			switch(_state) {
				case NORMAL:
					_title.style = style.title_normal;
					style.normal.setSize(_width, _height);
					_bg.graphics.beginBitmapFill(style.normal.bitmapData);
					break;
				case OVER:
					_title.style = style.title_over;
					style.over.setSize(_width, _height);
					_bg.graphics.beginBitmapFill(style.over.bitmapData);
					break;
				case DOWN:
					_title.style = style.title_down;
					style.down.setSize(_width, _height);
					_bg.graphics.beginBitmapFill(style.down.bitmapData);
					break;
			}
			
			_bg.graphics.drawRect(0, 0, _width, _height);
			_bg.graphics.endFill();
			
			_title.move((_width - _title.width) * 0.5, (_height - _title.height) * 0.5);
		}
		
		///////////////////////////////////
		// getter/setters
		///////////////////////////////////
		
		public function get title():Label {
			return _title;
		}
		
		///////////////////////////////////
		// toString
		///////////////////////////////////
		
		override public function toString():String {
			return "[bloom.components.Button]";
		}
		
	}

}