package theme_previewer.tabs {

import bloom.components.containers.HBox;
import bloom.components.containers.ScrollContainer;
import bloom.components.containers.VBox;
import bloom.components.containers.Window;
import bloom.components.controls.Button;
import bloom.utils.ComponentUtils;

import flash.display.Sprite;

public class TabWindowTest extends Sprite {
	public function TabWindowTest () {



		var HScrollContent:HBox = new HBox ();
		for (var i:int = 0; i < 20; i ++) {
			HScrollContent.addContent (ComponentUtils.createIconButtonTest ());
		}

		var HScroll:ScrollContainer = new ScrollContainer ();
		HScroll.addContent (HScrollContent);
		HScroll.size (300,80);

		var WindowHBox:Window = new Window ("",HScrollContent,false);
		WindowHBox.liveResize = true;
//		WindowHBox.addScrollContent (HScrollContent);



		var VScrollContent:VBox = new VBox ();
		for (var i:int = 0; i < 20; i ++) {
			VScrollContent.addContent (ComponentUtils.createIconButtonTest ());
		}

		var VScroll:ScrollContainer = new ScrollContainer ();
		VScroll.addContent (VScrollContent);
		VScroll.size (300,80);

		var WindowVBox:Window = new Window ("",VScrollContent,false);
//		WindowVBox.addScrollContent (VScrollContent);





		var HWindowButton:Button = new Button(null, "H Window");
		HWindowButton.mouseDown.add(function(e:*):void{WindowHBox.openWindow()});

		var VWindowButton:Button = new Button(null, "V Window");
		VWindowButton.mouseDown.add(function(e:*):void{WindowVBox.openWindow()});


		var WindowMenu:VBox = new VBox (this);
		WindowMenu.addContent(VWindowButton);
		WindowMenu.addContent(HWindowButton);






	}

}
}
