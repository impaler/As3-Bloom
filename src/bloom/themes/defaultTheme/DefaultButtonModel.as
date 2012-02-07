package bloom.themes.defaultTheme {

import bloom.brushes.ColorBrush;
import bloom.brushes.TextBrush;
import bloom.components.ButtonModel;
import bloom.core.Bloom;

public class DefaultButtonModel extends ButtonModel {
	public function DefaultButtonModel () {
		defaultWidth = 120;
		defaultHeight = 26;

		Text_Button = new TextBrush ( "Verdana" , 12 , 0x66ffff , false , false , false );
		Text_Button_Over = new TextBrush ( "Verdana" , 13 , 0xffffff , false , false , false );
		Text_Button_Down = new TextBrush ( "Verdana" , 11 , 0x000000 , false , false , false );

		var data = new Vector.<uint> ( 3 , true );
		data[Bloom.NORM] = 0x3E3E72;
		data[Bloom.OVER] = 0x5E5EAC;
		data[Bloom.DOWN] = 0xF1BA44;
		brush = new ColorBrush ( data );
	}
}
}
