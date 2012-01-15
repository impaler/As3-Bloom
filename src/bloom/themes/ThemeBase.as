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
	import flash.filters.DropShadowFilter;
	
	import bloom.brushes.*;
	
	/**
	 * ThemeBase
	 * 
	 * @date 2012/1/15 14:47
	 * @author sindney, impaler
	 */
	public final class ThemeBase {
		
		/**
		 * Use this to set your theme. Then new your components.
		 * @param	theme
		 */
		public static function setTheme(theme:ITheme):void {
			theme.initialize();
		}
		
		///////////////////////////////////
		// Gloabal
		///////////////////////////////////
		
		public static const SHADOW:DropShadowFilter = new DropShadowFilter(2, 45, 0, 1, 4, 4, 1, 1, true);
		
		public static var ALPHA:Number = 0.8;
		
		public static var FOCUS:uint = 0xEEDD88;
		
		///////////////////////////////////
		// TextBrushes
		///////////////////////////////////
		
		public static var Text_Button:TextBrush;
		
		public static var Text_CheckBox:TextBrush;
		
		public static var Text_Label:TextBrush;
		
		public static var Text_List:TextBrush;
		
		public static var Text_NumericStepper:TextBrush;
		
		public static var Text_TextBox:TextBrush;
		
		public static var Text_TextInput:TextBrush;
		
		public static var Text_ToggleButton:TextBrush;
		
		///////////////////////////////////
		// ColorBrushes
		///////////////////////////////////
		
		// Button
		public static var Button:Brush;
		
		// CheckBox
		public static var CheckBox:Brush;
		
		// Conatiner
		public static var Container:Brush;
		
		// Form
		public static var Form:Brush;
		public static var Form_ScrollBar:Brush;
		public static var Form_ScrollBarButton:Brush;
		
		// FormItem
		public static var FormItem:Brush;
		
		// List
		public static var List:Brush;
		public static var List_ScrollBar:Brush;
		public static var List_ScrollBarButton:Brush;
		
		// ListItem
		public static var ListItem:Brush;
		
		// NumericStepper
		public static var NumericStepper:Brush;
        public static var NS_INCREASE_Button:Brush;
        public static var NS_DECREASE_Button:Brush;
		
		// ProgressBar
		public static var ProgressBar:Brush;
		
		// ScrollContainer
		public static var ScrollContainer:Brush;
		public static var SC_ScrollBar:Brush;
		public static var SC_ScrollBarButton:Brush;
		
		// Slider
		public static var Slider:Brush;
		public static var SliderButton:Brush;
		
		// TextBox
		public static var TextBox:Brush;
		public static var TB_ScrollBar:Brush;
		public static var TB_ScrollBarButton:Brush;
		
		// TextInput
		public static var TextInput:Brush;
		
		// ToggleButton
		public static var ToggleButton:Brush;
		
		// ToggleSwitcher
		public static var ToggleSwitcher:Brush;
		
		// Window
		public static var Window_Header:Brush;
		public static var Window_Footer:Brush;
		public static var Window_Scaler:Brush;
		
	}

}
