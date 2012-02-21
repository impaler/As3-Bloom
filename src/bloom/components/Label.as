package bloom.components 
{
	import flash.display.DisplayObjectContainer;
	
	import bloom.control.BloomCore;
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
			
			style = BloomCore.theme.labelStyle;
			this.text = text;
			
			BloomCore.onThemeChanged.add(onThemeChanged);
		}
		
		protected function onThemeChanged():void {
			style = BloomCore.theme.labelStyle;
		}
		
		///////////////////////////////////
		// toString
		///////////////////////////////////
		
		override public function toString():String {
			return "[bloom.components.Label]";
		}
		
		override public function destroy () : void {
			super.destroy();
			
			BloomCore.onThemeChanged.remove(onThemeChanged);
		}
		
	}

}