package bloom.themes.defaultTheme {

import bloom.brushes.TextBrush;
import bloom.components.LabelModel;

public class DefaultLabelModel extends LabelModel {

	public function DefaultLabelModel () {
		Text_Label = new TextBrush ( "Verdana" , 12 , 0x000000 , false , false , false );
	}
}
}
