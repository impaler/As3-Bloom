package omni.examples.components;

import omni.components.gui.layout.Layout;
import omni.components.gui.controls.Slider;
import omni.components.core.OCore;
import omni.components.core.OButtonBase;

class SliderTests
{
	public function new()
	{
		var layout = new Layout();
		OCore.addChild(layout);
		
		var slider = new Slider();
		slider.type = Slider.HORIZONTALLY;
		slider.move(160, 30);
		slider.onChange.add(sliderChange);
		layout.add(slider);
		
		var slider = new Slider();
		slider.type = Slider.HORIZONTALLY;
		slider.move(160, 30);
		slider.size(590, 60);
		slider.onChange.add(sliderChange);
		layout.add(slider);
		
		var Hlayout = new Layout();
		Hlayout.direction = Layout.HORIZONTALLY;
		layout.add(Hlayout);
		
		var slider = new Slider();
		Hlayout.add(slider);
		slider.type = Slider.VERTICALLY;
		slider.move(30, 30);
		slider.onChange.add(sliderChange);

				var slider = new Slider();
		slider.type = Slider.VERTICALLY;
		slider.move(30, 30);
		slider.size(80, 590);
		slider.onChange.add(sliderChange);
		Hlayout.add(slider);
		
	}

	public function sliderChange(value:Int):Void
	{
		nme.Lib.trace(value);
	}

}
