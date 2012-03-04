package 
{

import bloom.components.*;
import bloom.core.ThemeBase;
import bloom.themes.BlueTheme;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;

public class PickerTest extends Sprite {
		
		public function PickerTest():void {
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			stage.showDefaultContextMenu = false;
			stage.scaleMode = "noScale";
			stage.align = "TL";
			
			ThemeBase.initialize(stage);
			ThemeBase.theme = new BlueTheme();
		
			
//			var Picker:ColorPicker = new ColorPicker(this);
			var Picker:ColorPicker = new ColorPicker(this, "Test Color");
			Picker.move(20,20);
			
		}
		
	}
	
}