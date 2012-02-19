package bloom.themes.default 
{

import bloom.brush.TextBrush;
import bloom.components.ButtonBase;
import bloom.core.TextStyle;
	
	/**
	 * ButtonStyle
	 */
	public class ButtonStyle extends ButtonBaseStyle {
		
		public var textStyle:TextBrush;
		
		public function ButtonStyle() {
			super();
			
			var title_normal:TextStyle = new TextStyle();
			title_normal.textFormat.font = "Verdana";
			title_normal.textFormat.size = 12;
			title_normal.textFormat.color = 0xffffff;
			title_normal.textFormat.bold = false;
			
			var title_over:TextStyle = new TextStyle();
			title_over.textFormat.font = "Verdana";
			title_over.textFormat.size = 12;
			title_over.textFormat.color = 0xffffff;
			title_over.textFormat.bold = true;
			
			var title_down:TextStyle = new TextStyle();
			title_down.textFormat.font = "Verdana";
			title_down.textFormat.size = 12;
			title_down.textFormat.color = 0x000000;
			title_down.textFormat.bold = true;
			
			var data:Vector.<TextStyle> = new Vector.<TextStyle> ( 3 , true );
			data[ButtonBase.NORMAL] = title_normal;
			data[ButtonBase.OVER] = title_over;
			data[ButtonBase.DOWN] = title_down;
			textStyle = new TextBrush( data );
			
		}
		
		///////////////////////////////////
		// toString
		///////////////////////////////////
		
		override public function toString():String {
			return "[bloom.themes.default.ButtonStyle]";
		}
		
	}

}