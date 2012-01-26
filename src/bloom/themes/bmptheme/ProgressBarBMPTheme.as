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
import bloom.core.ScaleBitmap;
import bloom.themes.ITheme;
import bloom.themes.ThemeBase;

import flash.display.Bitmap;
import flash.geom.Rectangle;

/**
 * ProgressBarBMPTheme
 * 
 * @author impaler
 */
public class ProgressBarBMPTheme implements ITheme {
	[Embed(source="../../assets/defaultBMP/progressbar/progress_bg.png")]
	private var progress_bg:Class;

	[Embed(source="../../assets/defaultBMP/progressbar/progress_bar.png")]
	private var progress_bar:Class;

	public function initialize ():void {
		var data:Vector.<ScaleBitmap>;
		var scaleBMP0:ScaleBitmap;
		var scaleBMP1:ScaleBitmap;

		scaleBMP0 = new ScaleBitmap ( Bitmap ( new progress_bg () ).bitmapData );
		scaleBMP0.scale9Grid = new Rectangle ( 7 , 7 , 2 , 2 );

		scaleBMP1 = new ScaleBitmap ( Bitmap ( new progress_bar () ).bitmapData );
		scaleBMP1.scale9Grid = new Rectangle ( 7 , 7 , 2 , 2 );

		data = new Vector.<ScaleBitmap> ( 2 , true );
		data[0] = scaleBMP0;
		data[1] = scaleBMP1;
		ThemeBase.ProgressBar = new BMPBrush ( data );
	}
}
}






