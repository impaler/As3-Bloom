/**
 * Date: 12/03/12
 * Time: 3:37 PM
 */
package theme_previewer.tabs {

import bloom.containers.FlowBox;
import bloom.containers.HBox;
import bloom.containers.ScrollContainer;
import bloom.containers.VBox;
import bloom.controls.ButtonBase;
import bloom.utils.ComponentUtils;

import flash.display.Sprite;

public class TabScrollContainers extends Sprite {
	public function TabScrollContainers () {

		var VScrollContent:HBox = new HBox ();
		VScrollContent.maskContent=false;
		for (var i:int = 0; i < 20; i ++) {
			VScrollContent.addContent (ComponentUtils.createIconButtonTest ());
		}

		var VScroll:ScrollContainer = new ScrollContainer ();
		VScroll.addContent (VScrollContent);
		VScroll.size (300,80);

		var HScrollContent:VBox = new VBox ();
		for (var i:int = 0; i < 20; i ++) {
			HScrollContent.addContent (ComponentUtils.createIconButtonTest ());
		}

		var HScroll:ScrollContainer = new ScrollContainer ();
		HScroll.addContent (HScrollContent);
		HScroll.size (160,300);



		var GridScrollContent:FlowBox = new FlowBox ();
		GridScrollContent.size (600,600);
		for (var i:int = 0; i < 100; i ++) {
			GridScrollContent.addContent (ComponentUtils.createIconButtonTest ());
		}

		var GridScroll:ScrollContainer = new ScrollContainer ();
		GridScroll.addContent (GridScrollContent);
		GridScroll.size (300,300);

		var Content:VBox = new VBox (this);
		Content.addContent (VScroll);
		Content.addContent (HScroll);
		Content.addContent (GridScroll);
	}
}
}
