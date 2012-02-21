package bloom.themes.defaultTheme {

import bloom.brush.ColorBrush;
import bloom.components.Form;
import bloom.style.FormStyle;

public class DefaultFormStyle extends FormStyle {
	
	public function DefaultFormStyle () {
		
		var data:Vector.<uint> = new Vector.<uint> ( 1 , true );
		data[Form.NORMAL] = 0x666983;
		backgroundBrush = new ColorBrush( data );
		
		formItemStyle = new DefaultFormItemStyle();
		scrollBar = new DefaultSliderStyle();
		
	}
	
	///////////////////////////////////
	// toString
	///////////////////////////////////
	
	override public function toString():String {
		return "[bloom.style.default.DefaultFormStyle]";
	}
	
}
}
