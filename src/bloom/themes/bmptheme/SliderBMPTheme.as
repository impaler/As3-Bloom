package bloom.themes.bmptheme {

import bloom.brushes.BMPBrush;
import bloom.core.ScaleBitmap;
import bloom.themes.ITheme;
import bloom.themes.ThemeBase;

import flash.display.Bitmap;
import flash.geom.Rectangle;

public class SliderBMPTheme implements ITheme {

	[Embed(source="../../assets/defaultBMP/slider/slider_bg_v.png")]
	private var slider_bg_v_normal:Class;
	private var slider_bg_v_normal_bit:Bitmap = new slider_bg_v_normal ();

	[Embed(source="../../assets/defaultBMP/slider/slider_bg_h.png")]
	private var slider_bg_h_normal:Class;
	private var slider_bg_h_normal_bit:Bitmap = new slider_bg_h_normal ();

	[Embed(source="../../assets/defaultBMP/slider/slider_button_normal.png")]
	private var slider_button_normal:Class;
	private var slider_button_normal_bit:Bitmap = new slider_button_normal ();

	[Embed(source="../../assets/defaultBMP/slider/slider_button_down.png")]
	private var slider_button_down:Class;
	private var slider_button_down_bit:Bitmap = new slider_button_down ();

	[Embed(source="../../assets/defaultBMP/slider/slider_button_over.png")]
	private var slider_button_over:Class;
	private var slider_button_over_bit:Bitmap = new slider_button_over ();

	public function initialize ():void {
		var data:Vector.<ScaleBitmap>;
		var scaleBMP0:ScaleBitmap;
		var scaleBMP1:ScaleBitmap;
		var scaleBMP2:ScaleBitmap;

		var NORMAL:int = 0;
		var OVER:int = 1;
		var DOWN:int = 2;

		scaleBMP0 = new ScaleBitmap ( slider_bg_h_normal_bit.bitmapData );
		scaleBMP0.scale9Grid = new Rectangle ( 16 , 13 , 86 , 3 );

		scaleBMP1 = new ScaleBitmap ( slider_bg_v_normal_bit.bitmapData );
		scaleBMP1.scale9Grid = new Rectangle ( 3 , 13 , 3 , 86 );

		data = new Vector.<ScaleBitmap> ( 2 , true );
		data[0] = scaleBMP0;
		data[1] = scaleBMP1;
		ThemeBase.Slider = new BMPBrush ( data );

		scaleBMP0 = new ScaleBitmap ( slider_button_normal_bit.bitmapData );
		scaleBMP0.scale9Grid = new Rectangle ( 2 , 2 , 1 , 1 );

		scaleBMP1 = new ScaleBitmap ( slider_button_over_bit.bitmapData );
		scaleBMP1.scale9Grid = new Rectangle ( 2 , 2 , 1 , 1 );

		scaleBMP2 = new ScaleBitmap ( slider_button_down_bit.bitmapData );
		scaleBMP2.scale9Grid = new Rectangle ( 2 , 2 , 1 , 1 );

		data = new Vector.<ScaleBitmap> ( 3 , true );
		data[NORMAL] = scaleBMP0;
		data[OVER] = scaleBMP1;
		data[DOWN] = scaleBMP2;
		ThemeBase.SliderButton = new BMPBrush ( data );

	}
}
}



