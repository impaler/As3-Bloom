package bloom.style {

import bloom.brush.Brush;
import bloom.core.IStyleBase;

public class SliderStyle implements IStyleBase {
	
	public var backgroundBrush:Brush;
	public var sliderButton:ButtonBaseStyle;
	
	///////////////////////////////////
	// toString
	///////////////////////////////////
	
	public function toString():String {
		return "[bloom.style.default.SliderStyle]";
	}
	
}
}
