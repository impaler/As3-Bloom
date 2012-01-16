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
	 * @author sindney
	 */
	public class BMPExample extends Sprite {
		
		public function BMPExample() {
			ThemeBase.setTheme(new BMPTheme());
			
			var button:Button = new Button(this, "Demo");
			button.size(120, 30);
			button.move(10, 10);
			
			var sliderv:Slider = new Slider(this);
			sliderv.size(30, 120);
			sliderv.move(10, 50);
			
			var sliderh:Slider = new Slider(this, "h");
			sliderh.size(120, 30);
			sliderh.move(10, 180);
			
			var numericStepper:NumericStepper = new NumericStepper(this);
			numericStepper.size(100, 30);
			numericStepper.move(10, 220);
		}
		
	}

}