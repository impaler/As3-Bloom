package bloom.themes.defaultTheme {

import bloom.brushes.ColorBrush;
import bloom.brushes.TextBrush;
import bloom.containers.WindowModel;

public class DefaultWindowModel extends WindowModel {

	public function DefaultWindowModel () {

		resizeable = true;
		liveResize = true;
		moveable = true;
		
		headerHeight = 30;
		footerHeight = 30;

		defaultWidth = 400;
		defaultHeight = 400;

		minHeight = 100;
		maxHeight = 1000;

		minWidth = 100;
		maxWidth = 1000;

		var data = new Vector.<uint> ( 3 , true );
		data = new Vector.<uint> ( 2 , true );
		data[0] = 0x000000;
		data[1] = 0x3E3E50;
		brush = new ColorBrush ( data );

		data = new Vector.<uint> ( 1 , true );
		data[0] = 0x3E3E50;
		Window_Header = new ColorBrush ( data );

		data = new Vector.<uint> ( 1 , true );
		data[0] = 0xB4B4B4;
		Window_Footer = new ColorBrush ( data );
		
		
		title = new TextBrush ( "Verdana" , 12 , 0xffffff , false , false , false );

	}
}
}
