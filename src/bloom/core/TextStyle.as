package bloom.core 
{
	import flash.text.TextFormat;
	
	/**
	 * TextStyle
	 */
	public class TextStyle extends StyleBase {
		
		public var textFormat:TextFormat;
		
		public function TextStyle(format:TextFormat) {
			textFormat = format ? format : new TextFormat();
		}
		
		///////////////////////////////////
		// toString
		///////////////////////////////////
		
		override public function toString():String {
			return "[bloom.core.TextStyle]";
		}
	}

}