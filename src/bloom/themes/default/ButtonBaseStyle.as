package bloom.themes.default 
{

import bloom.brush.BMPBrush;
import bloom.brush.Brush;
import bloom.components.ButtonBase;

import flash.geom.Rectangle;
	
	import bloom.core.IStyleBase;
	import bloom.core.ScaleBitmap;
	
	/**
	 * ButtonBaseStyle
	 */
	public class ButtonBaseStyle implements IStyleBase {
		
		[Embed(source = "assets/button_normal.png")]
		private static var bt_normal:Class;
		
		[Embed(source = "assets/button_down.png")]
		private static var bt_down:Class;
		
		[Embed(source = "assets/button_over.png")]
		private static var bt_over:Class;
		
		public var backgroundBrush:Brush;
		
		public function ButtonBaseStyle() {
			
			var normal:ScaleBitmap = new ScaleBitmap(new bt_normal().bitmapData);
			normal.scale9Grid = new Rectangle(15, 15, 70, 14);
			var over:ScaleBitmap = new ScaleBitmap(new bt_over().bitmapData);
			over.scale9Grid = new Rectangle(15, 15, 70, 14);
			var down:ScaleBitmap = new ScaleBitmap(new bt_down().bitmapData);
			down.scale9Grid = new Rectangle(15, 15, 70, 14);
			
			var data:Vector.<ScaleBitmap> = new Vector.<ScaleBitmap> ( 3 , true );
			data[ButtonBase.NORMAL] = normal;
			data[ButtonBase.OVER] = over;
			data[ButtonBase.DOWN] = down;
			backgroundBrush = new BMPBrush( data );

		}
		
		///////////////////////////////////
		// toString
		///////////////////////////////////
		
		public function toString():String {
			return "[bloom.themes.default.ButtonBaseStyle]";
		}
		
	}

}