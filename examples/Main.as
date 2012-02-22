package 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import bloom.components.*;
	import bloom.core.ThemeBase;
	import bloom.themes.BlueTheme;
	
	public class Main extends Sprite {
		
		public function Main():void {
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
			
			var label:Label = new Label(this, "Label");
			
			var buttonBase:ButtonBase = new ButtonBase(this);
			buttonBase.move(0, 20);
			buttonBase = new ButtonBase(this);
			buttonBase.state = ButtonBase.OVER;
			buttonBase.move(0, 50);
			buttonBase = new ButtonBase(this);
			buttonBase.state = ButtonBase.DOWN;
			buttonBase.move(0, 80);
			
			var button:Button = new Button(this, "One does not simply");
			button.size(200, 30);
			button.move(0, 110);
			button.mouseDown.add(function(e:MouseEvent):void {
				button.title.text = "Click this Button :D";
			});
			button.mouseUp.add(function(e:MouseEvent):void {
				button.title.text = "One does not simply";
			});
			
			var checkBox:CheckBox = new CheckBox(this, "I don't always change.");
			checkBox.move(0, 140);
			checkBox.valueChanged.add(function(target:CheckBox):void {
				target.title.text = target.value ? "But when i do i change my title." : "I don't always change.";
			});
			
			var textInput:TextInput = new TextInput(this, "Nothing");
			textInput.move(0, 160);
			
			label = new Label(this, "CheckBoxGroup index: -1");
			label.move(0, 180);
			
			var checkBoxGroup:CheckBoxGroup = new CheckBoxGroup( -1);
			
			checkBox = new CheckBox(this, "CheckBox");
			checkBox.move(0, 200);
			checkBoxGroup.addChild(checkBox);
			
			checkBox = new CheckBox(this, "CheckBox");
			checkBox.move(0, 220);
			checkBoxGroup.addChild(checkBox);
			
			checkBox = new CheckBox(this, "CheckBox");
			checkBox.move(0, 240);
			checkBoxGroup.addChild(checkBox);
			
			checkBoxGroup.add(function(target:CheckBoxGroup):void {
				label.text = "CheckBoxGroup index: " + target.index.toString();
			});
		}
		
	}
	
}