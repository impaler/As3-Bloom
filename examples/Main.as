package 
{

import bloom.core.StateConstants;

import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import bloom.components.*;
	import bloom.core.OmniCore;
	import bloom.themes.blue.BlueTheme;
	
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
			
			OmniCore.init(stage, BlueTheme);
			
//			var flowContainer:FlowContainer = new FlowContainer(this, FlowContainer.VERTICALLY);
//			flowContainer.size(220, 620);
			
//			var label:Label = new Label(flowContainer.content, "Label");
			
			var RedButtonBase:ButtonBaseStyle = new ButtonBaseStyle();
//			RedButtonBase.down
			
			
			var buttonBase:ButtonBase = new ButtonBase(this);
			
			var buttonBase:ButtonBase = new ButtonBase(this);
			buttonBase.y = 60;
			buttonBase.style = RedButtonBase;
			
			
//			buttonBase = new ButtonBase(flowContainer.content);
//			buttonBase.state = StateConstants.OVER;
//			buttonBase = new ButtonBase(flowContainer.content);
//			buttonBase.state = StateConstants.DOWN;
			
	/*		var button:Button = new Button(flowContainer.content, "One does not simply");
			button.icon = new Bitmap(new BitmapData(10, 10, false, 0xffff00));
			button.size(200, 30);
			button.mouseDown.add(function(e:MouseEvent):void {
				button.title.text = "Click this Button :D";
			});
			button.mouseUp.add(function(e:MouseEvent):void {
				button.title.text = "One does not simply";
			});
			
			var checkBox:CheckBox = new CheckBox(flowContainer.content, "Normal");
			checkBox.valueChanged.add(function(target:CheckBox):void {
				target.title.text = target.value ? "Active" : "Normal";
			});
			
			var textInput:TextInput = new TextInput(flowContainer.content, "Nothing");
			
			label = new Label(flowContainer.content, "CheckBoxGroup index: -1");
			
			var checkBoxGroup:CheckBoxGroup = new CheckBoxGroup( -1);
			
			checkBox = new CheckBox(flowContainer.content, "CheckBox");
			checkBoxGroup.addChild(checkBox);
			
			checkBox = new CheckBox(flowContainer.content, "CheckBox");
			checkBoxGroup.addChild(checkBox);
			
			checkBox = new CheckBox(flowContainer.content, "CheckBox");
			checkBoxGroup.addChild(checkBox);
			
			checkBoxGroup.add(function(target:CheckBoxGroup):void {
				label.text = "CheckBoxGroup index: " + target.index.toString();
			});
			
			var numericStepper:NumericStepper = new NumericStepper(flowContainer.content);
			//numericStepper.increase.iconNormal = new Bitmap(new BitmapData(10, 5, false, 0xffff00));
			
			var progressBar:ProgressBar = new ProgressBar(flowContainer.content, 30);
			//progressBar.value = 100;
			
			var slider:Slider = new Slider(flowContainer.content, Slider.HORIZONTALLY);
			
			var textBox:TextBox = new TextBox(flowContainer.content);
			textBox.scrollBar.width = 30;
			textBox.size(200, 100);
			
			var toggleButton:ToggleButton = new ToggleButton(flowContainer.content, "Toggle");
			toggleButton.icon = new Bitmap(new BitmapData(10, 10, false, 0xffff00));
			
			flowContainer.update();
			
			var scrollContainer:ScrollContainer = new ScrollContainer(this);
			scrollContainer.move(230, 10);
			scrollContainer.setScrollBar(true, true);
			scrollContainer.setContentSize(200, 200);
			scrollContainer.getScrollBar(FlowContainer.HORIZONTALLY).height = 30;
			scrollContainer.getScrollBar(FlowContainer.VERTICALLY).width = 30;
			
			flowContainer = new FlowContainer();
			flowContainer.margin.reset(0, 8, 0, 8);
			
			var window:Window = new Window(this, flowContainer);
			window.header.content.addChild(new Label(null, "Window"));
			window.header.update();
			window.liveResize = true;
			window.move(230, 120);*/
		}
		
	}
	
}