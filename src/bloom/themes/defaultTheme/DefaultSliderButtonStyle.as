package bloom.themes.defaultTheme {

import bloom.brush.ColorBrush;
import bloom.components.ButtonBase;
import bloom.style.*;

public class DefaultSliderButtonStyle extends ButtonBaseStyle {
	
	public function DefaultSliderButtonStyle () {
		
		var data:Vector.<uint> = new Vector.<uint> ( 3 , true );
		data[ButtonBase.NORMAL] = 0x6666ff;
		data[ButtonBase.OVER] = 0x6699ff;
		data[ButtonBase.DOWN] = 0x9ee6ff;
		backgroundBrush = new ColorBrush( data );
		
	}
	
	///////////////////////////////////
	// toString
	///////////////////////////////////
	
	override public function toString():String {
		return "[bloom.style.default.DefaultSliderButtonStyle]";
	}
	
}
}
