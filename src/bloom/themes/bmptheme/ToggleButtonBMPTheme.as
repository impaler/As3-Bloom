package bloom.themes.bmptheme {

import bloom.brushes.BMPBrush;
import bloom.brushes.TextBrush;
import bloom.core.ScaleBitmap;
import bloom.themes.ITheme;
import bloom.themes.ThemeBase;

import flash.display.Bitmap;
import flash.geom.Rectangle;

public class ToggleButtonBMPTheme implements ITheme {

	//todo can look a lot better both with clipping and image
	[Embed(source="../../assets/defaultBMP/toggle/toggle_bg_on.png")]
	private var toggle_bg_on:Class;

	[Embed(source="../../assets/defaultBMP/toggle/toggle_bg_off.png")]
	private var toggle_bg_off:Class;

	[Embed(source="../../assets/defaultBMP/toggle/toggle_button_off.png")]
	private var toggle_button_off:Class;

	[Embed(source="../../assets/defaultBMP/toggle/toggle_button_on.png")]
	private var toggle_button_on:Class;

	public function initialize ():void {

		ThemeBase.Text_Button = new TextBrush ( "Verdana" , 12 , 0xffffff , false , false , false );

		var data:Vector.<ScaleBitmap>;
		var scaleBMP0:ScaleBitmap;
		var scaleBMP1:ScaleBitmap;
		var scaleBMP2:ScaleBitmap;

		var BUTTON:int = 0;
		var ONBG:int = 1;
		var OFFBG:int = 2;

		scaleBMP0 = new ScaleBitmap ( Bitmap ( new toggle_button_off () ).bitmapData );
		scaleBMP0.scale9Grid = new Rectangle ( 7 , 7 , 2 , 2 );

		scaleBMP1 = new ScaleBitmap ( Bitmap ( new toggle_bg_on () ).bitmapData );
		scaleBMP1.scale9Grid = new Rectangle ( 7 , 7 , 2 , 2 );

		scaleBMP2 = new ScaleBitmap ( Bitmap ( new toggle_bg_off () ).bitmapData );
		scaleBMP2.scale9Grid = new Rectangle ( 7 , 7 , 2 , 2 );

		data = new Vector.<ScaleBitmap> ( 3 , true );
		data[BUTTON] = scaleBMP0;
		data[ONBG] = scaleBMP2;
		data[OFFBG] = scaleBMP1;
		ThemeBase.ToggleSwitcher = new BMPBrush ( data );

		ThemeBase.Text_ToggleButton = new TextBrush ( "Verdana" , 12 , 0xffffff , false , false , false );

		var OFF:int = 0;
		var ON:int = 1;

		scaleBMP0 = new ScaleBitmap ( Bitmap ( new toggle_button_on () ).bitmapData );
		scaleBMP0.scale9Grid = new Rectangle ( 7 , 7 , 2 , 2 );

		scaleBMP1 = new ScaleBitmap ( Bitmap ( new toggle_button_off () ).bitmapData );
		scaleBMP1.scale9Grid = new Rectangle ( 7 , 7 , 2 , 2 );

		data = new Vector.<ScaleBitmap> ( 2 , true );
		data[OFF] = scaleBMP0;
		data[ON] = scaleBMP1;
		ThemeBase.ToggleButton = new BMPBrush ( data );

	}
}
}
