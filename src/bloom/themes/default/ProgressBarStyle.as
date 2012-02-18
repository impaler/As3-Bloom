package bloom.themes.default 
{
	import flash.geom.Rectangle;
	
	import bloom.core.IStyleBase;
	import bloom.core.ScaleBitmap;
	
	/**
	 * ProgressBarStyle
	 */
	public class ProgressBarStyle implements IStyleBase {
		
		[Embed(source = "assets/progress_bg.png")]
		private static var progress_bg:Class;
		
		[Embed(source = "assets/progress_bar.png")]
		private static var progress_bar:Class;
		
		public var bg:ScaleBitmap;
		public var bar:ScaleBitmap;
		
		public function ProgressBarStyle() {
			bg = new ScaleBitmap(new progress_bg().bitmapData);
			bg.scale9Grid = new Rectangle(7, 7, 2, 2);
			bar = new ScaleBitmap(new progress_bar().bitmapData);
			bar.scale9Grid = new Rectangle(7, 7, 2, 2);
		}
		
		///////////////////////////////////
		// toString
		///////////////////////////////////
		
		public function toString():String {
			return "[bloom.themes.default.ProgressBarStyle]";
		}
		
	}

}