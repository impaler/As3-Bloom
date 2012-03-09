package bloom.themes.blue 
{

import bloom.core.ScaleBitmap;
import bloom.components.ColorPickerStyle;

import flash.geom.Rectangle;

	/**
	 * BlueContainer
	 */
	public class BlueColorPicker extends ColorPickerStyle {
		
		[Embed(source="assets/container.png")]
		private static var bm0:Class;
		
		public function BlueColorPicker() {
			background = new ScaleBitmap(new bm0().bitmapData);
			background.scale9Grid = new Rectangle(7, 7, 2, 2);
			background.alpha = 0;
		}
		
		///////////////////////////////////
		// toString
		///////////////////////////////////
		
		override public function toString():String {
			return "[bloom.themes.blue.BlueColorPicker]";
		}
	}

}
