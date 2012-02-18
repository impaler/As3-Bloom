package bloom.themes.default 
{
	import flash.geom.Rectangle;
	
	import bloom.core.IStyleBase;
	import bloom.core.ScaleBitmap;
	import bloom.core.TextStyle;
	
	/**
	 * TextInputStyle
	 */
	public class TextInputStyle implements IStyleBase {
		
		[Embed(source = "assets/text_normal.png")]
		private var ti_normal:Class;
		
		[Embed(source = "assets/text_active.png")]
		private var ti_active:Class;
		
		public var normal:ScaleBitmap;
		public var active:ScaleBitmap;
		
		public var title_normal:TextStyle;
		public var title_active:TextStyle;
		
		public function TextInputStyle() {
			normal = new ScaleBitmap(new ti_normal().bitmapData);
			normal.scale9Grid = new Rectangle(13, 15, 51, 12);
			
			active = new ScaleBitmap(new ti_active().bitmapData);
			active.scale9Grid = new Rectangle(13, 15, 51, 12);
			
			title_normal = new TextStyle();
			title_normal.textFormat.font = "Verdana";
			title_normal.textFormat.size = 12;
			title_normal.textFormat.color = 0x666666;
			
			title_active = new TextStyle();
			title_active.textFormat.font = "Verdana";
			title_active.textFormat.size = 12;
			title_active.textFormat.color = 0x000000;
		}
		
		///////////////////////////////////
		// toString
		///////////////////////////////////
		
		public function toString():String {
			return "[bloom.themes.default.TextInputStyle]";
		}
		
	}

}