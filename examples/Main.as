package 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import bloom.components.*;
	import bloom.core.ScaleBitmap;
	import bloom.core.ThemeBase;
	import bloom.styles.ContainerStyle;
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
			
			var label:Label = new Label(flowContainer.content, "Label");
			
			var buttonBase:ButtonBase = new ButtonBase(flowContainer.content);
			buttonBase = new ButtonBase(flowContainer.content);
			buttonBase.state = ButtonBase.OVER;
			buttonBase = new ButtonBase(flowContainer.content);
			buttonBase.state = ButtonBase.DOWN;
			
			var button:Button = new Button(flowContainer.content, "One does not simply");
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
			
			var accordion:Accordion = new Accordion(this);
			accordion.multiSelect = true;
			accordion.move(230, 230);
			
			var accordionContent:AccordionContent = new AccordionContent("Part 0");
			accordionContent.width = 200;
			accordionContent.content.height = 50;
			accordionContent.content.addChild(new Button(null, "Button"));
			accordionContent.content.update();
			accordion.addContent(accordionContent);
			
			accordionContent = new AccordionContent("Part 1");
			accordionContent.width = 200;
			accordionContent.content.height = 100;
			accordionContent.content.addChild(new CheckBox(null, "CheckBox"));
			accordionContent.content.update();
			accordion.addContent(accordionContent);
			
			accordionContent = new AccordionContent("Part 2");
			accordionContent.width = 200;
			accordionContent.content.height = 40;
			accordionContent.content.addChild(new ToggleButton(null, "ToggleButton"));
			accordionContent.content.update();
			accordion.addContent(accordionContent);
			
			accordion.update();
			
			var tabBox:TabBox = new TabBox(this);
			tabBox.move(340, 10);
			tabBox.size(300, 100);
			
			var tabBoxContent:TabBoxContent = new TabBoxContent("Part 0");
			tabBoxContent.content.addChild(new Button(null, "Button"));
			tabBoxContent.content.update();
			tabBox.addContent(tabBoxContent);
			
			tabBoxContent = new TabBoxContent("Part 1");
			tabBoxContent.content.addChild(new CheckBox(null, "CheckBox"));
			tabBoxContent.content.update();
			tabBox.addContent(tabBoxContent);
			
			tabBoxContent = new TabBoxContent("Part 2");
			tabBoxContent.title.icon = new Bitmap(new BitmapData(10, 10, false, 0xffff00));
			tabBoxContent.content.addChild(new ToggleButton(null, "ToggleButton"));
			tabBoxContent.content.update();
			tabBox.addContent(tabBoxContent);
			
			tabBox.header.update();
			
			var style:ContainerStyle = new ContainerStyle();
			style.background = new ScaleBitmap(new BitmapData(1, 1, false, 0xCCCCCC));
			
			flowContainer = new FlowContainer();
			flowContainer.style = style;
			flowContainer.margin.reset(0, 8, 0, 8);
			
			var window:Window = new Window(this, flowContainer);
			window.header.content.addChild(new Label(null, "Window"));
			window.header.update();
			window.liveResize = true;
			window.move(230, 120);
		}
		
	}
	
}