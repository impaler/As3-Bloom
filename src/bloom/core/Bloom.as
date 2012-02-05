package bloom.core {

import flash.display.Stage;
import flash.utils.Dictionary;

public class Bloom {

	private static var _instance:Bloom;

	public var stage:Stage;
	public var theme:ThemeBase = new ThemeBase ();

	/**
	 * This setting will let you register all the components you create so that you can manipulate them all at once
	 * Such as change theme, enable / disable them
	 *
	 */
	public var registerComponents:Boolean = false;

	private var coreComponentRegistry:Vector.<IComponent> = new Vector.<IComponent> ();

	private var userComponentRegistries:Dictionary = new Dictionary ();

	/**
	 * Constants
	 *
	 */
	public static const NORM:int = 0;
	public static const OVER:int = 1;
	public static const DOWN:int = 2;

	public function Bloom ( singletonEnforcer:SingletonEnforcer ) {
//		trace ( "Single instantiate" );
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
		theme.initTheme ( _theme );
	}

	public function setTheme ( _theme:ITheme ) {
		theme.initTheme ( _theme );
		updateRegistryCompModels ( coreComponentRegistry );
	}

	private function updateRegistryCompModels ( CompRegistry:Vector.<IComponent> ):void {
		if ( registerComponents && CompRegistry.length > 0 ) {
			for each ( var component:IComponent in CompRegistry ) {
				if ( component.registerComponent ) {
					component.applyModel ();
				}
			}
		}
	}

	public function registerComponent ( component:* ):void {
		if ( component.registerComponent ) {
			coreComponentRegistry.push ( component as IComponent );
		}
	}

	public function lookupCoreComponent ( comp:* , remove:Boolean = false ):Boolean {
		return lookupComponent ( coreComponentRegistry , comp , remove );
	}

	private function lookupComponent ( CompRegistry:Vector.<IComponent> , comp:* , remove:Boolean = false ):Boolean {
		for ( var i:int = 0 ; i < CompRegistry.length ; i ++ ) {
			if ( CompRegistry[i] == comp ) {
				if ( remove )
					CompRegistry.splice ( i , 1 );
				return true;
			}
		}
		return false;
	}

	public function createNewComponentRegistry ( key:String ) {
		var coreComponentRegistry:Vector.<IComponent> = new Vector.<IComponent> ();
		userComponentRegistries[key] = coreComponentRegistry;
		return userComponentRegistries[key];
	}

	public function getComponentRegistry ( key:String ):Vector.<IComponent> {
		return userComponentRegistries[key] as Vector.<IComponent>;
	}

}
}

internal class SingletonEnforcer {
}