package bloom.themes.bmptheme {

import bloom.brushes.BMPBrush;
import bloom.brushes.ColorBrush;
import bloom.brushes.TextBrush;
import bloom.core.ScaleBitmap;
import bloom.themes.ITheme;
import bloom.themes.ThemeBase;

import flash.display.Bitmap;
import flash.geom.Rectangle;

public class TabsBMPTheme implements ITheme {

	[Embed(source="../../assets/defaultBMP/tabs/tabs_bg_normal.png")]
	private var tabs:Class;

	[Embed(source="../../assets/defaultBMP/tabs/tabs_bg_down.png")]
	private var tabs_down:Class;

	public function initialize ():void {

		ThemeBase.Text_TabBox = new TextBrush ( "Verdana" , 12 , 0x000000 , false , false , false );

		var data:Vector.<ScaleBitmap>;
		var scaleBMP0:ScaleBitmap;
		var scaleBMP1:ScaleBitmap;

		var NORMAL:int = 0;
		var DOWN:int = 1;

		scaleBMP0 = new ScaleBitmap ( Bitmap ( new tabs () ).bitmapData );
		scaleBMP0.scale9Grid = new Rectangle ( 11 , 12 , 1 , 2 );

		scaleBMP1 = new ScaleBitmap ( Bitmap ( new tabs_down () ).bitmapData );
		scaleBMP1.scale9Grid = new Rectangle ( 11 , 12 , 1 , 2 );

		data = new Vector.<ScaleBitmap> ( 2 , true );
		data[NORMAL] = scaleBMP0;
		data[DOWN] = scaleBMP1;
		ThemeBase.TabBox_Title = new BMPBrush ( data );

		var uint_data:Vector.<uint>;

		uint_data = new Vector.<uint> ( 1 , true );
		uint_data[0] = 0x666666;
		ThemeBase.TabBox = new ColorBrush ( uint_data );

	}
}
}
