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
	import bloom.brushes.ColorBrush;
	import bloom.brushes.TextBrush;
	
	/**
	 * DefaultTheme
	 * 
	 * @date 2012/1/15 14:47
	 * @author sindney, impaler
	 */
	public class DefaultTheme implements ITheme {
		
		public function DefaultTheme() {
			
		}
		
		public function initialize():void {
			// TextBrushes
			ThemeBase.Text_Button = new TextBrush("Verdana", 12, 0xffffff, false, false, false);
			ThemeBase.Text_CheckBox = new TextBrush("Verdana", 12, 0x000000, false, false, false);
			ThemeBase.Text_Label = new TextBrush("Verdana", 12, 0x000000, false, false, false);
			ThemeBase.Text_List = new TextBrush("Verdana", 12, 0x000000, false, false, false);
			ThemeBase.Text_NumericStepper = new TextBrush("Verdana", 12, 0xffffff, false, false, false);
			ThemeBase.Text_TextBox = new TextBrush("Verdana", 12, 0xffffff, false, false, false);
			ThemeBase.Text_TextInput = new TextBrush("Verdana", 12, 0xffffff, false, false, false);
			ThemeBase.Text_ToggleButton = new TextBrush("Verdana", 12, 0xffffff, false, false, false);
			
			// Button
			var data:Vector.<uint> = new Vector.<uint>(3, true);
			data[0] = 0x3E3E72;
			data[1] = 0x5E5EAC;
			data[2] = 0xF1BA44;
			ThemeBase.Button = new ColorBrush(data);
			
			// CheckBox
			data = new Vector.<uint>(2, true);
			data[0] = 0x333333;
			data[1] = 0xffffff;
			ThemeBase.CheckBox = new ColorBrush(data);
			
			// Container
			data = new Vector.<uint>(1, true);
			data[0] = 0xE9E9E9;
			ThemeBase.Container = new ColorBrush(data);
			
			// Form
			data = new Vector.<uint>(1, true);
			data[0] = 0x666666;
			ThemeBase.Form = new ColorBrush(data);
			
			data = new Vector.<uint>(1, true);
			data[0] = 0x222222;
			ThemeBase.Form_ScrollBar = new ColorBrush(data);
			
			data = new Vector.<uint>(3, true);
			data[0] = 0x3E3E72;
			data[1] = 0x3E3E72;
			data[2] = 0xF1BA44;
			ThemeBase.Form_ScrollBarButton = new ColorBrush(data);
			
			data = new Vector.<uint>(2, true);
			data[0] = 0xF1BA44;
			data[1] = 0xffffff;
			ThemeBase.FormItem = new ColorBrush(data);
			
			// List
			data = new Vector.<uint>(1, true);
			data[0] = 0x666666;
			ThemeBase.List = new ColorBrush(data);
			
			data = new Vector.<uint>(1, true);
			data[0] = 0x222222;
			ThemeBase.List_ScrollBar = new ColorBrush(data);
			
			data = new Vector.<uint>(3, true);
			data[0] = 0x3E3E72;
			data[1] = 0x3E3E72;
			data[2] = 0xF1BA44;
			ThemeBase.List_ScrollBarButton = new ColorBrush(data);
			
			data = new Vector.<uint>(2, true);
			data[0] = 0xF1BA44;
			data[1] = 0xffffff;
			ThemeBase.ListItem = new ColorBrush(data);
			
			// NumericStepper
			data = new Vector.<uint>(2, true);
			data[0] = 0x666666;
			data[1] = 0xffffff;
			ThemeBase.NumericStepper = new ColorBrush(data);
			
			// NS_Button
			data = new Vector.<uint>(3, true);
			data[0] = 0x3E3E72;
			data[1] = 0x3E3E72;
			data[2] = 0xF1BA44;
			ThemeBase.NS_Button = new ColorBrush(data);
			
			// ProgressBar
			data = new Vector.<uint>(2, true);
			data[0] = 0x333333;
			data[1] = 0xF1BA44;
			ThemeBase.ProgressBar = new ColorBrush(data);
			
			// ScrollContainer
			data = new Vector.<uint>(1, true);
			data[0] = 0xE9E9E9;
			ThemeBase.ScrollContainer = new ColorBrush(data);
			
			data = new Vector.<uint>(1, true);
			data[0] = 0x222222;
			ThemeBase.SC_ScrollBar = new ColorBrush(data);
			
			data = new Vector.<uint>(3, true);
			data[0] = 0x3E3E72;
			data[1] = 0x3E3E72;
			data[2] = 0xF1BA44;
			ThemeBase.SC_ScrollBarButton = new ColorBrush(data);
			
			// Slider
			data = new Vector.<uint>(1, true);
			data[0] = 0x222222;
			ThemeBase.Slider = new ColorBrush(data);
			
			data = new Vector.<uint>(3, true);
			data[0] = 0x3E3E72;
			data[1] = 0x3E3E72;
			data[2] = 0xF1BA44;
			ThemeBase.SliderButton = new ColorBrush(data);
			
			// TextBox
			data = new Vector.<uint>(1, true);
			data[0] = 0x666666;
			ThemeBase.TextBox = new ColorBrush(data);
			
			// TB_ScrollBar
			data = new Vector.<uint>(1, true);
			data[0] = 0x222222;
			ThemeBase.TB_ScrollBar = new ColorBrush(data);
			
			// TB_ScrollBarButton
			data = new Vector.<uint>(3, true);
			data[0] = 0x3E3E72;
			data[1] = 0x3E3E72;
			data[2] = 0xF1BA44;
			ThemeBase.TB_ScrollBarButton = new ColorBrush(data);
			
			// TextInput
			data = new Vector.<uint>(1, true);
			data[0] = 0x666666;
			ThemeBase.TextInput = new ColorBrush(data);
			
			// ToggleButton
			data = new Vector.<uint>(2, true);
			data[0] = 0xF1BA44;
			data[1] = 0x3E3E72;
			ThemeBase.ToggleButton = new ColorBrush(data);
			
			// ToggleSwitcher
			data = new Vector.<uint>(3, true);
			data[0] = 0x3E3E72;
			data[1] = 0x6495ED;
			data[2] = 0xFF0000;
			ThemeBase.ToggleSwitcher = new ColorBrush(data);
		}
		
	}

}