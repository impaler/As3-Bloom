package bloom.themes.blue 
{
	import flash.geom.Rectangle;
	
	import bloom.core.ScaleBitmap;
	import bloom.components.ContainerStyle;
	
	/**
	 * BlueContainer
	 */
	public class BlueContainer extends ContainerStyle {
		
		[Embed(source="assets/container.png")]
		private static var bm0:Class;
		
		public function BlueContainer() {
			background = new ScaleBitmap(new bm0().bitmapData);
			background.scale9Grid = new Rectangle(7, 7, 2, 2);
		}
		
		///////////////////////////////////
		// toString
		///////////////////////////////////
		
		override public function toString():String {
			return "[bloom.themes.blue.BlueButtonBase]";
		}
	}

}