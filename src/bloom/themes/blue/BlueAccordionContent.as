package bloom.themes.blue 
{
	import flash.display.BitmapData;
	
	import bloom.core.ScaleBitmap;
	import bloom.styles.AccordionContentStyle;
	import bloom.styles.ContainerStyle;
	
	/**
	 * BlueAccordionContent
	 */
	public class BlueAccordionContent extends AccordionContentStyle {
		
		public function BlueAccordionContent() {
			title = new BlueToggleButton();
			
			content = new ContainerStyle();
			content.background = new ScaleBitmap(new BitmapData(1, 1, false, 0xCCCCCC));
		}
		
		///////////////////////////////////
		// toString
		///////////////////////////////////
		
		override public function toString():String {
			return "[bloom.themes.blue.BlueAccordionContent]";
		}
		
	}

}