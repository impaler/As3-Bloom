package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	import bloom.control.ThemeBase;
	import bloom.components.*;
	import bloom.themes.default.DefaultTheme;
	
	/**
	 * Example
	 */
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
			
			ThemeBase.theme = new DefaultTheme();
			
			var label:Label = new Label(this, "Label");
			
			var buttonBase:ButtonBase = new ButtonBase(this);
			buttonBase.y = 20;
			
			var button:Button = new Button(this, "Button");
			button.y = 50;
			
			var checkBox:CheckBox = new CheckBox(this, "CheckBox");
			checkBox.y = 80;
			
			var cbg:CheckBoxGroup = new CheckBoxGroup( -1);
			
			checkBox = new CheckBox(this, "RadioBox 0");
			checkBox.y = 100;
			cbg.addChild(checkBox);
			
			checkBox = new CheckBox(this, "RadioBox 1");
			checkBox.y = 120;
			cbg.addChild(checkBox);
			
			checkBox = new CheckBox(this, "RadioBox 2");
			checkBox.y = 140;
			cbg.addChild(checkBox);
			
			cbg.index = 0;
			
			var textInput:TextInput = new TextInput(this, "TextInput");
			textInput.y = 160;
			
			var numericStepper:NumericStepper = new NumericStepper(this);
			numericStepper.y = 180;
			
			var progressBar:ProgressBar = new ProgressBar(this, 50);
			progressBar.y = 200;
		}
		
	}
	
}