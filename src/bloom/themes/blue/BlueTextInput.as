package bloom.themes.blue 
{
	import flash.geom.Rectangle;
	
	import bloom.core.ScaleBitmap;
	import bloom.styles.TextInputStyle;
	import bloom.styles.TextStyle;
	
	/**
	 * BlueTextInput
	 */
	public class BlueTextInput extends TextInputStyle {
		
		[Embed(source="assets/text_normal.png")]
		private static var bm0:Class;
		
		[Embed(source="assets/text_active.png")]
		private static var bm1:Class;
		
		public function BlueTextInput() {
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
		}
		
		///////////////////////////////////
		// toString
		///////////////////////////////////
		
		override public function toString():String {
			return "[bloom.themes.blue.BlueTextInput]";
		}
		
	}

}