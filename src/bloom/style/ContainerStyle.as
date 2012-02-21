package bloom.style {

import bloom.brush.Brush;
import bloom.brush.ColorBrush;
import bloom.components.Container;
import bloom.core.IStyleBase;

public class ContainerStyle implements IStyleBase {
	
	public var backgroundBrush:Brush;
	
	///////////////////////////////////
	// toString
	///////////////////////////////////
	
	public function toString():String {
		return "[bloom.style.default.ContainerStyle]";
	}
	
}
}
