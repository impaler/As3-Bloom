package bloom.themes.defaultTheme 
{

import bloom.brush.BMPBrush;
import bloom.components.ButtonBase;
import bloom.core.ScaleBitmap;
import bloom.style.*;

import flash.geom.Rectangle;

/**
	 * NSDecreaseStyle
	 */
	public class DefaultNSDecreaseStyle extends ButtonBaseStyle {
		
		[Embed(source="./assets/ns_decrease_button_normal.png")]
		private static var bt_decrease_normal:Class;
		
		[Embed(source="./assets/ns_decrease_button_over.png")]
		private static var bt_decrease_over:Class;
		
		[Embed(source="./assets/ns_decrease_button_down.png")]
		private static var bt_decrease_down:Class;
		
		public function DefaultNSDecreaseStyle() {
			var normal:ScaleBitmap = new ScaleBitmap(new bt_decrease_normal().bitmapData);
			normal.scale9Grid = new Rectangle(2, 2, 13, 4);
			var over:ScaleBitmap = new ScaleBitmap(new bt_decrease_over().bitmapData);
			over.scale9Grid = new Rectangle(2, 2, 13, 4);
			var down:ScaleBitmap = new ScaleBitmap(new bt_decrease_down().bitmapData);
			down.scale9Grid = new Rectangle(2, 2, 13, 4);

			
			var data:Vector.<ScaleBitmap> = new Vector.<ScaleBitmap> ( 3 , true );
			data[ButtonBase.NORMAL] = normal;
			data[ButtonBase.OVER] = over;
			data[ButtonBase.DOWN] = down;
			backgroundBrush = new BMPBrush( data );
			
		}
		
		///////////////////////////////////
		// toString
		///////////////////////////////////
		
		override public function toString():String {
			return "[bloom.style.default.NSDecreaseStyle]";
		}
	}
}