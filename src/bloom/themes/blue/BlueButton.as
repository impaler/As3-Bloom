package bloom.themes.blue 
{
	import flash.geom.Rectangle;
	
	import bloom.core.ScaleBitmap;
	import bloom.components.ButtonStyle;
	import bloom.components.TextStyle;
	
	/**
	 * BlueButton
	 */
	public class BlueButton extends ButtonStyle {
		
		[Embed(source="assets/button_normal.png")]
		private static var bm0:Class;
		
		[Embed(source="assets/button_over.png")]
		private static var bm1:Class;
		
		[Embed(source="assets/button_down.png")]
		private static var bm2:Class;
		
		public function BlueButton() {
			title_normal = new TextStyle();
			title_normal.textFormat.font = "Verdana";
			title_normal.textFormat.size = 12;
			title_normal.textFormat.color = 0xffffff;
			
			title_over = new TextStyle();
			title_over.textFormat.font = "Verdana";
			title_over.textFormat.size = 12;
			title_over.textFormat.color = 0xffffff;
			
			title_down = new TextStyle();
			title_down.textFormat.font = "Verdana";
			title_down.textFormat.size = 12;
			title_down.textFormat.color = 0x000000;
			
			normal = new ScaleBitmap(new bm0().bitmapData);
			normal.scale9Grid = new Rectangle(15, 15, 70, 14);
			over = new ScaleBitmap(new bm1().bitmapData);
			over.scale9Grid = new Rectangle(15, 15, 70, 14);
			down = new ScaleBitmap(new bm2().bitmapData);
			down.scale9Grid = new Rectangle(15, 15, 70, 14);
		}
		
		///////////////////////////////////
		// toString
		///////////////////////////////////
		
		override public function toString():String {
			return "[bloom.themes.blue.BlueButton]";
		}
		
	}

}