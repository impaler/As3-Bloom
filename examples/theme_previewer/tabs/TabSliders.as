package theme_previewer.tabs {

import bloom.containers.VBox;
import bloom.controls.Slider;
import bloom.core.ComponentConstants;

import flash.display.Sprite;

public class TabSliders extends Sprite {
	public function TabSliders () {

		var HSlider:Slider = new Slider (null,ComponentConstants.HORIZONTALLY);
		var VSlider:Slider = new Slider (null,ComponentConstants.VERTICALLY);

		var Content:VBox = new VBox (this);
		Content.addContent (HSlider);
		Content.addContent (VSlider);

	}

}
}
