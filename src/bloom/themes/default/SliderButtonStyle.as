package bloom.themes.default {

import bloom.brush.ColorBrush;
import bloom.components.ButtonBase;

public class SliderButtonStyle extends ButtonStyle {
	
	public function SliderButtonStyle () {
		
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
		return "[bloom.themes.default.ButtonStyle]";
	}
	
}
}
