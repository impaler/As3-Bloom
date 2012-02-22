package bloom.core 
{
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import org.osflash.signals.Signal;
	import org.osflash.signals.natives.NativeSignal;
	
	import bloom.themes.ITheme;
	
	/**
	 * ThemeBase
	 */
	public class ThemeBase {
		
		private static var _stage:Stage;
		
		private static var _onThemeChanged:Signal = new Signal();
		private static var _onStageDraw:NativeSignal;
		private static var _onStageResize:NativeSignal;
		private static var _onStageMouseUp:NativeSignal;
		
		private static var _theme:ITheme;
		
		public static function initialize(stage:Stage):void {
			_stage = stage;
			_onStageDraw = new NativeSignal(_stage, Event.RENDER, Event);
			_onStageResize = new NativeSignal(_stage, Event.RESIZE, Event);
			_onStageMouseUp = new NativeSignal(_stage, MouseEvent.MOUSE_UP, MouseEvent);
		}
		
		///////////////////////////////////
		// getter/setters
		///////////////////////////////////
		
		public static function get theme():ITheme {
			return _theme;
		}
		
		public static function set theme(value:ITheme):void {
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
		
		public static function get stage():Stage {
			return _stage;
		}
		
	}
}