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
package bloom.themes.bmptheme 
{
	import bloom.brushes.ColorBrush;
	import bloom.themes.ThemeBase;
	import bloom.themes.ITheme;
	
	/**
	 * AccordionTheme
	 * 
	 * @author sindney
	 */
	public class AccordionTheme implements ITheme {
		
		public function initialize():void {
			var data:Vector.<uint>;
			
			data = new Vector.<uint>(1, true);
			data[0] = 0x3E3E50;
			ThemeBase.AC_Title = new ColorBrush(data);
			
			data = new Vector.<uint>(1, true);
			data[0] = 0xB4B4B4;
			ThemeBase.AC_Content = new ColorBrush(data);
		}
		
	}

}