package bloom.themes.default {

import bloom.brush.Brush;
import bloom.brush.ColorBrush;
import bloom.components.Slider;
import bloom.core.IStyleBase;

public class SliderStyle implements IStyleBase {
	
	public var backgroundBrush:Brush;
	
	public function SliderStyle () {
		
		var data:Vector.<uint> = new Vector.<uint> ( 1 , true );
		data[Slider.NORMAL] = 0xccccff;
		backgroundBrush = new ColorBrush( data );
		
	}
	
	///////////////////////////////////
	// toString
	///////////////////////////////////
	
	public function toString():String {
		return "[bloom.themes.default.SliderStyle]";
	}
	
}
}
