package bloom.themes.bmptheme {

import bloom.brushes.BMPBrush;
import bloom.brushes.ColorBrush;
import bloom.brushes.TextBrush;
import bloom.core.ScaleBitmap;
import bloom.themes.ITheme;
import bloom.themes.ThemeBase;

import flash.display.Bitmap;
import flash.geom.Rectangle;

public class TextBoxBMPTheme implements ITheme {

	[Embed(source="../../assets/defaultBMP/textbox/text_box_scroll_bg_normal.png")]
	private var text_box_bg_normal:Class;

	[Embed(source="../../assets/defaultBMP/textbox/textbox_scroll_button_normal.png")]
	private var button_normal:Class;

	[Embed(source="../../assets/defaultBMP/textbox/textbox_scroll_button_down.png")]
	private var button_down:Class;

	[Embed(source="../../assets/defaultBMP/textbox/textbox_scroll_button_over.png")]
	private var button_over:Class;

	public function initialize ():void {

		ThemeBase.Text_TextBox = new TextBrush ( "Verdana" , 12 , 0x000000 , false , false , false );

		var NORMAL:int = 0;
		var OVER:int = 1;
		var DOWN:int = 2;

		var data:Vector.<ScaleBitmap>;
		var scaleBMP0:ScaleBitmap;
		var scaleBMP1:ScaleBitmap;
		var scaleBMP2:ScaleBitmap;

		scaleBMP0 = new ScaleBitmap ( Bitmap ( new text_box_bg_normal () ).bitmapData );
		scaleBMP0.scale9Grid = new Rectangle ( 13 , 15 , 51 , 12 );

		data = new Vector.<ScaleBitmap> ( 1 , true );
		data[0] = scaleBMP0;
		ThemeBase.TextBox = new BMPBrush ( data );

		scaleBMP0 = new ScaleBitmap ( Bitmap ( new button_normal () ).bitmapData );
		scaleBMP0.scale9Grid = new Rectangle ( 7 , 7 , 2 , 2 );

		scaleBMP1 = new ScaleBitmap ( Bitmap ( new button_over () ).bitmapData );
		scaleBMP1.scale9Grid = new Rectangle ( 7 , 7 , 2 , 2 );

		scaleBMP2 = new ScaleBitmap ( Bitmap ( new button_down () ).bitmapData );
		scaleBMP2.scale9Grid = new Rectangle ( 7 , 7 , 2 , 2 );

		data = new Vector.<ScaleBitmap> ( 3 , true );
		data[NORMAL] = scaleBMP0;
		data[OVER] = scaleBMP1;
		data[DOWN] = scaleBMP2;
		ThemeBase.TB_ScrollBarButton = new BMPBrush ( data );

		var uint_data:Vector.<uint>;

		uint_data = new Vector.<uint> ( 1 , true );
		uint_data[0] = 0x222222;
		ThemeBase.TB_ScrollBar = new ColorBrush ( uint_data );

	}
}
}



