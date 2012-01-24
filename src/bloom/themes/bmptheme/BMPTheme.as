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

import bloom.themes.*;

import bloom.brushes.BMPBrush;
import bloom.brushes.ColorBrush;
import bloom.brushes.TextBrush;
import bloom.core.ScaleBitmap;

import flash.display.Bitmap;
import flash.geom.Rectangle;

/**
 * BMDTheme
 *
 * @date 2012/1/15 21:46
 * @author impaler
 */
public class BMPTheme implements ITheme {
	// progressBar
	[Embed(source="../../assets/defaultBMP/progress_bg.png")]
	private var progress_bg:Class;
	private var progress_bg_bit:Bitmap = new progress_bg ();

	[Embed(source="../../assets/defaultBMP/progress_bar.png")]
	private var progress_bar:Class;
	private var progress_bar_bit:Bitmap = new progress_bar ();

	// scrollbar
	[Embed(source="../../assets/defaultBMP/scroll_bar_bg_h.png")]
	private var scroll_bar_bg_h:Class;
	private var scroll_bar_bg_h_bit:Bitmap = new scroll_bar_bg_h ();

	[Embed(source="../../assets/defaultBMP/scroll_bar_bg_v.png")]
	private var scroll_bar_bg_v:Class;
	private var scroll_bar_bg_v_bit:Bitmap = new scroll_bar_bg_v ();

	[Embed(source="../../assets/defaultBMP/scroll_button_down.png")]
	private var scroll_button_down:Class;
	private var scroll_button_down_bit:Bitmap = new scroll_button_down ();

	[Embed(source="../../assets/defaultBMP/scroll_button_normal.png")]
	private var scroll_button_normal:Class;
	private var scroll_button_normal_bit:Bitmap = new scroll_button_normal ();

	[Embed(source="../../assets/defaultBMP/scroll_button_over.png")]
	private var scroll_button_over:Class;
	private var scroll_button_over_bit:Bitmap = new scroll_button_over ();

	// Slider
	[Embed(source="../../assets/defaultBMP/slider_bg_v.png")]
	private var slider_bg_v_normal:Class;
	private var slider_bg_v_normal_bit:Bitmap = new slider_bg_v_normal ();

	[Embed(source="../../assets/defaultBMP/slider_bg_h.png")]
	private var slider_bg_h_normal:Class;
	private var slider_bg_h_normal_bit:Bitmap = new slider_bg_h_normal ();

	[Embed(source="../../assets/defaultBMP/slider_button_normal.png")]
	private var slider_button_normal:Class;
	private var slider_button_normal_bit:Bitmap = new slider_button_normal ();

	[Embed(source="../../assets/defaultBMP/slider_button_down.png")]
	private var slider_button_down:Class;
	private var slider_button_down_bit:Bitmap = new slider_button_down ();

	[Embed(source="../../assets/defaultBMP/slider_button_over.png")]
	private var slider_button_over:Class;
	private var slider_button_over_bit:Bitmap = new slider_button_over ();

	// Numeric Stepper
	[Embed(source="../../assets/defaultBMP/ns_bg_normal.png")]
	private var ns_bg_normal:Class;
	private var ns_bg_normal_bit:Bitmap = new ns_bg_normal ();

	[Embed(source="../../assets/defaultBMP/ns_bg_active.png")]
	private var ns_bg_active:Class;
	private var ns_bg_active_bit:Bitmap = new ns_bg_active ();

	// Numeric Stepper Buttons
	[Embed(source="../../assets/defaultBMP/ns_decrease_button_normal.png")]
	private var ns_decrease_button_normal:Class;
	private var ns_decrease_button_normal_bit:Bitmap = new ns_decrease_button_normal ();

	[Embed(source="../../assets/defaultBMP/ns_decrease_button_over.png")]
	private var ns_decrease_button_over:Class;
	private var ns_decrease_button_over_bit:Bitmap = new ns_decrease_button_over ();

