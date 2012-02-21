package bloom.themes.defaultTheme  {

import bloom.brush.ColorBrush;
import bloom.components.Container;
import bloom.core.IStyleBase;
import bloom.style.*;

public class DefaultWindowFooterContainerStyle extends ContainerStyle {
	public function DefaultWindowFooterContainerStyle () {
		
		var data:Vector.<uint> = new Vector.<uint> ( 1 , true );
		data[Container.NORMAL] = 0x000000;
		backgroundBrush = new ColorBrush( data );
		
	}
	
	///////////////////////////////////
	// toString
	///////////////////////////////////
	
	override public function toString():String {
		return "[bloom.style.default.DefaultWindowFooterContainerStyle]";
	}
}
}
