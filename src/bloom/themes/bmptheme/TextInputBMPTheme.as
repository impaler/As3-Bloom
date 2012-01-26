package bloom.themes.bmptheme {

import bloom.brushes.BMPBrush;
import bloom.brushes.TextBrush;
import bloom.core.ScaleBitmap;
import bloom.themes.ITheme;
import bloom.themes.ThemeBase;

import flash.display.Bitmap;
import flash.geom.Rectangle;

public class TextInputBMPTheme implements ITheme {

	[Embed(source="../../assets/defaultBMP/textbox/text_box_scroll_bg_normal.png")]
	private var text_box_bg_normal:Class;

	public function initialize ():void {

		ThemeBase.Text_TextInput = new TextBrush ( "Verdana" , 12 , 0x000000 , false , false , false );

		var data:Vector.<ScaleBitmap>;
		var scaleBMP0:ScaleBitmap;

		scaleBMP0 = new ScaleBitmap ( Bitmap ( new text_box_bg_normal () ).bitmapData );
		scaleBMP0.scale9Grid = new Rectangle ( 13 , 15 , 51 , 12 );

		data = new Vector.<ScaleBitmap> ( 1 , true );
		data[0] = scaleBMP0;
		ThemeBase.TextInput = new BMPBrush ( data );

	}
}
}



