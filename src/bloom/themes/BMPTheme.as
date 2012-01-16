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
package bloom.themes 
{
	import flash.display.Bitmap;
	import flash.geom.Rectangle;
	
	import bloom.brushes.BMPBrush;
	import bloom.brushes.TextBrush;
	import bloom.core.ScaleBitmap;
	
	/**
	 * BMDTheme
	 * 
	 * @date 2012/1/15 21:46
	 * @author impaler
	 */
	public class BMPTheme implements ITheme {
		
		// button
		[Embed(source="../assets/default/button_normal.png")]
		private var button_normal:Class;
		private var button_normal_bit:Bitmap = new button_normal();
		
		[Embed(source="../assets/default/button_down.png")]
		private var button_down:Class;
		private var button_down_bit:Bitmap = new button_down();
		
		[Embed(source="../assets/default/button_over.png")]
		private var button_over:Class;
		private var button_over_bit:Bitmap = new button_over();
		
		// slider
		[Embed(source="../assets/default/slider_bg_v.png")]
		private var slider_bg_v_normal:Class;
		private var slider_bg_v_normal_bit:Bitmap = new slider_bg_v_normal();
		
        [Embed(source="../assets/default/slider_bg_h.png")]
        private var slider_bg_h_normal:Class;
        private var slider_bg_h_normal_bit:Bitmap = new slider_bg_h_normal();
		
		[Embed(source="../assets/default/slider_button_normal.png")]
		private var slider_button_normal:Class;
		private var slider_button_normal_bit:Bitmap = new slider_button_normal();
		
		[Embed(source="../assets/default/slider_button_down.png")]
		private var slider_button_down:Class;
		private var slider_button_down_bit:Bitmap = new slider_button_down();
		
		[Embed(source="../assets/default/slider_button_over.png")]
		private var slider_button_over:Class;
		private var slider_button_over_bit:Bitmap = new slider_button_over();
		
		// Numeric Stepper
        [Embed(source="../assets/default/ns_bg_normal.png")]
        private var ns_bg_normal:Class;
        private var ns_bg_normal_bit:Bitmap = new ns_bg_normal();
		
        [Embed(source="../assets/default/ns_bg_active.png")]
        private var ns_bg_active:Class;
        private var ns_bg_active_bit:Bitmap = new ns_bg_active();
		
        // Numeric Stepper Buttons
        [Embed(source="../assets/default/ns_decrease_button_normal.png")]
        private var ns_decrease_button_normal:Class;
        private var ns_decrease_button_normal_bit:Bitmap = new ns_decrease_button_normal();
		
        [Embed(source="../assets/default/ns_decrease_button_over.png")]
        private var ns_decrease_button_over:Class;
        private var ns_decrease_button_over_bit:Bitmap = new ns_decrease_button_over();
		
        [Embed(source="../assets/default/ns_decrease_button_down.png")]
        private var ns_decrease_button_down:Class;
        private var ns_decrease_button_down_bit:Bitmap = new ns_decrease_button_down();
        
        [Embed(source="../assets/default/ns_increase_button_normal.png")]
        private var ns_increase_button_normal:Class;
        private var ns_increase_button_normal_bit:Bitmap = new ns_increase_button_normal();
		
        [Embed(source="../assets/default/ns_increase_button_over.png")]
        private var ns_increase_button_over:Class;
        private var ns_increase_button_over_bit:Bitmap = new ns_increase_button_over();
		
        [Embed(source="../assets/default/ns_increase_button_down.png")]
        private var ns_increase_button_down:Class;
        private var ns_increase_button_down_bit:Bitmap = new ns_increase_button_down();
		
		public function BMPTheme() {
			
		}
		
		public function initialize():void {
			ThemeBase.Text_Button = new TextBrush ("Verdana" , 12 , 0xffffff , false , false , false);
            ThemeBase.Text_NumericStepper = new TextBrush("Verdana", 20, 0x000000, false, false, false);
			
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
        	ThemeBase.Button = new BMPBrush ( bit_data );
        	
        	// Slider
        	var slider_bg_h:ScaleBitmap = new ScaleBitmap( slider_bg_h_normal_bit.bitmapData );
            slider_bg_h.scale9Grid =  new Rectangle( 16, 13, 86, 3 );
			
            var slider_bg_v:ScaleBitmap = new ScaleBitmap( slider_bg_v_normal_bit.bitmapData );
            slider_bg_v.scale9Grid =  new Rectangle( 3, 13, 3, 86 );
			
        	bit_data = new Vector.<ScaleBitmap> ( 2 , true );
        	bit_data[0] = slider_bg_h;
        	bit_data[1] = slider_bg_v;
        	ThemeBase.Slider = new BMPBrush ( bit_data );
        	
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
        	ThemeBase.SliderButton = new BMPBrush ( bit_data );
			
			// NumericStepper
            var ns_bg_normal_bit_scale:ScaleBitmap = new ScaleBitmap( ns_bg_normal_bit.bitmapData );
            ns_bg_normal_bit_scale.scale9Grid =  new Rectangle( 13, 15, 51, 12 );
			
            var ns_bg_active_bit_scale:ScaleBitmap = new ScaleBitmap( ns_bg_active_bit.bitmapData );
            ns_bg_active_bit_scale.scale9Grid =  new Rectangle( 13, 15, 51, 12 );
			
            bit_data = new Vector.<ScaleBitmap> ( 2 , true );
           	bit_data[0] = ns_bg_normal_bit_scale;
           	bit_data[1] = ns_bg_active_bit_scale;
           	ThemeBase.NumericStepper = new BMPBrush ( bit_data );
			
			// NS_Buttons
            var ns_decrease_button_normal_scale:ScaleBitmap = new ScaleBitmap( ns_decrease_button_normal_bit.bitmapData );
            ns_decrease_button_normal_scale.scale9Grid =  new Rectangle( 2, 2, 1, 1 );
			
           	var ns_decrease_button_down_scale:ScaleBitmap = new ScaleBitmap( ns_decrease_button_down_bit.bitmapData );
           	ns_decrease_button_down_scale.scale9Grid =  new Rectangle( 2, 2, 1, 1 );
			
           	var ns_decrease_button_over_scale:ScaleBitmap = new ScaleBitmap( ns_decrease_button_over_bit.bitmapData );
           	ns_decrease_button_over_scale.scale9Grid =  new Rectangle( 2, 2, 1, 1 );
			
           	bit_data = new Vector.<ScaleBitmap> ( 3 , true );
           	bit_data[0] = ns_decrease_button_normal_scale;
           	bit_data[1] = ns_decrease_button_over_scale;
           	bit_data[2] = ns_decrease_button_down_scale;
           	ThemeBase.NS_Decrease = new BMPBrush ( bit_data );
			
            var ns_increase_button_normal_scale:ScaleBitmap = new ScaleBitmap( ns_increase_button_normal_bit.bitmapData );
            ns_increase_button_normal_scale.scale9Grid =  new Rectangle( 2, 2, 1, 1 );
			
           	var ns_increase_button_down_scale:ScaleBitmap = new ScaleBitmap( ns_increase_button_down_bit.bitmapData );
           	ns_increase_button_down_scale.scale9Grid =  new Rectangle( 2, 2, 1, 1 );
			
           	var ns_increase_button_over_scale:ScaleBitmap = new ScaleBitmap( ns_increase_button_over_bit.bitmapData );
           	ns_increase_button_over_scale.scale9Grid =  new Rectangle( 2, 2, 1, 1 );
			
           	bit_data = new Vector.<ScaleBitmap> ( 3 , true );
           	bit_data[0] = ns_increase_button_normal_scale;
           	bit_data[1] = ns_increase_button_over_scale;
           	bit_data[2] = ns_increase_button_down_scale;
           	ThemeBase.NS_Increase = new BMPBrush ( bit_data );
		}
		
	}

}