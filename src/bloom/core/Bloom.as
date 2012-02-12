package bloom.core {

import bloom.control.ObjectPool;
import bloom.control.ThemeBase;

import flash.display.Stage;
import flash.events.Event;

import org.osflash.signals.natives.NativeSignal;

public class Bloom {

	private static var _instance:Bloom;

	public var stage:Stage;
	public var onStageResize:NativeSignal;
	public var onStageDraw:NativeSignal;

	public var styleRegistry:ObjectPool;
	public var currentTheme:ThemeBase;

	/**
	 * Bloom core singleton pattern
	 *
	 * @param singletonEnforcer
	 */
	public function Bloom ( singletonEnforcer:SingletonEnforcer ) {
	}

	public static function core ():Bloom {
		if ( _instance == null ) {
			_instance = new Bloom ( new SingletonEnforcer );
		}
		return _instance;
	}

	public function init ( _stage:Stage , _theme:Class ):void {
		stage = _stage;
		onStageResize = new NativeSignal ( stage , Event.RESIZE , Event );
		onStageDraw = new NativeSignal ( stage , Event.RENDER , Event );
		styleRegistry = new ObjectPool ();

		currentTheme = new _theme () as ThemeBase;
	}

}

}

internal class SingletonEnforcer {
}
