package bloom.themes.bmptheme {

import bloom.brushes.TextBrush;
import bloom.themes.ITheme;
import bloom.themes.ThemeBase;

public class LabelBMPTheme implements ITheme {

	public function initialize ():void {

		ThemeBase.Text_Label = new TextBrush ( "Verdana" , 12 , 0x000000 , false , false , false );

	}
}
}
