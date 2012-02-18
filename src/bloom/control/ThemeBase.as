package bloom.control 
{
	import org.osflash.signals.Signal;
	
	import bloom.themes.default.*;
	
	/**
	 * ThemeBase
	 */
	public class ThemeBase {
		
		private static const _signal:Signal = new Signal();
		
		public static function get signal():Signal {
			return _signal;
		}
		
		private static var _theme:DefaultTheme;
		
		public static function get theme():DefaultTheme {
			return _theme;
		}
		
		public static function set theme(value:DefaultTheme):void {
			if (_theme != value) {
				_theme = value;
				_signal.dispatch();
			}
		}
		
	}

}