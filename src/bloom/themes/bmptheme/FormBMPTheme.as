package bloom.themes.bmptheme {

import bloom.brushes.BMPBrush;
import bloom.brushes.ColorBrush;
import bloom.core.ScaleBitmap;
import bloom.themes.ITheme;
import bloom.themes.ThemeBase;

import flash.display.Bitmap;
import flash.geom.Rectangle;

public class FormBMPTheme implements ITheme {

	[Embed(source="../../assets/defaultBMP/form/form_scroll_bg.png")]
	private var form_scroll_bg:Class;

	[Embed(source="../../assets/defaultBMP/form/form_scroll_button_bg.png")]
	private var form_scroll_button_bg:Class;

	[Embed(source="../../assets/defaultBMP/form/form_button_normal.png")]
	private var form_button_normal:Class;

	[Embed(source="../../assets/defaultBMP/form/form_button_over.png")]
	private var form_button_over:Class;

	[Embed(source="../../assets/defaultBMP/form/form_button_down.png")]
	private var form_button_down:Class;

	public function initialize ():void {

		var data:Vector.<ScaleBitmap>;
		var scaleBMP0:ScaleBitmap;
		var scaleBMP1:ScaleBitmap;
		var scaleBMP2:ScaleBitmap;

		var NORMAL:int = 0;
		var OVER:int = 1;
		var DOWN:int = 2;

		scaleBMP0 = new ScaleBitmap ( Bitmap ( new form_button_normal () ).bitmapData );
		scaleBMP0.scale9Grid = new Rectangle ( 2 , 2 , 1 , 1 );

		scaleBMP1 = new ScaleBitmap ( Bitmap ( new form_button_over () ).bitmapData );
		scaleBMP1.scale9Grid = new Rectangle ( 2 , 2 , 1 , 1 );

		scaleBMP2 = new ScaleBitmap ( Bitmap ( new form_button_down () ).bitmapData );
		scaleBMP2.scale9Grid = new Rectangle ( 2 , 2 , 1 , 1 );

		data = new Vector.<ScaleBitmap> ( 3 , true );
		data[NORMAL] = scaleBMP0;
		data[OVER] = scaleBMP1;
		data[DOWN] = scaleBMP2;
		ThemeBase.Form_ScrollBarButton = new BMPBrush ( data );

		scaleBMP0 = new ScaleBitmap ( Bitmap ( new form_scroll_bg () ).bitmapData );
		scaleBMP0.scale9Grid = new Rectangle ( 7 , 7 , 2 , 2 );

		data = new Vector.<ScaleBitmap> ( 2 , true );
		data[0] = scaleBMP0;
		//todo bug when only one property
		data[1] = scaleBMP0;
		ThemeBase.Form_ScrollBar = new BMPBrush ( data );

		var uint_data:Vector.<uint>;

		uint_data = new Vector.<uint> ( 1 , true );
		uint_data[0] = 0x666666;
		ThemeBase.Form = new ColorBrush ( uint_data );

		uint_data = new Vector.<uint> ( 2 , true );
		uint_data[0] = 0xF1BA44;
		uint_data[1] = 0xffffff;
		ThemeBase.FormItem = new ColorBrush ( uint_data );

	}
}
}