	[Embed(source="../../assets/defaultBMP/ns_decrease_button_down.png")]
	private var ns_decrease_button_down:Class;
	private var ns_decrease_button_down_bit:Bitmap = new ns_decrease_button_down ();

	[Embed(source="../../assets/defaultBMP/ns_increase_button_normal.png")]
	private var ns_increase_button_normal:Class;
	private var ns_increase_button_normal_bit:Bitmap = new ns_increase_button_normal ();

	[Embed(source="../../assets/defaultBMP/ns_increase_button_over.png")]
	private var ns_increase_button_over:Class;
	private var ns_increase_button_over_bit:Bitmap = new ns_increase_button_over ();

	[Embed(source="../../assets/defaultBMP/ns_increase_button_down.png")]
	private var ns_increase_button_down:Class;
	private var ns_increase_button_down_bit:Bitmap = new ns_increase_button_down ();

	//Window
	[Embed(source="../../assets/defaultBMP/window_bg.png")]
	private var window_bg:Class;
	private var window_bg_bit:Bitmap = new window_bg ();

	[Embed(source="../../assets/defaultBMP/window_footer.png")]
	private var window_footer:Class;
	private var window_footer_bit:Bitmap = new window_footer ();

	[Embed(source="../../assets/defaultBMP/window_header.png")]
	private var window_header:Class;
	private var window_header_bit:Bitmap = new window_header ();

	[Embed(source="../../assets/defaultBMP/sizer.png")]
	private var sizer:Class;
	private var sizer_bit:Bitmap = new sizer ();

	// Tabs
	[Embed(source="../../assets/defaultBMP/tabs_bg_normal.png")]
	private var tabs:Class;
	private var tabs_bit:Bitmap = new tabs ();

	[Embed(source="../../assets/defaultBMP/tabs_bg_down.png")]
	private var tabs_down:Class;
	private var tabs_down_bit:Bitmap = new tabs_down ();

	[Embed(source="../../assets/defaultBMP/text_box_bg_normal.png")]
	private var text_box_bg_normal:Class;
	private var text_box_bg_normal_bit:Bitmap = new text_box_bg_normal ();

	private var text_input_bg_normal_bit:Bitmap = new text_box_bg_normal ();

	// Form
	[Embed(source="../../assets/defaultBMP/form_scroll_bg.png")]
	private var form_scroll_bg:Class;
	private var form_scroll_bg_bit:Bitmap = new form_scroll_bg ();

	[Embed(source="../../assets/defaultBMP/form_scroll_button_bg.png")]
	private var form_scroll_button_bg:Class;

	private var form_scroll_button_bg_bit:Bitmap = new scroll_button_normal ();
	private var form_scroll_button_down_bit:Bitmap = new scroll_button_down ();
	private var form_scroll_button_over_bit:Bitmap = new scroll_button_over ();

	private var list_scroll_button_bg_bit:Bitmap = new scroll_button_normal ();
	private var list_scroll_button_down_bit:Bitmap = new scroll_button_down ();
	private var list_scroll_button_over_bit:Bitmap = new scroll_button_over ();



	public function BMPTheme () {

	}

