package theme_previewer.tabs {

import bloom.containers.HBox;
import bloom.containers.ScrollContainer;
import bloom.containers.VBox;
import bloom.containers.Window;
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

		var WindowHBox:Window = new Window (HScrollContent);
		WindowHBox.liveResize = true;
//		WindowHBox.addScrollContent (HScrollContent);



		var VScrollContent:VBox = new VBox ();
		for (var i:int = 0; i < 20; i ++) {
			VScrollContent.addContent (ComponentUtils.createIconButtonTest ());
		}

		var VScroll:ScrollContainer = new ScrollContainer ();
		VScroll.addContent (VScrollContent);
		VScroll.size (300,80);

		var WindowVBox:Window = new Window (VScrollContent);
//		WindowVBox.addScrollContent (VScrollContent);


	}

}
}
