package bloom.core {

public class ComponentReg {

	public var theme:ThemeBase = new ThemeBase ();

	public var Registry:Vector.<IComponent> = new Vector.<IComponent> ();

	public function ComponentReg () {
	}

	public function setTheme ( _theme:ITheme ) {
		theme.initTheme ( _theme );
		updateRegistryCompModels ();
	}

	public function updateRegistryCompModels ():void {
		if ( Registry.length > 0 ) {
			for each ( var component:IComponent in Registry ) {
				if ( component.registerComponent ) {
					component.Registry = this;
					component.applyModel ();
				}
			}
		}
	}

	public function disableComponents ( value:Boolean = false ):void {
		if ( Registry.length > 0 ) {
			for each ( var component:IComponent in Registry ) {
				if ( component.registerComponent ) {
					component.enabled = value;
				}
			}
		}
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

	public function registerComponent ( component:IComponent, core:Boolean = false ):IComponent {
		if ( !core )
			Bloom.core().componentRegistry.removeComponent( component, true );
		
		component.Registry = this;
		if ( component.registerComponent ) {
			Registry.push ( component );
		}
		return component;
	}

	public function removeComponent ( comp:* , remove:Boolean = false ):* {
		for ( var i:int = 0 ; i < Registry.length ; i ++ ) {
			if ( Registry[i] == comp ) {
				if ( remove )
					Registry.splice ( i , 1 );
				return true;
			}
		}
		return false;
	}

}
}
