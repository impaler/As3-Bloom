package bloom.components 
{
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.text.TextFormat;
	
	import bloom.control.Bloom;
	import bloom.core.TextBase;
	
	/**
	 * Label
	 */
	public class Label extends TextBase {
		
		public function Label(p:DisplayObjectContainer = null, text:String = "") {
			super(p);
			
			selectable = mouseEnabled = tabEnabled = false;
			type = "dynamic";
			autoSize = "left";
			
			style = Bloom.theme.label;
			this.text = text;
			
			Bloom.onThemeChanged.add(onThemeChanged);
		}
		
		protected function onThemeChanged():void {
			style = Bloom.theme.label;
		}
		
		///////////////////////////////////
		// toString
		///////////////////////////////////
		
		override public function toString():String {
			return "[bloom.components.Label]";
		}
		
	}

}