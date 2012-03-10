package bloom.core {

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

	private static var _onStageDraw:NativeSignal;
	private static var _onStageResize:NativeSignal;
	private static var _onStageMouseUp:NativeSignal;
	private static var _onStageMouseMove:NativeSignal;
	private static var _onStageMouseLeave:NativeSignal;

	private static var _onDefaultThemeChanged:Signal = new Signal ();
	private static var _defaultTheme:Theme;

	public static function init (stage:Stage,theme:Class):void {
		_defaultTheme = new theme () as Theme;

		_stage = stage;
		_onStageDraw = new NativeSignal (_stage,Event.RENDER,Event);
		_onStageResize = new NativeSignal (_stage,Event.RESIZE,Event);
		_onStageMouseUp = new NativeSignal (_stage,MouseEvent.MOUSE_UP,MouseEvent);
		_onStageMouseMove = new NativeSignal (_stage,MouseEvent.MOUSE_MOVE,MouseEvent);
		_onStageMouseLeave = new NativeSignal (_stage,Event.MOUSE_LEAVE,MouseEvent);
	}

	///////////////////////////////////
	// getter/setters
	///////////////////////////////////

	public static function get defaultTheme ():Theme {
		return _defaultTheme;
	}

	public static function set defaultTheme (value:Theme):void {
		if (_defaultTheme != value) {
			_defaultTheme.dispose (true);
			_defaultTheme = value;
			_onDefaultThemeChanged.dispatch ();
		}
	}

	public static function get onDefaultThemeChanged ():Signal {
		return _onDefaultThemeChanged;
	}

	public static function get onStageDraw ():NativeSignal {
		return _onStageDraw;
	}

	public static function get onStageResize ():NativeSignal {
		return _onStageResize;
	}

	public static function get onStageMouseUp ():NativeSignal {
		return _onStageMouseUp;
	}

	public static function get onStageMouseMove ():NativeSignal {
		return _onStageMouseMove;
	}

	public static function get onStageMouseLeave ():NativeSignal {
		return _onStageMouseLeave;
	}

	public static function get stage ():Stage {
		return _stage;
	}

}
}
