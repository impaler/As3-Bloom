package bloom.style {

import bloom.brush.Brush;
import bloom.brush.ColorBrush;
import bloom.components.ScrollContainer;
import bloom.core.IStyleBase;

public class ScrollContainerStyle implements IStyleBase {
	
	public var backgroundBrush:Brush;
	public var scrollBar:SliderStyle;
	
	///////////////////////////////////
	// toString
	///////////////////////////////////
	
	public function toString():String {
		return "[bloom.style.default.ScrollContainerStyle]";
	}
	
}
}
