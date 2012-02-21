package bloom.themes.defaultTheme {

import bloom.brush.ColorBrush;
import bloom.components.FormItem;
import bloom.style.FormItemStyle;

public class DefaultFormItemStyle extends FormItemStyle {
	
	public function DefaultFormItemStyle () {
		
		var data:Vector.<uint> = new Vector.<uint> ( 2 , true );
		data[FormItem.NORMAL] = 0xffff11;
		data[FormItem.SELECTED] = 0x000000;
		backgroundBrush = new ColorBrush( data );
	}
	
}
}
