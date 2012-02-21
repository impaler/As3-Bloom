package bloom.themes.defaultTheme {

import bloom.brush.ColorBrush;
import bloom.components.Slider;
import bloom.style.*;

public class DefaultSliderStyle extends SliderStyle {
	

	public function DefaultSliderStyle () {
		
		var data:Vector.<uint> = new Vector.<uint> ( 1 , true );
		data[Slider.NORMAL] = 0xccccff;
		backgroundBrush = new ColorBrush( data );
		
		sliderButton = new DefaultSliderButtonStyle();
		
	}
	
	///////////////////////////////////
	// toString
	///////////////////////////////////
	
	override public function toString():String {
		return "[bloom.style.default.DefaultSliderStyle]";
	}
	
}
}
