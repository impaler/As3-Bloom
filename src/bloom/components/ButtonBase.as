package bloom.components 
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import bloom.control.Bloom;
	import bloom.core.Component;
	import bloom.themes.default.ButtonBaseStyle;

import org.osflash.signals.natives.NativeSignal;

/**
	 * ButtonBase
	 */
	public class ButtonBase extends Component {
		
		public static const NORMAL:int = 0;
		public static const OVER:int = 1;
		public static const DOWN:int = 2;
		
		protected var _state:int = 0;
		protected var _bg:Shape;
		
		public var onDown:NativeSignal;
		public var onOver:NativeSignal;
		public var onStageUp:NativeSignal;
		public var onOut:NativeSignal;
		
		public function ButtonBase(p:DisplayObjectContainer = null) {
			super(p);
			buttonMode = true;
			tabEnabled = false;
			
			_bg = new Shape();
			addChild(_bg);
			
			style = Bloom.theme.buttonBase;
			
			size(120, 30);
			
			onStageUp = Bloom.onStageMouseUp;
			onOver = new NativeSignal ( this , MouseEvent.MOUSE_OVER , MouseEvent );
			onDown = new NativeSignal ( this , MouseEvent.MOUSE_DOWN , MouseEvent );
			onOut = new NativeSignal ( this , MouseEvent.MOUSE_OUT , MouseEvent );
			
			onOver.add(onMouseOver);
			onDown.add(onMouseDown);
			
			Bloom.onThemeChanged.add(onThemeChanged);
		}
		
		protected function onThemeChanged():void {
			style = Bloom.theme.buttonBase;
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
				onOut.add(onMouseOut);
			}
		}
		
		protected function onMouseDown(e:MouseEvent):void {
			if (_state != DOWN) {
				_state = DOWN;
				_changed = true;
				invalidate();
				onStageUp.add(onMouseUp);
				onOver.remove(onMouseOver);
			}
		}
		
		protected function onMouseUp(e:MouseEvent):void {
			_state = NORMAL;
			_changed = true;
			invalidate();
			onOver.add(onMouseOver);
			onOut.remove(onMouseOut);
			onStageUp.remove(onMouseUp);
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
	
		override public function destroy () :void {
			onStageUp.remove(onMouseUp);
			
			onOver.removeAll ();
			onOver = null;
			onDown.removeAll ();
			onDown = null;
			onOut.removeAll ();
			onOut = null;
	
			_bg = null;
		}
	}

}