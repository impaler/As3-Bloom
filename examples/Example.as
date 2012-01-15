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
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	
	import bloom.containers.*;
	import bloom.themes.*;
	import bloom.*;
	
	/**
	 * Bloom Example
	 * 
	 * @date 2012/1/14 22:40
	 * @author sindney
	 */
	[SWF(backgroundColor = 0x000000, frameRate = 40, width = 400, height = 500)]
	public class Example extends Sprite {
		
		private var scrollContainer:ScrollContainer;
		
		public function Example():void {
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.showDefaultContextMenu = false;
			
			ThemeBase.setTheme(new DefaultTheme());
			
			var i:int;
			var data:Array = [];
			for (i = 0; i < 10000; i++) {
				data[i] = ["NO." + i.toString()];
			}
			
			scrollContainer = new ScrollContainer(null);
			
			var window:Window = new Window(this, scrollContainer);
			window.minWidth = 200;
			window.minHeight = 200;
			window.headerSize = 30;
			window.footerSize = 30;
			window.size(200, 200);
			window.move(10, 10);
			window.footer.addChild(new Label(null, "Status"));
			
			var label:Label = new Label(scrollContainer.content, "I'v been busy, really.");
			
			var checkBox:CheckBox = new CheckBox(scrollContainer.content, "CheckBox");
			
			var button:Button = new Button(scrollContainer.content, "Button");
			
			var slider:Slider = new Slider(scrollContainer.content, "v");
			
			var list:List = new List(scrollContainer.content, data);
			list.size(200, 100);
			
			var numericStepper:NumericStepper = new NumericStepper(scrollContainer.content);
			
			var textInput:TextInput = new TextInput(scrollContainer.content, "TextInput");
			
			var textBox:TextBox = new TextBox(scrollContainer.content, "TextBox");
			textBox.width = 200;
			
			var toggleButton:ToggleButton = new ToggleButton(scrollContainer.content, "ToggleButton");
			
			var toggleSwitcher:ToggleSwitcher = new ToggleSwitcher(scrollContainer.content, true);
			toggleSwitcher.width = 200;
			
			var progressBar:ProgressBar = new ProgressBar(scrollContainer.content, 30);
			progressBar.width = 200;
			
			scrollContainer.direction = ScrollContainer.VERTICALLY;
			
			// run this once, when you have changes in scrollContainer.content.
			// or you can set content's size to a certain value by scrollContainer.setContainerSize(x,x);
			scrollContainer.calculateContentSize();
			scrollContainer.setScrollBar(true, true);
			
			//window.enabled = false;
		}
		
	}
	
}