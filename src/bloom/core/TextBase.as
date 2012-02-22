package bloom.core 
{
	// i wonder what IDE you are using.
	// it seems very diffrernt with flash develop's default style.
	
	// first, flash native classes.
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.text.TextField;
	
	// then, 3rd part libs.
	import org.osflash.signals.natives.NativeSignal;
	
	// then, bloom native classes.
	import bloom.control.ThemeBase;
	import bloom.styles.TextStyle;
	
	/**
	 * TextBase
	 */
	public class TextBase extends TextField implements IComponent {
		
		// we don't need a static const "input", since adobe's native class has it.
		// try to make things simple and clear. delete all unnecessary objects.
		
		protected var _style:TextStyle;
		
		protected var _margin:Margin;
		protected var _enabled:Boolean = true;
		
		// passive word is recommanded when using signals.
		// use _xxx when this var will have it's getter/setter.
		// if not just directly use xxx.
		protected var _onTextChanged:NativeSignal;
		protected var _onFocusedIn:NativeSignal;
		protected var _onFocusedOut:NativeSignal;
		
		public function TextBase(p:DisplayObjectContainer = null) {
			super();
			_margin = new Margin();
			if (p) p.addChild(this);
			_onTextChanged = new NativeSignal(this, Event.CHANGE, Event);
		}
		
		public function move(x:Number, y:Number):void {
			this.x = x;
			this.y = y;
		}
		
		public function size(width:Number, height:Number):void {
			this.width = width;
			this.height = height;
		}
		
		public function drawDirectly():void {
			
		}
		
		// put public functions first, then protected, then private, then getter setters, toString() comes last.
		public function destroy():void {
			_style = null;
			_onTextChanged.removeAll();
			_onTextChanged = null;
			if (_onFocusedIn) _onFocusedIn.removeAll();
			_onFocusedIn = null;
			if (_onFocusedOut) _onFocusedOut.removeAll();
			_onFocusedOut = null;
		}
		
		///////////////////////////////////
		// getter/setters
		///////////////////////////////////
		
		// getter/setter s' getter comes first.
		public function get style():TextStyle {
			return _style;
		}
		
		public function set style(value:TextStyle):void {
			if (_style != value) {
				_style = value;
				if (_style) {
					defaultTextFormat = _style.textFormat;
					setTextFormat(defaultTextFormat);
				}
			}
		}
		
		public function get enabled():Boolean {
			return _enabled;
		}
		
		public function set enabled(value:Boolean):void {
			if (_enabled != value) {
				_enabled = tabEnabled = mouseEnabled = value;
				//alpha = _enabled ? 1 : BloomCore.theme.disabledAlpha;
				// try to make classses name or objects' name simple and short and cool.
				// since it's in bloom.control, i think it should be sth like ThemeBase.
				alpha = _enabled ? 1 : ThemeBase.theme.alpha;
			}
		}
		
		public function get margin():Margin {
			return _margin;
		}
		
		public function get onTextChanged():NativeSignal {
			return _onTextChanged;
		}
		
		public function get onFocusedIn():NativeSignal {
			if (!_onFocusedIn) _onFocusedIn = new NativeSignal(this, FocusEvent.FOCUS_IN, FocusEvent);
			return _onFocusedIn;
		}
		
		public function get onFocusedOut():NativeSignal {
			if (!_onFocusedOut) _onFocusedOut = new NativeSignal(this, FocusEvent.FOCUS_OUT, FocusEvent);
			return _onFocusedOut;
		}
		
		///////////////////////////////////
		// toString
		///////////////////////////////////
		
		override public function toString():String {
			return "[bloom.core.TextBase]";
		}
		
	}
}