package bloom.styles 
{
	/**
	 * TabBoxContentStyle
	 */
	public class TabBoxContentStyle implements IStyle {
		
		public var title:ToggleButtonStyle;
		public var content:ContainerStyle;
		public var header:ContainerStyle;
		
		public function TabBoxContentStyle() {
			
		}
		
		///////////////////////////////////
		// toString
		///////////////////////////////////
		
		public function toString():String {
			return "[bloom.styles.TabBoxContentStyle]";
		}
	}

}