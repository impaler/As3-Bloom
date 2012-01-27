/**
 * Copyright (c) 2012 - 2100 Sindney
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */
package bloom.themes.bmptheme {

import bloom.brushes.BMPBrush;
import bloom.brushes.TextBrush;
import bloom.core.ScaleBitmap;
import bloom.themes.ITheme;
import bloom.themes.ThemeBase;

import flash.display.Bitmap;
import flash.geom.Rectangle;

/**
 * ToggleButtonBMPTheme
 * 
 * @author impaler
 */
public class ToggleButtonBMPTheme implements ITheme {

	//TODO: can look a lot better both with clipping and image
	[Embed(source="../../assets/defaultBMP/toggle/toggle_bg_on.png")]
	private var toggle_bg_on:Class;

	[Embed(source="../../assets/defaultBMP/toggle/toggle_bg_off.png")]
	private var toggle_bg_off:Class;

	[Embed(source="../../assets/defaultBMP/toggle/toggle_button_off.png")]
	private var toggle_button_off:Class;

	[Embed(source="../../assets/defaultBMP/toggle/toggle_button_on.png")]
	private var toggle_button_on:Class;

	public function initialize ():void {

		ThemeBase.Text_ToggleButton = new TextBrush ( "Verdana" , 12 , 0xffffff , false , false , false );

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
