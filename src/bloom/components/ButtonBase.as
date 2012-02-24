package bloom.components 
{	
	import flash.display.BitmapData;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import org.osflash.signals.natives.NativeSignal;
	
	import bloom.core.Component;
	import bloom.core.ThemeBase;
	import bloom.styles.ButtonBaseStyle;
	
	/**
	 * ButtonBase
	 */
	public class ButtonBase extends Component {
		
		public static const NORMAL:int = 0;
		public static const OVER:int = 1;
		public static const DOWN:int = 2;
		
		protected var _mouseDown:NativeSignal;
		protected var _mouseOver:NativeSignal;
		protected var _mouseUp:NativeSignal;
		protected var _mouseOut:NativeSignal;
		protected var _mouseClick:NativeSignal;
		
		protected var _state:int = 0;
		
		protected var background:BitmapData;
		
		public function ButtonBase(p:DisplayObjectContainer = null) {
			super(p);
			buttonMode = true;
			tabEnabled = false;
			
			_mouseUp = ThemeBase.onStageMouseUp;
			_mouseOver = new NativeSignal(this, MouseEvent.MOUSE_OVER, MouseEvent);
			_mouseDown = new NativeSignal(this, MouseEvent.MOUSE_DOWN, MouseEvent);
			_mouseOut = new NativeSignal(this, MouseEvent.MOUSE_OUT, MouseEvent);
			_mouseClick = new NativeSignal(this, MouseEvent.CLICK, MouseEvent);
			
			_mouseOver.add(onMouseOver);
			_mouseDown.add(onMouseDown);
			
			_style = ThemeBase.theme.buttonBase;
			size(120, 30);
		}
		
		override public function destroy():void {
			super.destroy();
			_mouseUp.remove(onMouseUp);
			_mouseOver.removeAll();
			_mouseOver = null;
			_mouseDown.removeAll();
			_mouseDown = null;
			_mouseOut.removeAll();
			_mouseOut = null;
			_mouseClick.removeAll();
			_mouseClick = null;
			if (background) background.dispose();
			background = null;
		}
		
		override protected function onThemeChanged():void {
			style = ThemeBase.theme.buttonBase;
		}
		
		override protected function draw(e:Event):void {
			if (!_changed) return;
			_changed = false;
			
			var style:ButtonBaseStyle = _style as ButtonBaseStyle;
			if (background) background.dispose();
			
			graphics.clear();
			switch(state){
				case NORMAL:
					style.normal.setSize(_width, _height);
					background = style.normal.bitmapData.clone();
					break;
				case OVER:
					style.over.setSize(_width, _height);
					background = style.over.bitmapData.clone();
					break;
				case DOWN:
					style.down.setSize(_width, _height);
					background = style.down.bitmapData.clone();
					break;
			}
			graphics.beginBitmapFill(background);
			graphics.drawRect(0, 0, _width, _height);
			graphics.endFill();
		}
		
		protected function onMouseOver(e:MouseEvent):void {
			if (_state != OVER) {
				_state = OVER;
				_changed = true;
				invalidate();
				mouseOut.add(onMouseOut);
			}
		}
		
		protected function onMouseDown(e:MouseEvent):void {
			if (_state != DOWN) {
				_state = DOWN;
				_changed = true;
				invalidate();
				mouseUp.add(onMouseUp);
				mouseOver.remove(onMouseOver);
			}
		}
		
		protected function onMouseUp(e:MouseEvent):void {
			_state = NORMAL;
			_changed = true;
			invalidate();
			mouseOver.add(onMouseOver);
			mouseOut.remove(onMouseOut);
			mouseUp.remove(onMouseUp);
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
		
		public function set state(value:int):void {
			_state = value;
			_changed = true;
			invalidate();
		}
		
		public function get mouseDown():NativeSignal {
			return _mouseDown;
		}
		
		public function get mouseOver():NativeSignal {
			return _mouseOver;
		}
		
		public function get mouseUp():NativeSignal {
			return _mouseUp;
		}
		
		public function get mouseOut():NativeSignal {
			return _mouseOut;
		}
		
		public function get mouseClick():NativeSignal {
			return _mouseClick;
		}
		
		///////////////////////////////////
		// toString
		///////////////////////////////////
		
		public override function toString():String {
			return "[bloom.components.ButtonBase]";
		}
		
	}

}