package bloom.style {

import bloom.brush.Brush;
import bloom.core.IStyleBase;

public class WindowStyle implements IStyleBase {
	
	public var backgroundBrush:Brush;
	public var scalerBrush:Brush;
	
	public var header:ContainerStyle;
	public var footer:ContainerStyle;
	
	///////////////////////////////////
	// toString
	///////////////////////////////////
	
	public function toString():String {
		return "[bloom.style.default.WindowStyle]";
	}
	
}
}
