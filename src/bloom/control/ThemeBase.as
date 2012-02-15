package bloom.control 
{
	import flash.events.EventDispatcher;
	
	import bloom.core.StyleEvent;
	import bloom.themes.default.*;
	
	[StyleEvent(name = "redraw", type = "bloom.core.StyleEvent")]
	
	/**
	 * ThemeBase
	 */
	public class ThemeBase {
		
		private static var _dispatcher:EventDispatcher = new EventDispatcher();
		
		public static function get dispatcher():EventDispatcher {
			return _dispatcher;
		}
		
		private static var _theme:DefaultTheme;
		
		public static function get theme():DefaultTheme {
			return _theme;
		}
		
		public static function set theme(value:DefaultTheme):void {
			if (_theme != value) {
				_theme = value;
				dispatcher.dispatchEvent(new StyleEvent(StyleEvent.REDRAW));
			}
		}
		
	}

}