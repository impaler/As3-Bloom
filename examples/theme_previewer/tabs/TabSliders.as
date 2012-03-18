package theme_previewer.tabs {

import bloom.components.containers.VBox;
import bloom.components.controls.Slider;
import bloom.core.ComponentConstants;

import flash.display.Sprite;

public class TabSliders extends Sprite {
	public function TabSliders () {

		var HSlider:Slider = new Slider (null,ComponentConstants.HORIZONTALLY);
		var HSliderLarge:Slider = new Slider (null,ComponentConstants.HORIZONTALLY);
		HSliderLarge.size(300, 70);
		HSliderLarge.value = 80;

		var VSlider:Slider = new Slider (null,ComponentConstants.VERTICALLY);
		var VSliderLarge:Slider = new Slider (null,ComponentConstants.VERTICALLY);
		VSliderLarge.size(70, 300);
		VSliderLarge.value = 30;

		var Content:VBox = new VBox (this);
		Content.addContent (HSlider);
		Content.addContent (HSliderLarge);
		Content.addContent (VSlider);
		Content.addContent (VSliderLarge);

	}

}
}
