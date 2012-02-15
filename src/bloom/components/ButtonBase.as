package bloom.components 
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import bloom.control.ThemeBase;
	import bloom.core.Component;
	import bloom.core.StyleEvent;
	import bloom.themes.default.ButtonBaseStyle;
	
	/**
	 * ButtonBase
	 */
	public class ButtonBase extends Component {
		
		public static const NORMAL:int = 0;
		public static const OVER:int = 1;
		public static const DOWN:int = 2;
		
		protected var _state:int = 0;
		protected var _bg:Shape;
		
		public function ButtonBase(p:DisplayObjectContainer = null) {
			super(p);
			buttonMode = true;
			tabEnabled = false;
			
			_bg = new Shape();
			addChild(_bg);
			
			style = ThemeBase.theme.buttonBase;
			
			size(120, 30);
			
			addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			ThemeBase.dispatcher.addEventListener(StyleEvent.REDRAW, onThemeChanged);
		}
		
		protected function onThemeChanged(e:StyleEvent):void {
			style = ThemeBase.theme.buttonBase;
		}
		
		override protected function draw(e:Event):void {
			if (_changed) {
				_changed = false;
			} else {
				return;
			}
			
			var style:ButtonBaseStyle = _style as ButtonBaseStyle;
			
			_bg.graphics.clear();
			
			switch(_state) {
				case NORMAL:
					style.normal.setSize(_width, _height);
					_bg.graphics.beginBitmapFill(style.normal.bitmapData);
					break;
				case OVER:
					style.over.setSize(_width, _height);
					_bg.graphics.beginBitmapFill(style.over.bitmapData);
					break;
				case DOWN:
					style.down.setSize(_width, _height);
					_bg.graphics.beginBitmapFill(style.down.bitmapData);
					break;
			}
			
			_bg.graphics.drawRect(0, 0, _width, _height);
			_bg.graphics.endFill();
		}
		
		protected function onMouseOver(e:MouseEvent):void {
			if (_state != OVER) {
				_state = OVER;
				_changed = true;
				invalidate();
				addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			}
		}
		
		protected function onMouseDown(e:MouseEvent):void {
			if (_state != DOWN) {
				_state = DOWN;
				_changed = true;
				invalidate();
				stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
				removeEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			}
		}
		
		protected function onMouseUp(e:MouseEvent):void {
			_state = NORMAL;
			_changed = true;
			invalidate();
			addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			removeEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			stage.removeEventListener (MouseEvent.MOUSE_UP, onMouseUp);
		}
		
		protected function onMouseOut(e:MouseEvent):void {
			if (_state != DOWN) onMouseUp(e);
		}
		
		///////////////////////////////////
		// getter/setters
		///////////////////////////////////
		
		public function get state():int {
			return _state;
		}
		
		///////////////////////////////////
		// toString
		///////////////////////////////////
		
		public override function toString():String {
			return "[bloom.components.ButtonBase]";
		}
	}

}