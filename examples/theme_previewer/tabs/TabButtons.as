package theme_previewer.tabs {

import bloom.components.containers.VBox;
import bloom.components.controls.Button;
import bloom.components.controls.ButtonBase;
import bloom.core.ComponentConstants;
import bloom.style.brush.ColorBrush;
import bloom.style.components.controls.ButtonBaseStyle;
import bloom.themes.darkBasic.DarkButtonBase;
import bloom.utils.ColorUtils;
import bloom.utils.ComponentUtils;

import flash.display.Sprite;

public class TabButtons extends Sprite {
	public function TabButtons () {

		var ButtonBasic:ButtonBase = new ButtonBase ();

		var ButtonLabel:Button = new Button (null,"ButtonExtended");

		var ButtonLabelIcon:Button = new Button (null,"ButtonLabelIcon");
		ButtonLabelIcon.icon = ComponentUtils.createIconButtonTest ();

		var ButtonIcon:Button = new Button (null);
		ButtonIcon.icon = ComponentUtils.createIconButtonTest ();

		var Content:VBox = new VBox (this);
		Content.addContent (ButtonBasic);
		Content.addContent (ButtonLabel);
		Content.addContent (ButtonLabelIcon);
		Content.addContent (ButtonIcon);
	}

}
}
