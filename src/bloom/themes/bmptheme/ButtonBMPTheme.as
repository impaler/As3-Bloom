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
 * ButtonBMPTheme
 * 
 * @author impaler
 */
public class ButtonBMPTheme implements ITheme {

	[Embed(source="../../assets/defaultBMP/buttons/button_normal.png")]
	private var button_normal:Class;

	[Embed(source="../../assets/defaultBMP/buttons/button_down.png")]
	private var button_down:Class;

	[Embed(source="../../assets/defaultBMP/buttons/button_over.png")]
	private var button_over:Class;

	public function initialize ():void {

		ThemeBase.Text_Button = new TextBrush ( "Verdana" , 12 , 0xffffff , false , false , false );
		ThemeBase.Text_Button_Over = new TextBrush ( "Verdana" , 12 , 0xffffff , false , false , false );
		ThemeBase.Text_Button_Down = new TextBrush ( "Verdana" , 12 , 0x000000 , false , false , false );

		var data:Vector.<ScaleBitmap>;
		var scaleBMP0:ScaleBitmap;
		var scaleBMP1:ScaleBitmap;
		var scaleBMP2:ScaleBitmap;

		var NORMAL:int = 0;
		var OVER:int = 1;
		var DOWN:int = 2;

		scaleBMP0 = new ScaleBitmap ( Bitmap ( new button_normal () ).bitmapData );
		scaleBMP0.scale9Grid = new Rectangle ( 15 , 15 , 70 , 14 );

		scaleBMP1 = new ScaleBitmap ( Bitmap ( new button_over () ).bitmapData );
		scaleBMP1.scale9Grid = new Rectangle ( 15 , 15 , 70 , 14 );

		scaleBMP2 = new ScaleBitmap ( Bitmap ( new button_down () ).bitmapData );
		scaleBMP2.scale9Grid = new Rectangle ( 15 , 15 , 70 , 14 );

		data = new Vector.<ScaleBitmap> ( 3 , true );
		data[NORMAL] = scaleBMP0;
		data[OVER] = scaleBMP1;
		data[DOWN] = scaleBMP2;
		ThemeBase.Button = new BMPBrush ( data );
	}
}
}
