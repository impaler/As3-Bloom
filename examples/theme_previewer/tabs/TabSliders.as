package theme_previewer.tabs {

import bloom.containers.VBox;
import bloom.controls.ButtonBase;
import bloom.controls.Slider;
import bloom.core.ComponentConstants;
import bloom.themes.darkBasic.DarkButtonBase;

import flash.display.Sprite;

public class TabSliders extends Sprite {
	public function TabSliders () {

		var HSlider:Slider = new Slider (null,ComponentConstants.HORIZONTALLY);
		var VSlider:Slider = new Slider (null,ComponentConstants.VERTICALLY);

		var Content:VBox = new VBox (this);
		Content.addContent (HSlider);
		Content.addContent (VSlider);

	}

	public function createIconButtonTest ():ButtonBase {
		var IconButton:ButtonBase = new ButtonBase ();
		IconButton.size (10,10);
		IconButton.style = new DarkButtonBase ();
		return IconButton;
	}

}
}
