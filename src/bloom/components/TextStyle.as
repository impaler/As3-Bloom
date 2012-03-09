package bloom.components 
{
	import flash.text.TextFormat;
	
	/**
	 * TextStyle
	 */
	public class TextStyle implements IStyle {
		
		public var textFormat:TextFormat;
		
		public function TextStyle(format:TextFormat = null) {
			textFormat = format ? format : new TextFormat();
		}
		
		///////////////////////////////////
		// toString
		///////////////////////////////////
		
		public function toString():String {
			return "[bloom.styles.TextStyle]";
		}
	}

}