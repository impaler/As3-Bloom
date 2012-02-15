package bloom.core 
{
	import flash.events.Event;
	
	/**
	 * StyleEvent
	 */
	public class StyleEvent extends Event {
		
		public static const REDRAW:String = "redraw";
		
		public function StyleEvent(type:String) {
			super(type);
		}
		
		///////////////////////////////////
		// toString
		///////////////////////////////////
		
		public override function toString():String {
			return "[bloom.core.StyleEvent]";
		}
		
	}

}