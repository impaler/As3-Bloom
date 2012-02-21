package bloom.style {

import bloom.brush.Brush;
import bloom.brush.ColorBrush;
import bloom.components.ScrollContainer;
import bloom.core.IStyleBase;

public class ScrollContainerStyle implements IStyleBase {
	
	public var backgroundBrush:Brush;
	public var SC_ScrollBarButton:IStyleBase;
	
	public function ScrollContainerStyle () {
		var data:Vector.<uint> = new Vector.<uint> ( 1 , true );
		data[ScrollContainer.NORMAL] = 0x6666ff;
		backgroundBrush = new ColorBrush( data );
		
		SC_ScrollBarButton = new ButtonStyle();
	}
	
	///////////////////////////////////
	// toString
	///////////////////////////////////
	
	public function toString():String {
		return "[bloom.style.default.ScrollContainerStyle]";
	}
	
}
}
