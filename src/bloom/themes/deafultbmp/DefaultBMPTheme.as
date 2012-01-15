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
package bloom.themes.deafultbmp {

import bloom.brushes.BMDBrush;
import bloom.brushes.TextBrush;
import bloom.core.*;

import flash.display.Bitmap;
import flash.geom.Rectangle;

public class DefaultBMPTheme extends ThemeDefault {

    /**
     * Bloom example BMPBrush Theme
     *
     * @date 2012/1/13 10:34
     * @author impaler
     */

    [Embed(source="images/button_normal.png")]
    private var button_normal:Class;
    private var button_normal_bit:Bitmap = new button_normal();

    [Embed(source="images/button_down.png")]
    private var button_down:Class;
    private var button_down_bit:Bitmap = new button_down();

    [Embed(source="images/button_over.png")]
    private var button_over:Class;
    private var button_over_bit:Bitmap = new button_over();

    [Embed(source="images/slider_bg.png")]
    private var slider_bg_normal:Class;
    private var slider_bg_normal_bit:Bitmap = new slider_bg_normal();

    [Embed(source="images/slider_button_normal.png")]
    private var slider_button_normal:Class;
    private var slider_button_normal_bit:Bitmap = new slider_button_normal();

    [Embed(source="images/slider_button_down.png")]
    private var slider_button_down:Class;
    private var slider_button_down_bit:Bitmap = new slider_button_down();

    [Embed(source="images/slider_button_over.png")]
    private var slider_button_over:Class;
    private var slider_button_over_bit:Bitmap = new slider_button_over();

    public function DefaultBMPTheme () {

    }

    override public function initialize ():void {
        // TextBrushes
        ThemeBase.Text_Button = new TextBrush ( "Verdana" , 12 , 0xffffff , false , false , false );

        // Button
        var normal:ScaleBitmap = new ScaleBitmap( button_normal_bit.bitmapData );
        normal.scale9Grid =  new Rectangle( 15, 15, 70, 14 );

        var down:ScaleBitmap = new ScaleBitmap( button_down_bit.bitmapData );
        down.scale9Grid =  new Rectangle( 15, 15, 70, 14 );

        var over:ScaleBitmap = new ScaleBitmap( button_over_bit.bitmapData );
        over.scale9Grid =  new Rectangle( 15, 15, 70, 14 );

        var bit_data:Vector.<ScaleBitmap> = new Vector.<ScaleBitmap>(3, true);
        bit_data[0] =  normal;
        bit_data[1] =  over;
        bit_data[2] =  down;
        ThemeBase.Button = new BMDBrush ( bit_data );

        // Slider
        var slider_bg:ScaleBitmap = new ScaleBitmap( slider_bg_normal_bit.bitmapData );
        slider_bg.scale9Grid =  new Rectangle( 16, 13, 86, 3 );

        bit_data = new Vector.<ScaleBitmap> ( 1 , true );
        bit_data[0] = slider_bg;
        ThemeBase.Slider = new BMDBrush ( bit_data );

        // Slider Button
        var slider_button_normal_scale:ScaleBitmap = new ScaleBitmap( slider_button_normal_bit.bitmapData );
        slider_button_normal_scale.scale9Grid =  new Rectangle( 2, 2, 1, 1 );

        var slider_button_down_scale:ScaleBitmap = new ScaleBitmap( slider_button_down_bit.bitmapData );
        slider_button_down_scale.scale9Grid =  new Rectangle( 2, 2, 1, 1 );

        var slider_button_over_scale:ScaleBitmap = new ScaleBitmap( slider_button_over_bit.bitmapData );
        slider_button_over_scale.scale9Grid =  new Rectangle( 2, 2, 1, 1 );

        bit_data = new Vector.<ScaleBitmap> ( 3 , true );
        bit_data[0] = slider_button_normal_scale;
        bit_data[1] = slider_button_over_scale;
        bit_data[2] = slider_button_down_scale;
        ThemeBase.SliderButton = new BMDBrush ( bit_data );

    }
}
}
