package bloom.themes.default 
{
	import bloom.core.ScaleBitmap;
	import bloom.core.StyleBase;
	
	/**
	 * CheckBoxStyle
	 */
	public class CheckBoxStyle extends StyleBase {
		
		[Embed(source = "assets/checkbox_off.png")]
		private var cb_normal:Class;
		
		[Embed(source = "assets/checkbox_on.png")]
		private var cb_selected:Class;
		
		public var title_normal:LabelStyle;
		public var title_selected:LabelStyle;
		
		public var normal:ScaleBitmap;
		public var selected:ScaleBitmap;
		
		public function CheckBoxStyle() {
			title_normal = new LabelStyle();
			title_normal.textFormat.font = "Verdana";
			title_normal.textFormat.size = 12;
			title_normal.textFormat.color = 0x666666;
			
			title_selected = new LabelStyle();
			title_selected.textFormat.font = "Verdana";
			title_selected.textFormat.size = 12;
			title_selected.textFormat.color = 0x000000;
			
			normal = new ScaleBitmap(new cb_normal().bitmapData);
			selected = new ScaleBitmap(new cb_selected().bitmapData);
		}
		
		///////////////////////////////////
		// toString
		///////////////////////////////////
		
		override public function toString():String {
			return "[bloom.themes.default.CheckBoxStyle]";
		}
		
	}

}