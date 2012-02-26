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
			
			var flowContainer:FlowContainer = new FlowContainer(this, FlowContainer.VERTICALLY);
			flowContainer.size(220, 620);
			
			var label:Label = new Label(flowContainer, "Label");
			
			var buttonBase:ButtonBase = new ButtonBase(flowContainer);
			buttonBase = new ButtonBase(flowContainer);
			buttonBase.state = ButtonBase.OVER;
			buttonBase = new ButtonBase(flowContainer);
			buttonBase.state = ButtonBase.DOWN;
			
			var button:Button = new Button(flowContainer, "One does not simply");
			button.icon = new Bitmap(new BitmapData(10, 10, false, 0xffff00));
			button.size(200, 30);
			button.mouseDown.add(function(e:MouseEvent):void {
				button.title.text = "Click this Button :D";
			});
			button.mouseUp.add(function(e:MouseEvent):void {
				button.title.text = "One does not simply";
			});
			
			var checkBox:CheckBox = new CheckBox(flowContainer, "Normal");
			checkBox.valueChanged.add(function(target:CheckBox):void {
				target.title.text = target.value ? "Active" : "Normal";
			});
			
			var textInput:TextInput = new TextInput(flowContainer, "Nothing");
			
			label = new Label(flowContainer, "CheckBoxGroup index: -1");
			
			var checkBoxGroup:CheckBoxGroup = new CheckBoxGroup( -1);
			
			checkBox = new CheckBox(flowContainer, "CheckBox");
			checkBoxGroup.addChild(checkBox);
			
			checkBox = new CheckBox(flowContainer, "CheckBox");
			checkBoxGroup.addChild(checkBox);
			
			checkBox = new CheckBox(flowContainer, "CheckBox");
			checkBoxGroup.addChild(checkBox);
			
			checkBoxGroup.add(function(target:CheckBoxGroup):void {
				label.text = "CheckBoxGroup index: " + target.index.toString();
			});
			
			var numericStepper:NumericStepper = new NumericStepper(flowContainer);
			//numericStepper.increase.iconNormal = new Bitmap(new BitmapData(10, 5, false, 0xffff00));
			
			var progressBar:ProgressBar = new ProgressBar(flowContainer, 30);
			//progressBar.value = 100;
			
			var slider:Slider = new Slider(flowContainer, Slider.HORIZONTALLY);
			
			var textBox:TextBox = new TextBox(flowContainer);
			//textBox.scrollBar.width = 30;
			textBox.size(200, 100);
			
			var toggleButton:ToggleButton = new ToggleButton(flowContainer, "Toggle");
			toggleButton.icon = new Bitmap(new BitmapData(10, 10, false, 0xffff00));
			
			flowContainer.update();
		}
		
	}
	
}