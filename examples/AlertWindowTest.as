package {

import bloom.components.Button;
import bloom.containers.AlertWindow;
import bloom.core.Bloom;
import bloom.themes.defaultTheme.DefaultTheme;

import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.MouseEvent;

public class AlertWindowTest extends Sprite {

	public function AlertWindowTest () {
		stage.align = StageAlign.TOP_LEFT;
		stage.scaleMode = StageScaleMode.NO_SCALE;
		stage.showDefaultContextMenu = false;

		Bloom.core ().init ( stage , new DefaultTheme () , true );
		Bloom.core ().registerComponents = true;

		var alert:AlertWindow = new AlertWindow ( );
		var alertBtn:Button = new Button ( this, "Alert", function(e:MouseEvent) {alert.openWindow();} );

	}

}
}
