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
	 * BMPExample
	 * 
	 * @author sindney, impaler
	 */
	public class BMPExample extends Sprite {
		
		public function BMPExample() {
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.showDefaultContextMenu = false;
			
			ThemeBase.setTheme(new BMPTheme());
			
			var button:Button = new Button(this, "Demo");
			button.size(120, 40);
			button.move(10, 10);
			
			var sliderv:Slider = new Slider(this);
			sliderv.size(30, 120);
			sliderv.move(10, 60);
			
			var sliderh:Slider = new Slider(this, Slider.HORIZONTALLY);
			sliderh.size(200, 30);
			sliderh.move(10, 190);
			
			var numericStepper:NumericStepper = new NumericStepper(this);
			numericStepper.size(80, 30);
			numericStepper.move(10, 230);
			
			numericStepper = new NumericStepper(this);
			numericStepper.size(80, 30);
			numericStepper.move(100, 230);
			
			var checkBox:CheckBox = new CheckBox(this, "CheckBox");
			checkBox.move(10, 270);
			
			progressBar = new ProgressBar(this, 0);
			progressBar.size(200, 30);
			progressBar.move(10, 300);
            progressBar.addEventListener(Event.ENTER_FRAME, onLoop);

            progressBar = new ProgressBar(this, 0);
     	    progressBar.size(60, 60);
     		progressBar.move(10, 350);
			progressBar.addEventListener(Event.ENTER_FRAME, onLoop);
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
