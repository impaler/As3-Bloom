package bloom.themes.blue
{
	import flash.geom.Rectangle;
	
	import bloom.core.ScaleBitmap;
	import bloom.styles.ButtonBaseStyle;
	
	/**
	 * BlueButtonBase
	 */
	public class BlueButtonBase extends ButtonBaseStyle {
		
		[Embed(source="assets/button_normal.png")]
		private static var bt_normal:Class;
		
		[Embed(source="assets/button_down.png")]
		private static var bt_down:Class;
		
		[Embed(source="assets/button_over.png")]
		private static var bt_over:Class;
		
		public function BlueButtonBase() {
			normal = new ScaleBitmap(new bt_normal().bitmapData);
			normal.scale9Grid = new Rectangle(15, 15, 70, 14);
			over = new ScaleBitmap(new bt_over().bitmapData);
			over.scale9Grid = new Rectangle(15, 15, 70, 14);
			down = new ScaleBitmap(new bt_down().bitmapData);
			down.scale9Grid = new Rectangle(15, 15, 70, 14);
		}
		
		///////////////////////////////////
		// toString
		///////////////////////////////////
		
		override public function toString():String {
			return "[bloom.themes.blue.BlueButtonBase]";
		}
		
	}

}