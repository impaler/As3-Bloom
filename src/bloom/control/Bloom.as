package bloom.control {

import bloom.themes.default.DefaultTheme;

import flash.display.Stage;
import flash.events.Event;

import org.osflash.signals.Signal;
import org.osflash.signals.natives.NativeSignal;

/**
 * ThemeBase
 */
public class Bloom {

	private static var _stage:Stage;

	private static const _onThemeChanged:Signal = new Signal ();
	private static var _onStageDraw:NativeSignal;
	private static var _onStageResize:NativeSignal;
	
	private static var _theme:DefaultTheme;

	public static function init ( stage:Stage , value:DefaultTheme ):void {
		_stage = stage;
		_onStageDraw = new NativeSignal ( _stage , Event.RENDER , Event );
		_onStageResize = new NativeSignal ( _stage , Event.RESIZE , Event );

		if ( _theme != value ) {
			_theme = value;
			_onThemeChanged.dispatch ();
		}
	}

	public static function get onThemeChanged ():Signal {
		return _onThemeChanged;
	}

	public static function get onStageDraw ():NativeSignal {
		return _onStageDraw;
	}

	public static function get theme ():DefaultTheme {
		return _theme;
	}

	public static function get stage ():Stage {
		return _stage;
	}

	public static function set theme ( value:DefaultTheme ):void {
		if ( _theme != value ) {
			_theme = value;
			_onThemeChanged.dispatch ();
		}
	}
	
	public function destroy () :void {
		_onStageResize.removeAll();
		_onStageResize = null;
		_onStageDraw.removeAll();
		_onStageDraw = null;
	}

}

}