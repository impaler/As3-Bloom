package bloom.themes.defaultTheme {

import bloom.brush.ColorBrush;
import bloom.components.ScrollContainer;
import bloom.style.ScrollContainerStyle;

public class DefaultScrollContainerStyle extends ScrollContainerStyle {
	
	public function DefaultScrollContainerStyle () {
		var data:Vector.<uint> = new Vector.<uint> ( 1 , true );
		data[ScrollContainer.NORMAL] = 0x6666ff;
		backgroundBrush = new ColorBrush( data );
		
		SC_ScrollBarButton = new DefaultSliderButtonStyle();
	}
	
	///////////////////////////////////
	// toString
	///////////////////////////////////
	
	override public function toString():String {
		return "[bloom.style.default.DefaultScrollContainerStyle]";
	}
	
}
}
