package bloom.core 
{
	import flash.display.DisplayObjectContainer;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import bloom.control.ThemeBase;
	
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
		
		protected function onStyleChanged(e:StyleEvent):void {
			if (defaultTextFormat != _style.textFormat) {
				defaultTextFormat = _style.textFormat;
				setTextFormat(defaultTextFormat);
			}
		}
		
		///////////////////////////////////
		// getter/setters
		///////////////////////////////////
		
		public function set style(value:TextStyle):void {
			if (_style != value) {
				if (_style) _style.removeEventListener(StyleEvent.REDRAW, onStyleChanged);
				_style = value;
				if (_style) {
					onStyleChanged(null);
					_style.addEventListener(StyleEvent.REDRAW, onStyleChanged);
				}
			}
		}
		
		public function get style():TextStyle {
			return _style;
		}
		
		public function set enabled(value:Boolean):void {
			if (_enabled != value) {
				_enabled = tabEnabled = mouseEnabled = value;
				alpha = _enabled ? 1 : ThemeBase.theme.alpha;
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
		
	}

}