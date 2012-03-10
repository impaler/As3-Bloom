package {

import bloom.controls.*;
import bloom.core.OmniCore;
import bloom.themes.blue.BlueTheme;
import bloom.utils.ColorUtils;

import flash.display.Sprite;
import flash.events.Event;

public class PickerTest extends Sprite {

	public function PickerTest ():void {
		if (stage) init (); else addEventListener (Event.ADDED_TO_STAGE,init);
	}

	private function init (e:Event = null):void {
		removeEventListener (Event.ADDED_TO_STAGE,init);
		stage.showDefaultContextMenu = false;
		stage.scaleMode = "noScale";
		stage.align = "TL";

//		OmniCore.initialize (stage);
//		OmniCore.defaultTheme = new BlueTheme ();

//			var Picker:ColorPicker = new ColorPicker(this);
//		var Picker:ColorPicker = new ColorPicker (this,"Test Color");
//		Picker.color = ColorUtils.randomColor ();
//		Picker.move (20,20);

	}

}

}
