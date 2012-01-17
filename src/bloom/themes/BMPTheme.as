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
		
		// checkBox
		[Embed(source="../assets/default/checkbox_on.png")]
		private var checkbox_on:Class;
		private var checkbox_on_bit:Bitmap = new checkbox_on();
		
		[Embed(source="../assets/default/checkbox_off.png")]
		private var checkbox_off:Class;
		private var checkbox_off_bit:Bitmap = new checkbox_off();
		
		// progressBar
		[Embed(source="../assets/default/progress_bg.png")]
		private var progress_bg:Class;
		private var progress_bg_bit:Bitmap = new progress_bg();
		
		[Embed(source="../assets/default/progress_bar.png")]
		private var progress_bar:Class;
		private var progress_bar_bit:Bitmap = new progress_bar();
		
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
			ThemeBase.Text_Button = new TextBrush("Verdana", 14, 0xffffff, true, false, false);
			ThemeBase.Text_CheckBox = new TextBrush("Verdana", 14, 0x000000, true, false, false);
			ThemeBase.Text_Label = new TextBrush("Verdana", 12, 0x000000, false, false, false);
			ThemeBase.Text_List = new TextBrush("Verdana", 12, 0x000000, false, false, false);
			ThemeBase.Text_NumericStepper = new TextBrush("Verdana", 20, 0x000000, false, false, false);
			ThemeBase.Text_TextBox = new TextBrush("Verdana", 12, 0xffffff, false, false, false);
			ThemeBase.Text_TextInput = new TextBrush("Verdana", 12, 0xffffff, false, false, false);
			ThemeBase.Text_ToggleButton = new TextBrush("Verdana", 12, 0xffffff, false, false, false);
			
			var scaleBMP0:ScaleBitmap;
			var scaleBMP1:ScaleBitmap;
			var scaleBMP2:ScaleBitmap;
			
			var data:Vector.<ScaleBitmap>
			
        	// Button
        	scaleBMP0 = new ScaleBitmap(button_normal_bit.bitmapData);
        	scaleBMP0.scale9Grid = new Rectangle(15, 15, 70, 14);
        	
        	scaleBMP1 = new ScaleBitmap(button_over_bit.bitmapData);
        	scaleBMP1.scale9Grid = new Rectangle(15, 15, 70, 14);
        	
        	scaleBMP2 = new ScaleBitmap(button_down_bit.bitmapData);
        	scaleBMP2.scale9Grid = new Rectangle(15, 15, 70, 14);
        	
        	data = new Vector.<ScaleBitmap>(3, true);
        	data[0] = scaleBMP0;
        	data[1] = scaleBMP1;
        	data[2] = scaleBMP2;
        	ThemeBase.Button = new BMPBrush(data);
        	
			// CheckBox
			data = new Vector.<ScaleBitmap>(2, true);
			data[0] = new ScaleBitmap(checkbox_on_bit.bitmapData);
        	data[1] = new ScaleBitmap(checkbox_off_bit.bitmapData);
        	ThemeBase.CheckBox = new BMPBrush(data);
			
			// ProgressBar
			scaleBMP0 = new ScaleBitmap(progress_bg_bit.bitmapData);
			scaleBMP0.scale9Grid = new Rectangle(7, 7, 2, 2);
			
			scaleBMP1 = new ScaleBitmap(progress_bar_bit.bitmapData);
			scaleBMP1.scale9Grid = new Rectangle(7, 7, 2, 2);
			
			data = new Vector.<ScaleBitmap>(2, true);
			data[0] = scaleBMP0;
			data[1] = scaleBMP1;
			ThemeBase.ProgressBar = new BMPBrush(data);
			
        	// Slider
        	scaleBMP0 = new ScaleBitmap(slider_bg_h_normal_bit.bitmapData);
            scaleBMP0.scale9Grid = new Rectangle(16, 13, 86, 3);
			
            scaleBMP1 = new ScaleBitmap(slider_bg_v_normal_bit.bitmapData);
            scaleBMP1.scale9Grid = new Rectangle(3, 13, 3, 86);
			
        	data = new Vector.<ScaleBitmap>(2, true);
        	data[0] = scaleBMP0;
        	data[1] = scaleBMP1;
        	ThemeBase.Slider = new BMPBrush (data);
        	
        	// Slider Button
        	scaleBMP0 = new ScaleBitmap(slider_button_normal_bit.bitmapData);
        	scaleBMP0.scale9Grid = new Rectangle(2, 2, 1, 1);
        	
        	scaleBMP1 = new ScaleBitmap(slider_button_over_bit.bitmapData);
        	scaleBMP1.scale9Grid = new Rectangle(2, 2, 1, 1);
        	
        	scaleBMP2 = new ScaleBitmap(slider_button_down_bit.bitmapData);
        	scaleBMP2.scale9Grid = new Rectangle(2, 2, 1, 1);
        	
        	data = new Vector.<ScaleBitmap>(3, true);
        	data[0] = scaleBMP0;
        	data[1] = scaleBMP1;
        	data[2] = scaleBMP2;
        	ThemeBase.SliderButton = new BMPBrush(data);
			
			// NumericStepper
            scaleBMP0 = new ScaleBitmap(ns_bg_normal_bit.bitmapData);
            scaleBMP0.scale9Grid = new Rectangle(13, 15, 51, 12);
			
            scaleBMP1 = new ScaleBitmap(ns_bg_active_bit.bitmapData);
            scaleBMP1.scale9Grid = new Rectangle(13, 15, 51, 12);
			
            data = new Vector.<ScaleBitmap>(2, true);
           	data[0] = scaleBMP0;
           	data[1] = scaleBMP1;
           	ThemeBase.NumericStepper = new BMPBrush (data);
			
			// NS_Buttons
            scaleBMP0 = new ScaleBitmap(ns_decrease_button_normal_bit.bitmapData);
            scaleBMP0.scale9Grid = new Rectangle(2, 2, 13, 4);

           	scaleBMP1 = new ScaleBitmap(ns_decrease_button_down_bit.bitmapData);
           	scaleBMP1.scale9Grid = new Rectangle(2, 2, 13, 4);
			
           	scaleBMP2 = new ScaleBitmap(ns_decrease_button_over_bit.bitmapData);
           	scaleBMP2.scale9Grid = new Rectangle(2, 2, 13, 4);
			
           	data = new Vector.<ScaleBitmap>(3, true);
           	data[0] = scaleBMP0;
           	data[1] = scaleBMP2;
           	data[2] = scaleBMP1;
           	ThemeBase.NS_Decrease = new BMPBrush (data);
			
            scaleBMP0 = new ScaleBitmap(ns_increase_button_normal_bit.bitmapData);
            scaleBMP0.scale9Grid = new Rectangle(2, 4, 13, 4);

           	scaleBMP1 = new ScaleBitmap(ns_increase_button_down_bit.bitmapData);
           	scaleBMP1.scale9Grid = new Rectangle(2, 4, 13, 4);
			
           	scaleBMP2 = new ScaleBitmap(ns_increase_button_over_bit.bitmapData);
           	scaleBMP2.scale9Grid = new Rectangle(2, 4, 13, 4);
			
           	data = new Vector.<ScaleBitmap> (3, true);
           	data[0] = scaleBMP0;
           	data[1] = scaleBMP2;
           	data[2] = scaleBMP1;
           	ThemeBase.NS_Increase = new BMPBrush (data);
		}
		
	}

}
