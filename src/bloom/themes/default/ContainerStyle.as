package bloom.themes.default {

import bloom.brush.Brush;
import bloom.brush.ColorBrush;
import bloom.components.Container;
import bloom.core.IStyleBase;

public class ContainerStyle implements IStyleBase {
	
	public var backgroundBrush:Brush;
	
	public function ContainerStyle () {
		
		var data:Vector.<uint> = new Vector.<uint> ( 1 , true );
		data[Container.NORMAL] = 0x666983;
		backgroundBrush = new ColorBrush( data );
		
	}
	
	///////////////////////////////////
	// toString
	///////////////////////////////////
	
	public function toString():String {
		return "[bloom.themes.default.ContainerStyle]";
	}
	
}
}
