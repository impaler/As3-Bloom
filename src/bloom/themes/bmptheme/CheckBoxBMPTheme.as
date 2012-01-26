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

/**
 * CheckBoxBMPTheme
 * 
 * @author impaler
 */
public class CheckBoxBMPTheme implements ITheme {

	[Embed(source="../../assets/defaultBMP/checkbox/checkbox_on.png")]
	private var checkbox_on:Class;

	[Embed(source="../../assets/defaultBMP/checkbox/checkbox_off.png")]
	private var checkbox_off:Class;

	public function initialize ():void {

		ThemeBase.Text_CheckBox = new TextBrush ( "Verdana" , 12 , 0x000000 , false , false , false );

		var data:Vector.<ScaleBitmap>;

		var OFF:int = 0;
		var ON:int = 1;

		data = new Vector.<ScaleBitmap> ( 2 , true );
		data[OFF] = new ScaleBitmap ( Bitmap ( new checkbox_off () ).bitmapData );
		data[ON] = new ScaleBitmap ( Bitmap ( new checkbox_on () ).bitmapData );
		ThemeBase.CheckBox = new BMPBrush ( data );

	}
}
}

