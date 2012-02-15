package bloom.components 
{
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.text.TextFormat;
	
	import bloom.control.ThemeBase;
	import bloom.core.StyleEvent;
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
			
			style = ThemeBase.theme.label;
			this.text = text;
			
			ThemeBase.dispatcher.addEventListener(StyleEvent.REDRAW, onThemeChanged);
		}
		
		protected function onThemeChanged(e:StyleEvent):void {
			style = ThemeBase.theme.label;
		}
		
		///////////////////////////////////
		// toString
		///////////////////////////////////
		
		override public function toString():String {
			return "[bloom.components.Label]";
		}
		
	}

}