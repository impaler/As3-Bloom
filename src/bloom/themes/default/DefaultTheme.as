package bloom.themes.default 
{	
	import bloom.control.ObjectPool;
	import bloom.control.ThemeBase;
	
	/**
	 * DefaultTheme
	 */
	public class DefaultTheme {
		
		public function DefaultTheme() {
			label = ObjectPool.getObject(LabelStyle) as LabelStyle;
			button = ObjectPool.getObject(ButtonStyle) as ButtonStyle;
			buttonBase = ObjectPool.getObject(ButtonBaseStyle) as ButtonBaseStyle;
			checkBox = ObjectPool.getObject(CheckBoxStyle) as CheckBoxStyle;
		}
		
		///////////////////////////////////
		// Global
		///////////////////////////////////
		
		public var alpha:Number = 0.5;
		public var focus:uint = 0xEEDD88;
		
		///////////////////////////////////
		// Components
		///////////////////////////////////
		
		public var label:LabelStyle;
		
		public var button:ButtonStyle;
		
		public var buttonBase:ButtonBaseStyle;
		
		public var checkBox:CheckBoxStyle;
		
		///////////////////////////////////
		// toString
		///////////////////////////////////
		
		public function toString():String {
			return "[bloom.themes.default.DefaultTheme]";
		}
		
	}

}