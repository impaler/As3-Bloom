package bloom.core 
{
	import flash.events.EventDispatcher;
	
	[StyleEvent(name = "redraw", type = "bloom.core.StyleEvent")]
	
	/**
	 * StyleBase
	 */
	public class StyleBase extends EventDispatcher implements IStyle {
		
		public function StyleBase() {
			
		}
		
		public function update():void {
			dispatchEvent(new StyleEvent(StyleEvent.REDRAW));
		}
		
		///////////////////////////////////
		// toString
		///////////////////////////////////
		
		public function toString():String {
			return "[bloom.core.StyleBase]";
		}
	}

}