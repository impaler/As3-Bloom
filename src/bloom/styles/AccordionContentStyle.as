package bloom.styles 
{
	/**
	 * AccordionContentStyle
	 */
	public class AccordionContentStyle implements IStyle {
		
		public var title:ToggleButtonStyle;
		public var content:ContainerStyle;
		
		public function AccordionContentStyle() {
			
		}
		
		///////////////////////////////////
		// toString
		///////////////////////////////////
		
		public function toString():String {
			return "[bloom.styles.AccordionContentStyle]";
		}
	}

}