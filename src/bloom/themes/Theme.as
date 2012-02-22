package bloom.themes 
{
	import bloom.styles.*;
	
	/**
	 * Theme
	 */
	public class Theme implements ITheme {
		
		protected var _alpha:Number = 0.5;
		
		protected var _label:TextStyle;
		protected var _buttonBase:ButtonBaseStyle;
		
		public function Theme() {
			
		}
		
		///////////////////////////////////
		// getter/setters
		///////////////////////////////////
		
		public function get alpha():Number {
			return _alpha;
		}
		
		public function get buttonBase():ButtonBaseStyle {
			return _buttonBase;
		}
		
		public function get label():TextStyle {
			return _label;
		}
		
		///////////////////////////////////
		// toString
		///////////////////////////////////
		
		public function toString():String {
			return "[bloom.themes.blue]";
		}
	}

}