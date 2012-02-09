package bloom.core {

import flash.display.Stage;
import flash.events.Event;
import flash.utils.Dictionary;

import org.osflash.signals.natives.NativeSignal;

public class Bloom {

	private static var _instance:Bloom;

	public var stage:Stage;
	public var onStageResize:NativeSignal;
	
	public var registerComponents:Boolean = false;
	public var componentRegistry:ComponentReg = new ComponentReg ();
	
	private var userComponentRegistries:Dictionary = new Dictionary ();

	/**
	 * Component Constants
	 *
	 */
	public static const NORM:int = 0;
	public static const OVER:int = 1;
	public static const DOWN:int = 2;
	
	public static const LEFT:int = 0;
	public static const RIGHT:int = 1;
	public static const TOP:int = 2;
	public static const BOTTOM:int = 3;
	public static const CENTRE:int = 4;
	
	public static const VERTICALLY:int = 0;
	public static const HORIZONTALLY:int = 1;
	public static const GRID:int = 2;
	

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

	public function init ( _stage:Stage , _theme:ITheme , _registerComponents:Boolean = false ):void {
		stage = _stage;
		registerComponents = _registerComponents;
		componentRegistry.theme.initTheme ( _theme );
		
		onStageResize = new NativeSignal( stage , Event.RESIZE, Event );
	}

	public function setTheme ( _theme:ITheme ):void {
		componentRegistry.theme.initTheme ( _theme );
		if ( registerComponents && componentRegistry.Registry.length > 0 ) {
			componentRegistry.updateRegistryCompModels ();
		}
	}
	
	public function registerComponent ( component:IComponent ):void {
		component.Registry = componentRegistry;

		if ( registerComponents && component.registerComponent ) {
			componentRegistry.registerComponent ( component, true );
		}
	}

	public function newCompRegistry ( key:String ):ComponentReg {
		var ComponentRegistry:ComponentReg = new ComponentReg ();
			userComponentRegistries[key] = ComponentRegistry;
		return userComponentRegistries[key];
	}

	public function getCompRegistry ( key:String ):ComponentReg {
		return userComponentRegistries[key] as ComponentReg;
	}

}

}

internal class SingletonEnforcer {
}