package {

import bloom.components.Button;
import bloom.components.Label;
import bloom.containers.AlertWindow;
import bloom.containers.FlowContainer;
import bloom.containers.Window;
import bloom.core.Bloom;
import bloom.core.ComponentReg;
import bloom.themes.darkTheme.DarkButtonModel;
import bloom.themes.darkTheme.DarkTheme;
import bloom.themes.defaultTheme.DefaultTheme;

import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.MouseEvent;

public class bloomtest extends Sprite {

	private var _alertTest:AlertWindow;

	public function bloomtest () {
		stage.align = StageAlign.TOP_LEFT;
		stage.scaleMode = StageScaleMode.NO_SCALE;
		stage.showDefaultContextMenu = false;

		Bloom.core ().init ( stage , new DefaultTheme () , true );
		Bloom.core().registerComponents = true;
		
//		var jj:Window = new Window ( this );


		var btn:Button = new Button(this, "Open Alert", openAlert );
		
		
		var cont:FlowContainer = new FlowContainer ( );
		cont.size ( 0,0 );
		cont.registerComponent = false;
		cont.direction = FlowContainer.VERTICALLY;
		

		var btn:Button = new Button(cont, "Test", howMany );
		var btn:Button = new Button(cont, "Test", howMany );
		var btn:Button = new Button(cont, "Test", howMany );
		var btn:Button = new Button(cont, "Test", howMany );
		
		_alertTest = new AlertWindow (cont);
		
		
//		buttonsTest ();
	}

	private function openAlert (e:MouseEvent):void {
		_alertTest.openWindow();
	}

	private function howMany (e:MouseEvent):void {
		trace(Bloom.core().componentRegistry.Registry.length);
	}

	private function buttonsTest ():void {
		var cont:FlowContainer = new FlowContainer ( this );
		cont.size ( 300 , 350 );
		cont.registerComponent = false;
		cont.direction = FlowContainer.GRID;


		
		
		/*
		
		var jj:Label = new Label ( cont , "Set Default" );
		var jj:Label = new Label ( cont , "Set Default" );
		var jj:Label = new Label ( cont , "Set Default" );
		var jj:Label = new Label ( cont , "Set Default" );
		var jj:Label = new Label ( cont , "Set Default" );
		var jj:Label = new Label ( cont , "Set Default" );
		
		var defaulttheme:Button = new Button ( cont , "Set Default" );
		defaulttheme.onDown.add ( _changeToDefaultTheme );

		var darktheme:Button = new Button ( cont , "Set Dark" );
		darktheme.onDown.add ( _changeToDarkTheme );

		var disablebtn:Button = new Button ( cont , "Disable" );
		disablebtn.registerComponent = false;
		disablebtn.onDown.add ( _disableComps );

		var darktheme:Button = new Button ( cont , "Dark and wide Always" );
		darktheme.width = 180;
		darktheme.model = new DarkButtonModel ();

		for ( var i:int = 0 ; i < 6 ; i ++ ) {
			var btn:Button = new Button ( cont , "Button " + i + " :)" );
		}

		var _altReg = Bloom.core ().newCompRegistry ( "alt" );

		for ( var i:int = 0 ; i < 6 ; i ++ ) {
			_altReg.registerComponent ( new Button ( cont , "alt reg " + i + " :)" ) );
		}

		var defaulttheme:Button = new Button ( cont , "Alt Default" );
		defaulttheme.onDown.add ( _changealtToDefaultTheme );

		var darktheme:Button = new Button ( cont , "Alt Dark" );
		darktheme.onDown.add ( _changealtToDarkTheme );
		
		*/
		
		
	}

	private function _disableComps ( event:MouseEvent ):void {
			Bloom.core().componentRegistry.disableComponents();
		}

	private function _changealtToDarkTheme ( event:MouseEvent ):void {
		var _altReg = Bloom.core().getCompRegistry("alt");
		_altReg.setTheme ( new DarkTheme () );
		_altReg.disableComponents();
	}

	private function _changealtToDefaultTheme ( event:MouseEvent ):void {
		var _altReg = Bloom.core().getCompRegistry("alt");
		_altReg.setTheme ( new DefaultTheme () );
		_altReg.disableComponents(true);
	}

	private function _changeToDarkTheme ( event:MouseEvent ):void {
		Bloom.core ().setTheme ( new DarkTheme () );
	}

	private function _changeToDefaultTheme ( event:MouseEvent ):void {
		Bloom.core ().setTheme ( new DefaultTheme () );
	}

}
}
