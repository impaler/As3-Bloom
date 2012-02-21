package bloom.themes.defaultTheme
{

import bloom.core.ScaleBitmap;
import bloom.style.TextInputStyle;
import bloom.style.TextStyle;

import flash.geom.Rectangle;

	/**
	 * TextInputStyle
	 */
	public class DefaultTextInputStyle extends TextInputStyle {
		
		[Embed(source="./assets/text_normal.png")]
		private static var bg_normal:Class;
		
		[Embed(source="./assets/text_active.png")]
		private static var bg_active:Class;
		
		public function DefaultTextInputStyle() {
			
			normal = new ScaleBitmap(new bg_normal().bitmapData);
			normal.scale9Grid = new Rectangle(13, 15, 51, 12);
			
			active = new ScaleBitmap(new bg_active().bitmapData);
			active.scale9Grid = new Rectangle(13, 15, 51, 12);
			
			text_normal = new TextStyle();
			text_normal.textFormat.font = "Verdana";
			text_normal.textFormat.size = 12;
			text_normal.textFormat.color = 0x666666;
			
			text_active = new TextStyle();
			text_active.textFormat.font = "Verdana";
			text_active.textFormat.size = 12;
			text_active.textFormat.color = 0x000000;
		}
		
		///////////////////////////////////
		// toString
		///////////////////////////////////
		
		override public function toString():String {
			return "[bloom.style.default.DefaultTextInputStyle]";
		}
		
	}

}