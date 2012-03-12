package theme_previewer.tabs {

import bloom.containers.FlowBox;
import bloom.containers.HBox;
import bloom.containers.VBox;
import bloom.controls.ButtonBase;
import bloom.core.ComponentConstants;
import bloom.style.brush.ColorBrush;
import bloom.style.controls.ButtonBaseStyle;
import bloom.utils.ColorUtils;
import bloom.utils.ComponentUtils;

import flash.display.Sprite;

public class TabContainers extends Sprite {
	public function TabContainers () {

		var VScrollContent:HBox = new HBox ();
		for (var i:int = 0; i < 10; i ++) {
			VScrollContent.addContent (ComponentUtils.createIconButtonTest ());
		}

		var HScrollContent:VBox = new VBox ();
		for (var i:int = 0; i < 10; i ++) {
			HScrollContent.addContent (ComponentUtils.createIconButtonTest ());
		}

		var TestFlowBox:FlowBox = new FlowBox ();
		TestFlowBox.hGap = 0;
		TestFlowBox.vGap = 0;
		TestFlowBox.width = 100;
		for (var i:int = 0; i < 10; i ++) {
			TestFlowBox.addContent (ComponentUtils.createIconButtonTest ());
		}

		var Content:VBox = new VBox (this);
		Content.bgEnabled = false;
		Content.addContent (HScrollContent);
		Content.addContent (VScrollContent);
		Content.addContent (TestFlowBox);
	}

}
}
