/**
 * Copyright (c) 2012 - 2100 Sindney
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */
package  
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	
	import bloom.brushes.ColorBrush;
	import bloom.containers.*;
	import bloom.core.Margin;
	import bloom.themes.*;
	import bloom.*;
	
	/**
	 * BMPExample
	 * 
	 * @author sindney, impaler
	 */
	[SWF(backgroundColor = 0xffffff, frameRate = 40, width = 500, height = 500)]
	public class BMPExample extends Sprite {
		
		[Embed(source="background.jpg")]
        private var background:Class;
		
		public function BMPExample() {
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.showDefaultContextMenu = false;
			
			addChild(new background());
			
			ThemeBase.setTheme(new BMPTheme());
			
	        // TabBox
			var tabBox:TabBox = new TabBox(this);
			tabBox.size(300, 200);
			tabBox.move(40, 40);
			
			var margin:Margin = new Margin(4, 4, 0, 0);
			
            //TabBox
			var flowContainer:FlowContainer = new FlowContainer();
			flowContainer.direction = FlowContainer.VERTICALLY;
            var but:Button = new Button(null, "Button");
            but.size(120,40);
            flowContainer.addChild(but);
			flowContainer.addChild(new NumericStepper());
			
			tabBox.addContent("Tab 0", flowContainer, margin);
			
			flowContainer = new FlowContainer();
			but = new Button(null, "Button");
            but.size(120,40);
			flowContainer.addChild(but);
			flowContainer.addChild(new NumericStepper());
			
			tabBox.addContent("Tab 1", flowContainer, margin);
			
			flowContainer = new FlowContainer();
			
            var slide:Slider = new Slider();
            slide.size(30, 100);
			flowContainer.addChild(slide);
            slide = new Slider(null, 1, 50);
            slide.size(100, 30);
			flowContainer.addChild(slide);
			
			tabBox.addContent("Tab 2", flowContainer, margin);
			
			tabBox.addContent("Tab 3", new FlowContainer(), margin);
			
			tabBox.toggleTab("Tab 0");
			
			var container:ScrollContainer = new ScrollContainer();
			
			var white:Vector.<uint> = new Vector.<uint>(1, true);
			white[0] = 0xE9E9E9;
			container.brush = new ColorBrush(white);
			
			container.direction = ScrollContainer.VERTICALLY;
			container.margin.reset(2, 10, 2, 10);
			
			var window:Window = new Window(this, container);
			window.liveResize = true;
			window.footerSize = 20;
			window.size(300, 200);
			window.move(100, 150);
			
			var button:Button = new Button(container.content, "Demo");
			button.size(120, 40);
			button.move(10, 10);
			
			var sliderv:Slider = new Slider(container.content);
			sliderv.size(30, 120);
			sliderv.move(10, 60);
			
			var sliderh:Slider = new Slider(container.content, Slider.HORIZONTALLY);
			sliderh.size(200, 30);
			sliderh.move(10, 190);
			
			var numericStepper:NumericStepper = new NumericStepper(container.content);
			//numericStepper.size(80, 30);
			numericStepper.move(10, 230);
			
			numericStepper = new NumericStepper(container.content);
			//numericStepper.size(80, 30);
			numericStepper.move(100, 230);
			
			var checkBox:CheckBox = new CheckBox(container.content, "CheckBox");
			checkBox.move(10, 270);
			
			progressBar = new ProgressBar(container.content, 0);
			progressBar.size(200, 30);
			progressBar.move(10, 300);
            progressBar.addEventListener(Event.ENTER_FRAME, onLoop);
			
            progressBar = new ProgressBar(container.content, 0);
     	    progressBar.size(60, 60);
     		progressBar.move(10, 350);
			progressBar.addEventListener(Event.ENTER_FRAME, onLoop);
			
			container.calculateContentSize();
			window.header.addChild(new Label(null, "Whatever"));
		}
		
		private var decrease:Boolean = false;
		private var progressBar:ProgressBar;
		
		private function onLoop(e:Event):void {
            var bar:ProgressBar = e.target as ProgressBar;
			if (bar.value == 100) decrease = true;
			if (bar.value == 0) decrease = false;
            bar.value += decrease ? -1 : 1;
		}
		
	}

}