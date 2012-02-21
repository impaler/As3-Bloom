package bloom.themes.defaultTheme
{

import bloom.core.ScaleBitmap;
import bloom.style.ProgressBarStyle;

import flash.geom.Rectangle;

/**
	 * ProgressBarStyle
	 */
	public class DefaultProgressBarStyle extends ProgressBarStyle {
		
		[Embed(source="./assets/progress_bg.png")]
		private static var progress_bg:Class;
		
		[Embed(source="./assets/progress_bar.png")]
		private static var progress_bar:Class;
		
		public function DefaultProgressBarStyle() {
			bg = new ScaleBitmap(new progress_bg().bitmapData);
			bg.scale9Grid = new Rectangle(7, 7, 2, 2);
			bar = new ScaleBitmap(new progress_bar().bitmapData);
			bar.scale9Grid = new Rectangle(7, 7, 2, 2);
		}
		
		///////////////////////////////////
		// toString
		///////////////////////////////////
		
		override public function toString():String {
			return "[bloom.style.default.ProgressBarStyle]";
		}
		
	}

}