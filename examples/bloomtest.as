package {

import bloom.components.Button;
import bloom.components.Label;
import bloom.containers.FlowContainer;
import bloom.containers.Window;
import bloom.core.Bloom;
import bloom.themes.darkTheme.DarkButtonModel;
import bloom.themes.darkTheme.DarkTheme;
import bloom.themes.defaultTheme.DefaultTheme;

import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.MouseEvent;

public class bloomtest extends Sprite {

	public function bloomtest () {
		stage.align = StageAlign.TOP_LEFT;
		stage.scaleMode = StageScaleMode.NO_SCALE;
		stage.showDefaultContextMenu = false;

		Bloom.core ().init ( stage , new DefaultTheme () , true );

		var cont:FlowContainer = new FlowContainer ( this );
		cont.size ( 300 , 350 );
		cont.direction = FlowContainer.GRID;

		var window:Window = new Window ( this , cont );
		window._liveResize = true;
		window.width = 500;
		window.height = 500;

		var defaulttheme:Button = new Button ( cont , "Set Default" );
		defaulttheme.addEventListener ( MouseEvent.MOUSE_DOWN , _changeToDefaultTheme );

		var darktheme:Button = new Button ( cont , "Set Dark" );
		darktheme.addEventListener ( MouseEvent.MOUSE_DOWN , _changeToDarkTheme );

		var darktheme:Button = new Button ( cont , "Dark always" );
		darktheme.model = new DarkButtonModel ();

		var fadsf:Label = new Label ( cont , "Label :)" );

		for ( var i:int = 0 ; i < 14 ; i ++ ) {
			var btn:Button = new Button ( cont , "Button " + i + " :)" );
		}

	}

	private function _changeToDarkTheme ( event:MouseEvent ):void {
		Bloom.core ().setTheme ( new DarkTheme () );
	}

	private function _changeToDefaultTheme ( event:MouseEvent ):void {
		Bloom.core ().setTheme ( new DefaultTheme () );
	}

}
}
