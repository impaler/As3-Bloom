package bloom.components 
{


import flash.display.DisplayObjectContainer;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;

import bloom.control.BloomCore;
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
		protected var _bg:Sprite;
		
		public var onDown:NativeSignal;
		public var onOver:NativeSignal;
		public var onUp:NativeSignal;
		public var onOut:NativeSignal;
		public var onClick:NativeSignal;
		
		private var _isDown:Boolean;
		
		public function ButtonBase(p:DisplayObjectContainer = null) {
			super(p);
			buttonMode = true;
			tabEnabled = false;
			
			_bg = new Sprite();
			addChild(_bg);
			
			style = BloomCore.theme.buttonBase;
			
			size(120, 30);
			
			onUp = BloomCore.onStageMouseUp;
			onOver = new NativeSignal ( this , MouseEvent.MOUSE_OVER , MouseEvent );
			onDown = new NativeSignal ( this , MouseEvent.MOUSE_DOWN , MouseEvent );
			onOut = new NativeSignal ( this , MouseEvent.MOUSE_OUT , MouseEvent );
			onClick = new NativeSignal ( this , MouseEvent.CLICK , MouseEvent );
			
			onOver.addOnce(onMouseOver);
			onDown.add(onMouseDown);
			
			_isDown = false;
			
			BloomCore.onThemeChanged.add(onThemeChanged);
		}
		
		protected function onThemeChanged():void {
			style = BloomCore.theme.buttonBase;
		}
		
		override protected function draw(e:Event):void {
			if (_changed) {
				_changed = false;
			} else {
				return;
			}
			
			buttonBaseStyle.backgroundBrush.update ( _state , _bg , dimensionObject );
		}
		
		protected function onMouseOver(e:MouseEvent):void {
			if (_state != OVER) {
				_state = OVER;
				_changed = true;
				invalidate();
				onOut.addOnce(onMouseOut);
			}
		}
		
		protected function onMouseDown(e:MouseEvent):void {
			if (_state != DOWN) {
				_state = DOWN;
				_isDown = true;
				_changed = true;
				invalidate();
				onUp.addOnce(onMouseUp);
			}
		}
		
		protected function onMouseUp(e:MouseEvent):void {
			_state = NORMAL;
			onOut.numListeners > 0 ? _state = OVER : _state = NORMAL;
			_changed = true;
			_isDown = false;
			invalidate();
			onOver.addOnce(onMouseOver);
		}
		
		protected function onMouseOut(e:MouseEvent):void {
			if (_state != DOWN || _state != OVER) {
				if ( !_isDown ) onMouseUp(e);
			}
		}
		
		///////////////////////////////////
		// getter/setters
		///////////////////////////////////
		
		public function get state():int {
			return _state;
		}
	
		public function get buttonBaseStyle():ButtonBaseStyle {
			return _style as ButtonBaseStyle;
		}
		
		///////////////////////////////////
		// toString
		///////////////////////////////////
		
		public override function toString():String {
			return "[bloom.components.ButtonBase]";
		}
	
		override public function destroy () :void {
			super.destroy();

			onUp.remove(onMouseUp);
			
			onOver.removeAll ();
			onOver = null;
			onDown.removeAll ();
			onDown = null;
			onOut.removeAll ();
			onOut = null;
			onClick.removeAll();
			onClick = null;
			
			_bg = null;
		}
	}

}