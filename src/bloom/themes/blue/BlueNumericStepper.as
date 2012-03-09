package bloom.themes.blue 
{
	import flash.geom.Rectangle;
	
	import bloom.core.ScaleBitmap;
	import bloom.components.ButtonBaseStyle;
	import bloom.components.TextStyle;
	import bloom.components.NumericStepperStyle;
	
	/**
	 * BlueNumericStepper
	 */
	public class BlueNumericStepper extends NumericStepperStyle {
		
		[Embed(source="assets/text_normal.png")]
		private static var bm0:Class;
		
		[Embed(source="assets/text_active.png")]
		private static var bm1:Class;
		
		[Embed(source="assets/increase_normal.png")]
		private static var bm2:Class;
		
		[Embed(source="assets/increase_over.png")]
		private static var bm3:Class;
		
		[Embed(source="assets/increase_down.png")]
		private static var bm4:Class;
		
		[Embed(source="assets/decrease_normal.png")]
		private static var bm5:Class;
		
		[Embed(source="assets/decrease_over.png")]
		private static var bm6:Class;
		
		[Embed(source="assets/decrease_down.png")]
		private static var bm7:Class;
		
		public function BlueNumericStepper() {
			text_normal = new TextStyle();
			text_normal.textFormat.font = "Verdana";
			text_normal.textFormat.size = 12;
			text_normal.textFormat.color = 0x666666;
			
			text_active = new TextStyle();
			text_active.textFormat.font = "Verdana";
			text_active.textFormat.size = 12;
			text_active.textFormat.color = 0x000000;
			
			normal = new ScaleBitmap(new bm0().bitmapData);
			normal.scale9Grid = new Rectangle(13, 15, 51, 12);
			active = new ScaleBitmap(new bm1().bitmapData);
			active.scale9Grid = new Rectangle(13, 15, 51, 12);
			
			increase = new ButtonBaseStyle();
			increase.normal = new ScaleBitmap(new bm2().bitmapData);
			increase.normal.scale9Grid = new Rectangle(2, 2, 13, 4);
			increase.over = new ScaleBitmap(new bm3().bitmapData);
			increase.over.scale9Grid = new Rectangle(2, 2, 13, 4);
			increase.down = new ScaleBitmap(new bm4().bitmapData);
			increase.down.scale9Grid = new Rectangle(2, 2, 13, 4);
			
			decrease = new ButtonBaseStyle();
			decrease.normal = new ScaleBitmap(new bm5().bitmapData);
			decrease.normal.scale9Grid = new Rectangle(2, 2, 13, 4);
			decrease.over = new ScaleBitmap(new bm6().bitmapData);
			decrease.over.scale9Grid = new Rectangle(2, 2, 13, 4);
			decrease.down = new ScaleBitmap(new bm7().bitmapData);
			decrease.down.scale9Grid = new Rectangle(2, 2, 13, 4);
		}
		
		///////////////////////////////////
		// toString
		///////////////////////////////////
		
		override public function toString():String {
			return "[bloom.themes.blue.BlueNumericStepper]";
		}
	}

}