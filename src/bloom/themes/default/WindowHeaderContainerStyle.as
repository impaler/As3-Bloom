package bloom.themes.default {

import bloom.brush.ColorBrush;
import bloom.components.Container;
import bloom.core.IStyleBase;

public class WindowHeaderContainerStyle extends FlowContainerStyle implements IStyleBase {
	public function WindowHeaderContainerStyle () {
		
		var data:Vector.<uint> = new Vector.<uint> ( 1 , true );
		data[Container.NORMAL] = 0x000000;
		backgroundBrush = new ColorBrush( data );
		
	}
	
	///////////////////////////////////
	// toString
	///////////////////////////////////
	
	override public function toString():String {
		return "[bloom.themes.default.WindowHeaderContainerStyle]";
	}
}
}
