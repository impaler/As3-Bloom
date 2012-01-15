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
package bloom.core 
{
	import flash.filters.DropShadowFilter;
	import flash.utils.ByteArray;
	
	import bloom.brushes.*;
	
	/**
	 * ThemeBase
	 * 
	 * @date 2012/1/14 22:28
	 * @author sindney
	 */
	public final class ThemeBase {
		
		///////////////////////////////////
		// Gloabal
		///////////////////////////////////
		
		public static const SHAOW:DropShadowFilter = new DropShadowFilter(2, 45, 0, 1, 4, 4, 1, 1, true);
		
		public static const VERSION:int = 1;
		
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
		public static var NS_Button:Brush;
		
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
		
		/**
		 * Call initialize() first, then new your components.
		 */
		public static function initialize():void {
			// TextBrushes
			Text_Button = new TextBrush("Verdana", 12, 0xffffff, false, false, false);
			Text_CheckBox = new TextBrush("Verdana", 12, 0x000000, false, false, false);
			Text_Label = new TextBrush("Verdana", 12, 0x000000, false, false, false);
			Text_List = new TextBrush("Verdana", 12, 0x000000, false, false, false);
			Text_NumericStepper = new TextBrush("Verdana", 12, 0xffffff, false, false, false);
			Text_TextBox = new TextBrush("Verdana", 12, 0xffffff, false, false, false);
			Text_TextInput = new TextBrush("Verdana", 12, 0xffffff, false, false, false);
			Text_ToggleButton = new TextBrush("Verdana", 12, 0xffffff, false, false, false);
			
			// Button
			var data:Vector.<uint> = new Vector.<uint>(3, true);
			data[0] = 0x3E3E72;
			data[1] = 0x5E5EAC;
			data[2] = 0xF1BA44;
			Button = new ColorBrush(data);
			
			// CheckBox
			data = new Vector.<uint>(2, true);
			data[0] = 0x333333;
			data[1] = 0xffffff;
			CheckBox = new ColorBrush(data);
			
			// Container
			data = new Vector.<uint>(1, true);
			data[0] = 0xE9E9E9;
			Container = new ColorBrush(data);
			
			// Form
			data = new Vector.<uint>(1, true);
			data[0] = 0x666666;
			Form = new ColorBrush(data);
			
			data = new Vector.<uint>(1, true);
			data[0] = 0x222222;
			Form_ScrollBar = new ColorBrush(data);
			
			data = new Vector.<uint>(3, true);
			data[0] = 0x3E3E72;
			data[1] = 0x3E3E72;
			data[2] = 0xF1BA44;
			Form_ScrollBarButton = new ColorBrush(data);
			
			data = new Vector.<uint>(2, true);
			data[0] = 0xF1BA44;
			data[1] = 0xffffff;
			FormItem = new ColorBrush(data);
			
			// List
			data = new Vector.<uint>(1, true);
			data[0] = 0x666666;
			List = new ColorBrush(data);
			
			data = new Vector.<uint>(1, true);
			data[0] = 0x222222;
			List_ScrollBar = new ColorBrush(data);
			
			data = new Vector.<uint>(3, true);
			data[0] = 0x3E3E72;
			data[1] = 0x3E3E72;
			data[2] = 0xF1BA44;
			List_ScrollBarButton = new ColorBrush(data);
			
			data = new Vector.<uint>(2, true);
			data[0] = 0xF1BA44;
			data[1] = 0xffffff;
			ListItem = new ColorBrush(data);
			
			// NumericStepper
			data = new Vector.<uint>(2, true);
			data[0] = 0x666666;
			data[1] = 0xffffff;
			NumericStepper = new ColorBrush(data);
			
			// NS_Button
			data = new Vector.<uint>(3, true);
			data[0] = 0x3E3E72;
			data[1] = 0x3E3E72;
			data[2] = 0xF1BA44;
			NS_Button = new ColorBrush(data);
			
			// ProgressBar
			data = new Vector.<uint>(2, true);
			data[0] = 0x333333;
			data[1] = 0xF1BA44;
			ProgressBar = new ColorBrush(data);
			
			// ScrollContainer
			data = new Vector.<uint>(1, true);
			data[0] = 0xE9E9E9;
			ScrollContainer = new ColorBrush(data);
			
			data = new Vector.<uint>(1, true);
			data[0] = 0x222222;
			SC_ScrollBar = new ColorBrush(data);
			
			data = new Vector.<uint>(3, true);
			data[0] = 0x3E3E72;
			data[1] = 0x3E3E72;
			data[2] = 0xF1BA44;
			SC_ScrollBarButton = new ColorBrush(data);
			
			// Slider
			data = new Vector.<uint>(1, true);
			data[0] = 0x222222;
			Slider = new ColorBrush(data);
			
			data = new Vector.<uint>(3, true);
			data[0] = 0x3E3E72;
			data[1] = 0x3E3E72;
			data[2] = 0xF1BA44;
			SliderButton = new ColorBrush(data);
			
			// TextBox
			data = new Vector.<uint>(1, true);
			data[0] = 0x666666;
			TextBox = new ColorBrush(data);
			
			// TB_ScrollBar
			data = new Vector.<uint>(1, true);
			data[0] = 0x222222;
			TB_ScrollBar = new ColorBrush(data);
			
			// TB_ScrollBarButton
			data = new Vector.<uint>(3, true);
			data[0] = 0x3E3E72;
			data[1] = 0x3E3E72;
			data[2] = 0xF1BA44;
			TB_ScrollBarButton = new ColorBrush(data);
			
			// TextInput
			data = new Vector.<uint>(1, true);
			data[0] = 0x666666;
			TextInput = new ColorBrush(data);
			
			// ToggleButton
			data = new Vector.<uint>(2, true);
			data[0] = 0xF1BA44;
			data[1] = 0x3E3E72;
			ToggleButton = new ColorBrush(data);
			
			// ToggleSwitcher
			data = new Vector.<uint>(3, true);
			data[0] = 0x3E3E72;
			data[1] = 0x6495ED;
			data[2] = 0xFF0000;
			ToggleSwitcher = new ColorBrush(data);
		}
		
		/**
		 * Load theme from ByteArray
		 */
		public static function loadTheme(source:ByteArray):void {
			source.uncompress();
			
			// Check version
			if (source.readInt() != VERSION) {
				throw(new Error("Bad File Version."));
				return;
			}
			
			// Alpha (the alpha when component is disabled)
			ALPHA = source.readFloat();
			
			// Focus
			FOCUS = source.readUnsignedInt();
			
			// TextBrushes
			updateTextBrush(Text_Button, source.readUTF(), source.readInt(), source.readUnsignedInt(), source.readBoolean(), source.readBoolean(), source.readBoolean());
			updateTextBrush(Text_CheckBox, source.readUTF(), source.readInt(), source.readUnsignedInt(), source.readBoolean(), source.readBoolean(), source.readBoolean());
			updateTextBrush(Text_Label, source.readUTF(), source.readInt(), source.readUnsignedInt(), source.readBoolean(), source.readBoolean(), source.readBoolean());
			updateTextBrush(Text_List, source.readUTF(), source.readInt(), source.readUnsignedInt(), source.readBoolean(), source.readBoolean(), source.readBoolean());
			updateTextBrush(Text_NumericStepper, source.readUTF(), source.readInt(), source.readUnsignedInt(), source.readBoolean(), source.readBoolean(), source.readBoolean());
			updateTextBrush(Text_TextBox, source.readUTF(), source.readInt(), source.readUnsignedInt(), source.readBoolean(), source.readBoolean(), source.readBoolean());
			updateTextBrush(Text_TextInput, source.readUTF(), source.readInt(), source.readUnsignedInt(), source.readBoolean(), source.readBoolean(), source.readBoolean());
			updateTextBrush(Text_ToggleButton, source.readUTF(), source.readInt(), source.readUnsignedInt(), source.readBoolean(), source.readBoolean(), source.readBoolean());
			
			// ColorBrushes
			var brush:ColorBrush;
			
			// Button
			if (!Button is ColorBrush) Button = new ColorBrush(new Vector.<uint>(3, true));
			brush = Button as ColorBrush;
			brush.colors[0] = source.readUnsignedInt();
			brush.colors[1] = source.readUnsignedInt();
			brush.colors[2] = source.readUnsignedInt();
			brush.update();
			
			// CheckBox
			if (!CheckBox is ColorBrush) CheckBox = new ColorBrush(new Vector.<uint>(2, true));
			brush = CheckBox as ColorBrush;
			brush.colors[0] = source.readUnsignedInt();
			brush.colors[1] = source.readUnsignedInt();
			brush.update();
			
			// Container
			if (!Container is ColorBrush) Container = new ColorBrush(new Vector.<uint>(1, true));
			brush = Container as ColorBrush;
			brush.colors[0] = source.readUnsignedInt();
			brush.update();
			
			// Form
			if (!Form is ColorBrush) Form = new ColorBrush(new Vector.<uint>(1, true));
			brush = Form as ColorBrush;
			brush.colors[0] = source.readUnsignedInt();
			brush.update();
			
			if (!Form_ScrollBar is ColorBrush) Form_ScrollBar = new ColorBrush(new Vector.<uint>(1, true));
			brush = Form_ScrollBar as ColorBrush;
			brush.colors[0] = source.readUnsignedInt();
			brush.update();
			
			if (!Form_ScrollBarButton is ColorBrush) Form_ScrollBarButton = new ColorBrush(new Vector.<uint>(3, true));
			brush = Form_ScrollBarButton as ColorBrush;
			brush.colors[0] = source.readUnsignedInt();
			brush.colors[1] = source.readUnsignedInt();
			brush.colors[2] = source.readUnsignedInt();
			brush.update();
			
			if (!FormItem is ColorBrush) FormItem = new ColorBrush(new Vector.<uint>(2, true));
			brush = FormItem as ColorBrush;
			brush.colors[0] = source.readUnsignedInt();
			brush.colors[1] = source.readUnsignedInt();
			brush.update();
			
			// List
			if (!List is ColorBrush) List = new ColorBrush(new Vector.<uint>(1, true));
			brush = List as ColorBrush;
			brush.colors[0] = source.readUnsignedInt();
			brush.update();
			
			if (!List_ScrollBar is ColorBrush) List_ScrollBar = new ColorBrush(new Vector.<uint>(1, true));
			brush = List_ScrollBar as ColorBrush;
			brush.colors[0] = source.readUnsignedInt();
			brush.update();
			
			if (!List_ScrollBarButton is ColorBrush) List_ScrollBarButton = new ColorBrush(new Vector.<uint>(3, true));
			brush = List_ScrollBarButton as ColorBrush;
			brush.colors[0] = source.readUnsignedInt();
			brush.colors[1] = source.readUnsignedInt();
			brush.colors[2] = source.readUnsignedInt();
			brush.update();
			
			if (!ListItem is ColorBrush) ListItem = new ColorBrush(new Vector.<uint>(2, true));
			brush = ListItem as ColorBrush;
			brush.colors[0] = source.readUnsignedInt();
			brush.colors[1] = source.readUnsignedInt();
			brush.update();
			
			// NumericStepper
			if (!NumericStepper is ColorBrush) NumericStepper = new ColorBrush(new Vector.<uint>(1, true));
			brush = NumericStepper as ColorBrush;
			brush.colors[0] = source.readUnsignedInt();
			brush.colors[1] = source.readUnsignedInt();
			brush.update();
			
			if (!NS_Button is ColorBrush) NS_Button = new ColorBrush(new Vector.<uint>(3, true));
			brush = NS_Button as ColorBrush;
			brush.colors[0] = source.readUnsignedInt();
			brush.colors[1] = source.readUnsignedInt();
			brush.colors[2] = source.readUnsignedInt();
			brush.update();
			
			// ProgressBar
			if (!ProgressBar is ColorBrush) ProgressBar = new ColorBrush(new Vector.<uint>(2, true));
			brush = ProgressBar as ColorBrush;
			brush.colors[0] = source.readUnsignedInt();
			brush.colors[1] = source.readUnsignedInt();
			brush.update();
			
			// ScrollContainer
			if (!ScrollContainer is ColorBrush) ScrollContainer = new ColorBrush(new Vector.<uint>(1, true));
			brush = ScrollContainer as ColorBrush;
			brush.colors[0] = source.readUnsignedInt();
			brush.update();
			
			if (!SC_ScrollBar is ColorBrush) SC_ScrollBar = new ColorBrush(new Vector.<uint>(1, true));
			brush = SC_ScrollBar as ColorBrush;
			brush.colors[0] = source.readUnsignedInt();
			brush.update();
			
			if (!SC_ScrollBarButton is ColorBrush) SC_ScrollBarButton = new ColorBrush(new Vector.<uint>(3, true));
			brush = SC_ScrollBarButton as ColorBrush;
			brush.colors[0] = source.readUnsignedInt();
			brush.colors[1] = source.readUnsignedInt();
			brush.colors[2] = source.readUnsignedInt();
			brush.update();
			
			// Slider
			if (!Slider is ColorBrush) Slider = new ColorBrush(new Vector.<uint>(1, true));
			brush = Slider as ColorBrush;
			brush.colors[0] = source.readUnsignedInt();
			brush.update();
			
			if (!SliderButton is ColorBrush) SliderButton = new ColorBrush(new Vector.<uint>(3, true));
			brush = SliderButton as ColorBrush;
			brush.colors[0] = source.readUnsignedInt();
			brush.colors[1] = source.readUnsignedInt();
			brush.colors[2] = source.readUnsignedInt();
			brush.update();
			
			// TextBox
			if (!TextBox is ColorBrush) TextBox = new ColorBrush(new Vector.<uint>(1, true));
			brush = TextBox as ColorBrush;
			brush.colors[0] = source.readUnsignedInt();
			brush.update();
			
			if (!TB_ScrollBar is ColorBrush) TB_ScrollBar = new ColorBrush(new Vector.<uint>(1, true));
			brush = TB_ScrollBar as ColorBrush;
			brush.colors[0] = source.readUnsignedInt();
			brush.update();
			
			if (!TB_ScrollBarButton is ColorBrush) TB_ScrollBarButton = new ColorBrush(new Vector.<uint>(3, true));
			brush = TB_ScrollBarButton as ColorBrush;
			brush.colors[0] = source.readUnsignedInt();
			brush.colors[1] = source.readUnsignedInt();
			brush.colors[2] = source.readUnsignedInt();
			brush.update();
			
			// TextInput
			if (!TextInput is ColorBrush) TextInput = new ColorBrush(new Vector.<uint>(1, true));
			brush = TextInput as ColorBrush;
			brush.colors[0] = source.readUnsignedInt();
			brush.update();
			
			// ToggleButton
			if (!ToggleButton is ColorBrush) ToggleButton = new ColorBrush(new Vector.<uint>(2, true));
			brush = ToggleButton as ColorBrush;
			brush.colors[0] = source.readUnsignedInt();
			brush.colors[1] = source.readUnsignedInt();
			brush.update();
			
			// ToggleSwitcher
			if (!ToggleSwitcher is ColorBrush) ToggleSwitcher = new ColorBrush(new Vector.<uint>(3, true));
			brush = ToggleSwitcher as ColorBrush;
			brush.colors[0] = source.readUnsignedInt();
			brush.colors[1] = source.readUnsignedInt();
			brush.colors[2] = source.readUnsignedInt();
			brush.update();
		}
		
		/**
		 * Save current theme to ByteArray.
		 * <p>Please note, BMDBrush is not supported.</p>
		 */
		public static function saveTheme():ByteArray {
			var result:ByteArray = new ByteArray();
			
			// Version
			result.writeInt(VERSION);
			
			// Alpha (the alpha when component is disabled)
			result.writeFloat(ALPHA);
			
			// Focus
			result.writeUnsignedInt(FOCUS);
			
			// TextBrushes
			writeTextBrush(Text_Button, result);
			writeTextBrush(Text_CheckBox, result);
			writeTextBrush(Text_Label, result);
			writeTextBrush(Text_List, result);
			writeTextBrush(Text_NumericStepper, result);
			writeTextBrush(Text_TextBox, result);
			writeTextBrush(Text_TextInput, result);
			writeTextBrush(Text_ToggleButton, result);
			
			// ColorBrushes
			var brush:ColorBrush;
			
			// Button
			brush = Button as ColorBrush;
			result.writeUnsignedInt(brush.colors[0]);
			result.writeUnsignedInt(brush.colors[1]);
			result.writeUnsignedInt(brush.colors[2]);
			
			// CheckBox
			brush = CheckBox as ColorBrush;
			result.writeUnsignedInt(brush.colors[0]);
			result.writeUnsignedInt(brush.colors[1]);
			
			// Container
			brush = Container as ColorBrush;
			result.writeUnsignedInt(brush.colors[0]);
			
			// Form
			brush = Form as ColorBrush;
			result.writeUnsignedInt(brush.colors[0]);
			
			brush = Form_ScrollBar as ColorBrush;
			result.writeUnsignedInt(brush.colors[0]);
			
			brush = Form_ScrollBarButton as ColorBrush;
			result.writeUnsignedInt(brush.colors[0]);
			result.writeUnsignedInt(brush.colors[1]);
			result.writeUnsignedInt(brush.colors[2]);
			
			brush = FormItem as ColorBrush;
			result.writeUnsignedInt(brush.colors[0]);
			result.writeUnsignedInt(brush.colors[1]);
			
			// List
			brush = List as ColorBrush;
			result.writeUnsignedInt(brush.colors[0]);
			
			brush = List_ScrollBar as ColorBrush;
			result.writeUnsignedInt(brush.colors[0]);
			
			brush = List_ScrollBarButton as ColorBrush;
			result.writeUnsignedInt(brush.colors[0]);
			result.writeUnsignedInt(brush.colors[1]);
			result.writeUnsignedInt(brush.colors[2]);
			
			brush = ListItem as ColorBrush;
			result.writeUnsignedInt(brush.colors[0]);
			result.writeUnsignedInt(brush.colors[1]);
			
			// NumericStepper
			brush = NumericStepper as ColorBrush;
			result.writeUnsignedInt(brush.colors[0]);
			result.writeUnsignedInt(brush.colors[1]);
			
			brush = NS_Button as ColorBrush;
			result.writeUnsignedInt(brush.colors[0]);
			result.writeUnsignedInt(brush.colors[1]);
			result.writeUnsignedInt(brush.colors[2]);
			
			// ProgressBar
			brush = ProgressBar as ColorBrush;
			result.writeUnsignedInt(brush.colors[0]);
			result.writeUnsignedInt(brush.colors[1]);
			
			// ScrollContainer
			brush = ScrollContainer as ColorBrush;
			result.writeUnsignedInt(brush.colors[0]);
			
			brush = SC_ScrollBar as ColorBrush;
			result.writeUnsignedInt(brush.colors[0]);
			
			brush = SC_ScrollBarButton as ColorBrush;
			result.writeUnsignedInt(brush.colors[0]);
			result.writeUnsignedInt(brush.colors[1]);
			result.writeUnsignedInt(brush.colors[2]);
			
			// Slider
			brush = Slider as ColorBrush;
			result.writeUnsignedInt(brush.colors[0]);
			
			brush = SliderButton as ColorBrush;
			result.writeUnsignedInt(brush.colors[0]);
			result.writeUnsignedInt(brush.colors[1]);
			result.writeUnsignedInt(brush.colors[2]);
			
			// TextBox
			brush = TextBox as ColorBrush;
			result.writeUnsignedInt(brush.colors[0]);
			
			brush = TB_ScrollBar as ColorBrush;
			result.writeUnsignedInt(brush.colors[0]);
			
			brush = TB_ScrollBarButton as ColorBrush;
			result.writeUnsignedInt(brush.colors[0]);
			result.writeUnsignedInt(brush.colors[1]);
			result.writeUnsignedInt(brush.colors[2]);
			
			// TextInput
			brush = TextInput as ColorBrush;
			result.writeUnsignedInt(brush.colors[0]);
			
			// ToggleButton
			brush = ToggleButton as ColorBrush;
			result.writeUnsignedInt(brush.colors[0]);
			result.writeUnsignedInt(brush.colors[1]);
			
			// ToggleSwitcher
			brush = ToggleSwitcher as ColorBrush;
			result.writeUnsignedInt(brush.colors[0]);
			result.writeUnsignedInt(brush.colors[1]);
			result.writeUnsignedInt(brush.colors[2]);
			
			result.position = 0;
			result.compress();
			return result;
		}
		
		private static function updateTextBrush(brush:TextBrush, font:String, size:int, color:uint, bold:Boolean, italic:Boolean, underline:Boolean):void {
			brush.textFormat.font = font;
			brush.textFormat.size = size;
			brush.textFormat.color = color;
			brush.textFormat.bold = bold;
			brush.textFormat.italic = italic;
			brush.textFormat.underline = underline;
			brush.update();
		}
		
		private static function writeTextBrush(brush:TextBrush, dest:ByteArray):void {
			dest.writeUTF(brush.textFormat.font);
			dest.writeInt(int(brush.textFormat.size));
			dest.writeUnsignedInt(uint(brush.textFormat.color));
			dest.writeBoolean(brush.textFormat.bold);
			dest.writeBoolean(brush.textFormat.italic);
			dest.writeBoolean(brush.textFormat.underline);
		}
		
	}

}