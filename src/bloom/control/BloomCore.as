package bloom.control {

import bloom.style.ThemeBase;

import flash.display.Stage;
import flash.events.Event;
import flash.events.MouseEvent;

import org.osflash.signals.Signal;
import org.osflash.signals.natives.NativeSignal;

/**
 * ThemeBase
 */
public class BloomCore {

	private static var _stage:Stage;

	private static const _onThemeChanged:Signal = new Signal ();
	private static var _onStageDraw:NativeSignal;
	private static var _onStageResize:NativeSignal;
	private static var _onStageMouseUp:NativeSignal;
	
	private static var _theme:ThemeBase;

	public static function init ( stage:Stage , value:ThemeBase ):void {
		_stage = stage;
		_onStageDraw = new NativeSignal ( _stage , Event.RENDER , Event );
		_onStageResize = new NativeSignal ( _stage , Event.RESIZE , Event );
		_onStageMouseUp = new NativeSignal ( _stage , MouseEvent.MOUSE_UP , MouseEvent );

		if ( _theme != value ) {
			_theme = value;
			_onThemeChanged.dispatch ();
		}
	}
	
	///////////////////////////////////
	// getter/setters
	///////////////////////////////////

	public static function get onThemeChanged ():Signal {
		return _onThemeChanged;
	}

	public static function get onStageDraw ():NativeSignal {
		return _onStageDraw;
	}
	
	public static function get onStageMouseUp ():NativeSignal {
		return _onStageMouseUp;
	}

	public static function get theme ():ThemeBase {
		return _theme as ThemeBase;
	}

	public static function get stage ():Stage {
		return _stage;
	}

	public static function set theme ( value:ThemeBase ):void {
		if ( _theme != value ) {
			_theme = value;
			_onThemeChanged.dispatch ();
		}
	}
	
	public static function destroy () :void {
		_onStageResize.removeAll();
		_onStageResize = null;
		_onStageDraw.removeAll();
		_onStageDraw = null;
		_onStageMouseUp.removeAll();
		_onStageMouseUp = null;
		
		_theme = null;
	}

}

}