package bloom.themes.default 
{
	import flash.geom.Rectangle;
	import bloom.core.ScaleBitmap;
	
	/**
	 * NSIncreaseStyle
	 */
	public class NSIncreaseStyle extends ButtonBaseStyle {
		
		[Embed(source = "assets/ns_increase_button_normal.png")]
		private static var bt_increase_normal:Class;
		
		[Embed(source = "assets/ns_increase_button_over.png")]
		private static var bt_increase_over:Class;
		
		[Embed(source = "assets/ns_increase_button_down.png")]
		private static var bt_increase_down:Class;
		
		public function NSIncreaseStyle() {
//			normal = new ScaleBitmap(new bt_increase_normal().bitmapData);
//			normal.scale9Grid = new Rectangle(2, 4, 13, 4);
//			over = new ScaleBitmap(new bt_increase_over().bitmapData);
//			over.scale9Grid = new Rectangle(2, 4, 13, 4);
//			down = new ScaleBitmap(new bt_increase_down().bitmapData);
//			down.scale9Grid = new Rectangle(2, 4, 13, 4);
		}
		
		///////////////////////////////////
		// toString
		///////////////////////////////////
		
		override public function toString():String {
			return "[bloom.themes.default.NSIncreaseStyle]";
		}
	}
}