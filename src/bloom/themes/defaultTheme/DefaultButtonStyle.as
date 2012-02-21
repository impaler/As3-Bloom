package bloom.themes.defaultTheme
{

import bloom.brush.BMPBrush;
import bloom.brush.TextBrush;
import bloom.components.ButtonBase;
import bloom.core.ScaleBitmap;
import bloom.style.ButtonStyle;
import bloom.style.TextStyle;

import flash.geom.Rectangle;

	/**
	 * ButtonStyle
	 */
	public class DefaultButtonStyle extends ButtonStyle {
	
	[Embed(source="./assets/button_normal.png")]
	private static var bt_normal:Class;
	
	[Embed(source="./assets/button_down.png")]
	private static var bt_down:Class;
	
	[Embed(source="./assets/button_over.png")]
	private static var bt_over:Class;
		
		public function DefaultButtonStyle() {

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
			
			
			var normal:ScaleBitmap = new ScaleBitmap(new bt_normal().bitmapData);
			normal.scale9Grid = new Rectangle(15, 15, 70, 14);
			var over:ScaleBitmap = new ScaleBitmap(new bt_over().bitmapData);
			over.scale9Grid = new Rectangle(15, 15, 70, 14);
			var down:ScaleBitmap = new ScaleBitmap(new bt_down().bitmapData);
			down.scale9Grid = new Rectangle(15, 15, 70, 14);
			
			var BMPBackgroundData:Vector.<ScaleBitmap> = new Vector.<ScaleBitmap> ( 3 , true );
			BMPBackgroundData[ButtonBase.NORMAL] = normal;
			BMPBackgroundData[ButtonBase.OVER] = over;
			BMPBackgroundData[ButtonBase.DOWN] = down;
			backgroundBrush = new BMPBrush( BMPBackgroundData );
			
		}

		
		///////////////////////////////////
		// toString
		///////////////////////////////////
		
		override public function toString():String {
			return "[bloom.style.default.DefaultButtonStyle]";
		}


}

}