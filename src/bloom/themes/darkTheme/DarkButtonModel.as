package bloom.themes.darkTheme {

import bloom.brushes.ColorBrush;
import bloom.brushes.TextBrush;
import bloom.components.ButtonModel;
import bloom.core.Bloom;

public class DarkButtonModel extends ButtonModel {
	public function DarkButtonModel () {
		defaultWidth  = 200;
		defaultHeight  = 26;
		
		Text_Button = new TextBrush("Verdana", 12, 0xdcdcdc, false, false, false);
		Text_Button_Over = new TextBrush("Verdana", 13, 0xffffff, false, false, false);
		Text_Button_Down = new TextBrush("Verdana", 11, 0xffffff, false, false, false);
		
		var data = new Vector.<uint>(3, true);
		data[Bloom.NORM] = 0x000000;
		data[Bloom.OVER] = 0x474747;
		data[Bloom.DOWN] = 0x002200;
		brush = new ColorBrush(data);
	}
}
}
