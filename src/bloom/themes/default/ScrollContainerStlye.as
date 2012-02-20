package bloom.themes.default {

import bloom.brush.Brush;
import bloom.brush.ColorBrush;
import bloom.components.ScrollContainer;
import bloom.core.IStyleBase;

public class ScrollContainerStlye implements IStyleBase {
	
	public var backgroundBrush:Brush;
	public var SC_ScrollBarButton:IStyleBase;
	
	public function ScrollContainerStlye () {
		var data:Vector.<uint> = new Vector.<uint> ( 1 , true );
		data[ScrollContainer.NORMAL] = 0x6666ff;
		backgroundBrush = new ColorBrush( data );
		
		SC_ScrollBarButton = new SliderButtonStyle();
	}
	
	///////////////////////////////////
	// toString
	///////////////////////////////////
	
	public function toString():String {
		return "[bloom.themes.default.ScrollContainerStlye]";
	}
	
}
}
