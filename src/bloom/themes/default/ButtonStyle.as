package bloom.themes.default 
{
	import bloom.core.TextStyle;
	
	/**
	 * ButtonStyle
	 */
	public class ButtonStyle extends ButtonBaseStyle {
		
		public var title_normal:TextStyle;
		public var title_over:TextStyle;
		public var title_down:TextStyle;
		
		public function ButtonStyle() {
			super();
			
			title_normal = new TextStyle();
			title_normal.textFormat.font = "Verdana";
			title_normal.textFormat.size = 12;
			title_normal.textFormat.color = 0xffffff;
			title_normal.textFormat.bold = false;
			
			title_over = new TextStyle();
			title_over.textFormat.font = "Verdana";
			title_over.textFormat.size = 12;
			title_over.textFormat.color = 0xffffff;
			title_over.textFormat.bold = true;
			
			title_down = new TextStyle();
			title_down.textFormat.font = "Verdana";
			title_down.textFormat.size = 12;
			title_down.textFormat.color = 0x000000;
			title_down.textFormat.bold = true;
		}
		
		///////////////////////////////////
		// toString
		///////////////////////////////////
		
		override public function toString():String {
			return "[bloom.themes.default.ButtonStyle]";
		}
		
	}

}