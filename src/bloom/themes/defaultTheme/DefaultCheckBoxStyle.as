package bloom.themes.defaultTheme 
{

import bloom.core.ScaleBitmap;
import bloom.style.*;

	/**
	 * CheckBoxStyle
	 */
	public class DefaultCheckBoxStyle extends CheckBoxStyle {
		
		[Embed(source="./assets/checkbox_off.png")]
		private static var cb_normal:Class;
		
		[Embed(source="./assets/checkbox_on.png")]
		private static var cb_selected:Class;
		
		public function DefaultCheckBoxStyle() {
			
			normal = new ScaleBitmap(new cb_normal().bitmapData);
			selected = new ScaleBitmap(new cb_selected().bitmapData);
			
			title_normal = new TextStyle();
			title_normal.textFormat.font = "Verdana";
			title_normal.textFormat.size = 12;
			title_normal.textFormat.color = 0x666666;
			
			title_selected = new TextStyle();
			title_selected.textFormat.font = "Verdana";
			title_selected.textFormat.size = 12;
			title_selected.textFormat.color = 0x000000;
		}
		
		///////////////////////////////////
		// toString
		///////////////////////////////////
		
		override public function toString():String {
			return "[bloom.style.default.DefaultCheckBoxStyle]";
		}
		
	}

}