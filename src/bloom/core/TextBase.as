package bloom.core 
{
	import flash.display.DisplayObjectContainer;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import bloom.control.Bloom;
	
	/**
	 * TextBase
	 */
	public class TextBase extends TextField implements IComponent {
		
		protected var _style:TextStyle;
		
		protected var _margin:Margin;
		
		protected var _enabled:Boolean = true;
		
		public function TextBase(p:DisplayObjectContainer = null) {
			super();
			_margin = new Margin();
			if (p) p.addChild(this);
		}
		
		public function move(x:Number, y:Number):void {
			this.x = x;
			this.y = y;
		}
		
		public function size(w:Number, h:Number):void {
			width = w;
			height = h;
		}
		
		///////////////////////////////////
		// getter/setters
		///////////////////////////////////
		
		public function set style(value:TextStyle):void {
			if (_style != value) {
				_style = value;
				if (_style) {
					defaultTextFormat = _style.textFormat;
					setTextFormat(defaultTextFormat);
				}
			}
		}
		
		public function get style():TextStyle {
			return _style;
		}
		
		public function set enabled(value:Boolean):void {
			if (_enabled != value) {
				_enabled = tabEnabled = mouseEnabled = value;
				alpha = _enabled ? 1 : Bloom.theme.alpha;
			}
		}
		
		public function get enabled():Boolean {
			return _enabled;
		}
		
		public function get margin():Margin {
			return _margin;
		}
		
		///////////////////////////////////
		// toString
		///////////////////////////////////
		
		override public function toString():String {
			return "[bloom.core.TextBase]";
		}

		public function destroy ():void {
			_style = null;
		}
	}

}