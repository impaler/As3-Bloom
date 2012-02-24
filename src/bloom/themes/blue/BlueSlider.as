package bloom.themes.blue 
{
	import flash.geom.Rectangle;
	
	import bloom.core.ScaleBitmap;
	import bloom.styles.ButtonBaseStyle;
	import bloom.styles.SliderStyle;
	
	/**
	 * BlueSlider
	 */
	public class BlueSlider extends SliderStyle {
		
		[Embed(source="assets/slider.png")]
		private static var bm0:Class;
		
		[Embed(source="assets/slider_normal.png")]
		private static var bm1:Class;
		
		[Embed(source="assets/slider_over.png")]
		private static var bm2:Class;
		
		[Embed(source="assets/slider_down.png")]
		private static var bm3:Class;
		
		public function BlueSlider() {
			background = new ScaleBitmap(new bm0().bitmapData);
			background.scale9Grid = new Rectangle(7, 7, 2, 2);
			
			button = new ButtonBaseStyle();
			button.normal = new ScaleBitmap(new bm1().bitmapData);
			button.normal.scale9Grid = new Rectangle(7, 7, 2, 2);
			button.over = new ScaleBitmap(new bm2().bitmapData);
			button.over.scale9Grid = new Rectangle(7, 7, 2, 2);
			button.down = new ScaleBitmap(new bm3().bitmapData);
			button.down.scale9Grid = new Rectangle(7, 7, 2, 2);
		}
		
		///////////////////////////////////
		// toString
		///////////////////////////////////
		
		override public function toString():String {
			return "[bloom.themes.blue.BlueSlider]";
		}
	}

}