	public function initialize ():void {
		// TextBrushes
		ThemeBase.Text_Button = new TextBrush ( "Verdana" , 12 , 0xffffff , false , false , false );
		ThemeBase.Text_CheckBox = new TextBrush ( "Verdana" , 12 , 0x000000 , false , false , false );
		ThemeBase.Text_Label = new TextBrush ( "Verdana" , 12 , 0x000000 , false , false , false );
		ThemeBase.Text_List = new TextBrush ( "Verdana" , 12 , 0x000000 , false , false , false );
		ThemeBase.Text_NumericStepper = new TextBrush ( "Verdana" , 12 , 0x000000 , false , false , false );
		ThemeBase.Text_TabBox = new TextBrush ( "Verdana" , 12 , 0x000000 , false , false , false );
		ThemeBase.Text_TextBox = new TextBrush ( "Verdana" , 12 , 0x000000 , false , false , false );
		ThemeBase.Text_TextInput = new TextBrush ( "Verdana" , 12 , 0x000000 , false , false , false );
		ThemeBase.Text_ToggleButton = new TextBrush ( "Verdana" , 12 , 0xffffff , false , false , false );

		// this class is too big to be edited easily needs separation into component classes
		//here is a start
		new ListBMPTheme().initialize();
		new ButtonBMPTheme().initialize();
		new CheckBoxBMPTheme().initialize();


		var scaleBMP0:ScaleBitmap;
		var scaleBMP1:ScaleBitmap;
		var scaleBMP2:ScaleBitmap;

		var data:Vector.<ScaleBitmap>;


		// ProgressBar
		scaleBMP0 = new ScaleBitmap ( progress_bg_bit.bitmapData );
		scaleBMP0.scale9Grid = new Rectangle ( 7 , 7 , 2 , 2 );

		scaleBMP1 = new ScaleBitmap ( progress_bar_bit.bitmapData );
		scaleBMP1.scale9Grid = new Rectangle ( 7 , 7 , 2 , 2 );

		data = new Vector.<ScaleBitmap> ( 2 , true );
		data[0] = scaleBMP0;
		data[1] = scaleBMP1;
		ThemeBase.ProgressBar = new BMPBrush ( data );

		// Slider
		scaleBMP0 = new ScaleBitmap ( slider_bg_h_normal_bit.bitmapData );
		scaleBMP0.scale9Grid = new Rectangle ( 16 , 13 , 86 , 3 );

		scaleBMP1 = new ScaleBitmap ( slider_bg_v_normal_bit.bitmapData );
		scaleBMP1.scale9Grid = new Rectangle ( 3 , 13 , 3 , 86 );

		data = new Vector.<ScaleBitmap> ( 2 , true );
		data[0] = scaleBMP0;
		data[1] = scaleBMP1;
		ThemeBase.Slider = new BMPBrush ( data );

		// Slider Button
		scaleBMP0 = new ScaleBitmap ( slider_button_normal_bit.bitmapData );
		scaleBMP0.scale9Grid = new Rectangle ( 2 , 2 , 1 , 1 );

		scaleBMP1 = new ScaleBitmap ( slider_button_over_bit.bitmapData );
		scaleBMP1.scale9Grid = new Rectangle ( 2 , 2 , 1 , 1 );

		scaleBMP2 = new ScaleBitmap ( slider_button_down_bit.bitmapData );
		scaleBMP2.scale9Grid = new Rectangle ( 2 , 2 , 1 , 1 );

		data = new Vector.<ScaleBitmap> ( 3 , true );
		data[0] = scaleBMP0;
		data[1] = scaleBMP1;
		data[2] = scaleBMP2;
		ThemeBase.SliderButton = new BMPBrush ( data );

		// NumericStepper
		scaleBMP0 = new ScaleBitmap ( ns_bg_normal_bit.bitmapData );
		scaleBMP0.scale9Grid = new Rectangle ( 13 , 15 , 51 , 12 );

		scaleBMP1 = new ScaleBitmap ( ns_bg_active_bit.bitmapData );
		scaleBMP1.scale9Grid = new Rectangle ( 13 , 15 , 51 , 12 );

		data = new Vector.<ScaleBitmap> ( 2 , true );
		data[0] = scaleBMP0;
		data[1] = scaleBMP1;
		ThemeBase.NumericStepper = new BMPBrush ( data );

		// NS_Buttons
		scaleBMP0 = new ScaleBitmap ( ns_decrease_button_normal_bit.bitmapData );
		scaleBMP0.scale9Grid = new Rectangle ( 2 , 2 , 13 , 4 );

		scaleBMP1 = new ScaleBitmap ( ns_decrease_button_down_bit.bitmapData );
		scaleBMP1.scale9Grid = new Rectangle ( 2 , 2 , 13 , 4 );

		scaleBMP2 = new ScaleBitmap ( ns_decrease_button_over_bit.bitmapData );
		scaleBMP2.scale9Grid = new Rectangle ( 2 , 2 , 13 , 4 );

		data = new Vector.<ScaleBitmap> ( 3 , true );
		data[0] = scaleBMP0;
		data[1] = scaleBMP2;
		data[2] = scaleBMP1;
		ThemeBase.NS_Decrease = new BMPBrush ( data );

		scaleBMP0 = new ScaleBitmap ( ns_increase_button_normal_bit.bitmapData );
		scaleBMP0.scale9Grid = new Rectangle ( 2 , 4 , 13 , 4 );

		scaleBMP1 = new ScaleBitmap ( ns_increase_button_down_bit.bitmapData );
		scaleBMP1.scale9Grid = new Rectangle ( 2 , 4 , 13 , 4 );

		scaleBMP2 = new ScaleBitmap ( ns_increase_button_over_bit.bitmapData );
		scaleBMP2.scale9Grid = new Rectangle ( 2 , 4 , 13 , 4 );

		data = new Vector.<ScaleBitmap> ( 3 , true );
		data[0] = scaleBMP0;
		data[1] = scaleBMP2;
		data[2] = scaleBMP1;
		ThemeBase.NS_Increase = new BMPBrush ( data );

		// Window
		scaleBMP0 = new ScaleBitmap ( window_header_bit.bitmapData );
		scaleBMP0.scale9Grid = new Rectangle ( 9 , 9 , 182 , 4 );

		data = new Vector.<ScaleBitmap> ( 1 , true );
		data[0] = scaleBMP0;
		ThemeBase.Window_Header = new BMPBrush ( data );

		scaleBMP0 = new ScaleBitmap ( window_footer_bit.bitmapData );
		scaleBMP0.scale9Grid = new Rectangle ( 9 , 6 , 182 , 4 );

		data = new Vector.<ScaleBitmap> ( 1 , true );
		data[0] = scaleBMP0;
		ThemeBase.Window_Footer = new BMPBrush ( data );

		scaleBMP0 = new ScaleBitmap ( window_bg_bit.bitmapData );
		scaleBMP0.scale9Grid = new Rectangle ( 11 , 1 , 180 , 2 );

		scaleBMP1 = new ScaleBitmap ( sizer_bit.bitmapData );
		scaleBMP1.scale9Grid = new Rectangle ( 0 , 0 , 0 , 0 );

		data = new Vector.<ScaleBitmap> ( 2 , true );
		data[0] = scaleBMP0;
		data[1] = scaleBMP1;
		ThemeBase.Window = new BMPBrush ( data );

		// ScrollBar
		scaleBMP0 = new ScaleBitmap ( scroll_bar_bg_h_bit.bitmapData );
		scaleBMP0.scale9Grid = new Rectangle ( 7 , 7 , 2 , 2 );

		scaleBMP1 = new ScaleBitmap ( scroll_bar_bg_v_bit.bitmapData );
		scaleBMP1.scale9Grid = new Rectangle ( 7 , 7 , 2 , 2 );

		data = new Vector.<ScaleBitmap> ( 2 , true );
		data[0] = scaleBMP0;
		data[1] = scaleBMP1;
		ThemeBase.SC_ScrollBar = new BMPBrush ( data );

		scaleBMP0 = new ScaleBitmap ( scroll_button_normal_bit.bitmapData );
		scaleBMP0.scale9Grid = new Rectangle ( 7 , 7 , 2 , 2 );

		scaleBMP1 = new ScaleBitmap ( scroll_button_over_bit.bitmapData );
		scaleBMP1.scale9Grid = new Rectangle ( 7 , 7 , 2 , 2 );

		scaleBMP2 = new ScaleBitmap ( scroll_button_down_bit.bitmapData );
		scaleBMP2.scale9Grid = new Rectangle ( 7 , 7 , 2 , 2 );

		data = new Vector.<ScaleBitmap> ( 3 , true );
		data[0] = scaleBMP0;
		data[1] = scaleBMP1;
		data[2] = scaleBMP2;
		ThemeBase.SC_ScrollBarButton = new BMPBrush ( data );

		scaleBMP0 = new ScaleBitmap ( tabs_bit.bitmapData );
		scaleBMP0.scale9Grid = new Rectangle ( 11 , 12 , 1 , 2 );

		scaleBMP1 = new ScaleBitmap ( tabs_down_bit.bitmapData );
		scaleBMP1.scale9Grid = new Rectangle ( 11 , 12 , 1 , 2 );

		// TabBox_Title
		data = new Vector.<ScaleBitmap> ( 2 , true );
		data[0] = scaleBMP0;
		data[1] = scaleBMP1;
		ThemeBase.TabBox_Title = new BMPBrush ( data );

		scaleBMP0 = new ScaleBitmap ( text_box_bg_normal_bit.bitmapData );
		scaleBMP0.scale9Grid = new Rectangle ( 13 , 15 , 51 , 12 );

		// TextBox
		data = new Vector.<ScaleBitmap> ( 1 , true );
		data[0] = scaleBMP0;
		ThemeBase.TextBox = new BMPBrush ( data );

		scaleBMP0 = new ScaleBitmap ( text_input_bg_normal_bit.bitmapData );
		scaleBMP0.scale9Grid = new Rectangle ( 13 , 15 , 51 , 12 );

		data = new Vector.<ScaleBitmap> ( 1 , true );
		data[0] = scaleBMP0;
		ThemeBase.TextInput = new BMPBrush ( data );

		scaleBMP0 = new ScaleBitmap ( form_scroll_bg_bit.bitmapData );
		scaleBMP0.scale9Grid = new Rectangle ( 7 , 7 , 2 , 2 );

		data = new Vector.<ScaleBitmap> ( 2 , true );
		data[0] = scaleBMP0;
		//todo bug when only one property
		data[1] = scaleBMP0;
		ThemeBase.Form_ScrollBar = new BMPBrush ( data );




		scaleBMP0 = new ScaleBitmap ( form_scroll_button_bg_bit.bitmapData );
		scaleBMP0.scale9Grid = new Rectangle ( 2 , 2 , 1 , 1 );

		scaleBMP1 = new ScaleBitmap ( form_scroll_button_over_bit.bitmapData );
		scaleBMP1.scale9Grid = new Rectangle ( 2 , 2 , 1 , 1 );

		scaleBMP2 = new ScaleBitmap ( form_scroll_button_down_bit.bitmapData );
		scaleBMP2.scale9Grid = new Rectangle ( 2 , 2 , 1 , 1 );

		data = new Vector.<ScaleBitmap> ( 3 , true );
		data[0] = scaleBMP0;
		data[1] = scaleBMP1;
		data[2] = scaleBMP2;
		ThemeBase.Form_ScrollBarButton = new BMPBrush ( data );





		var uint_data:Vector.<uint>;



		// Form
		uint_data = new Vector.<uint> ( 1 , true );
		uint_data[0] = 0x666666;
		ThemeBase.Form = new ColorBrush ( uint_data );

		uint_data = new Vector.<uint> ( 2 , true );
		uint_data[0] = 0xF1BA44;
		uint_data[1] = 0xffffff;
		ThemeBase.FormItem = new ColorBrush ( uint_data );



		// TabBox
		uint_data = new Vector.<uint> ( 1 , true );
		uint_data[0] = 0x666666;
		ThemeBase.TabBox = new ColorBrush ( uint_data );

		// Container
		uint_data = new Vector.<uint> ( 1 , true );
		uint_data[0] = 0xE9E9E9;
		ThemeBase.Container = new ColorBrush ( uint_data );







	}

}

}
