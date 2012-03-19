package theme_previewer.tabs {

import bloom.components.containers.Container;
import bloom.components.containers.FlowBox;
import bloom.components.containers.HBox;
import bloom.components.containers.VBox;
import bloom.components.controls.ButtonBase;
import bloom.core.IComponent;
import bloom.utils.ComponentUtils;

import flash.display.Sprite;

public class TabContainers extends Sprite {
	public function TabContainers () {

//		var Content:HBox = new HBox (this);
		var Content:VBox = new VBox (this);
		Content.contentPadding = 0;
		Content.autoSize = true;
		Content.bgEnabled = false;

		var fsfs:VBox = new VBox (this);
		for (var i:int = 0; i < 10; i ++) {
			addRemoveHandler (fsfs.addContent (new ButtonBase()), fsfs);
		}
		Content.addContent (fsfs);

		var HScrollContent:HBox = new HBox (this);
		for (var i:int = 0; i < 10; i ++) {
			HScrollContent.addContent (ComponentUtils.createIconButtonTest ());
		}
		Content.addContent (HScrollContent);

		var VScrollContent:VBox = new VBox (this);
		for (var i:int = 0; i < 10; i ++) {
			VScrollContent.addContent (ComponentUtils.createIconButtonTest ());
		}
		Content.addContent (VScrollContent);

		var TestFlowBox:FlowBox = new FlowBox ();
		TestFlowBox.hGap = 0;
		TestFlowBox.vGap = 0;
		TestFlowBox.width = 100;
		for (var i:int = 0; i < 13; i ++) {
			TestFlowBox.addContent (ComponentUtils.createIconButtonTest ());
		}

		Content.addContent (TestFlowBox);

		Content.move (30,30);

	}

	public function addRemoveHandler (value:IComponent, cont:Container):void {

		var but:ButtonBase = value as ButtonBase;

		but.mouseDown.addOnce(function(e:*):void{
			cont.removeContent(but);
		});
	}

}
}
