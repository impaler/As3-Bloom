package bloom.core 
{
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import org.osflash.signals.Signal;
	import org.osflash.signals.natives.NativeSignal;

	
	/**
	 * ThemeBase
	 */
	public class OmniCore {
		
		private static var _stage:Stage;
		
		private static var _onThemeChanged:Signal = new Signal();
		private static var _onStageDraw:NativeSignal;
		private static var _onStageResize:NativeSignal;
		private static var _onStageMouseUp:NativeSignal;
		private static var _onStageMouseMove:NativeSignal;
		private static var _onStageMouseLeave:NativeSignal;
		
		private static var _theme:Theme;
		
		public static function init(stage:Stage, theme:Class):void {
			_theme = new theme() as Theme;
			
			_stage = stage;
			_onStageDraw = new NativeSignal(_stage, Event.RENDER, Event);
			_onStageResize = new NativeSignal(_stage, Event.RESIZE, Event);
			_onStageMouseUp = new NativeSignal(_stage, MouseEvent.MOUSE_UP, MouseEvent);
			_onStageMouseMove = new NativeSignal(_stage, MouseEvent.MOUSE_MOVE, MouseEvent);
			_onStageMouseLeave = new NativeSignal(_stage, Event.MOUSE_LEAVE, MouseEvent);
		}
		
		///////////////////////////////////
		// getter/setters
		///////////////////////////////////
		
		public static function get theme():Theme {
			return _theme;
		}
		
		public static function set theme(value:Theme):void {
			if (_theme != value) {
				_theme = value;
				if(_theme)_onThemeChanged.dispatch();
			}
		}
		
		public static function get onThemeChanged():Signal {
			return _onThemeChanged;
		}
		
		public static function get onStageDraw():NativeSignal {
			return _onStageDraw;
		}
		
		public static function get onStageResize():NativeSignal {
			return _onStageResize;
		}
		
		public static function get onStageMouseUp():NativeSignal {
			return _onStageMouseUp;
		}
		
		public static function get onStageMouseMove():NativeSignal {
			return _onStageMouseMove;
		}
			
		public static function get onStageMouseLeave():NativeSignal {
			return _onStageMouseLeave;
		}	
		
		public static function get stage():Stage {
			return _stage;
		}
		
	}
}