package bloom.core 
{
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
import flash.events.FocusEvent;
import flash.text.TextField;
	
	import bloom.control.Bloom;
	
	import org.osflash.signals.Signal;
	
	import org.osflash.signals.natives.NativeSignal;

/**
	 * TextBase
	 */
	public class TextBase extends TextField implements IComponent {
		
		public static const INPUT:String = "input";
	
		protected var _style:TextStyle;
		
		protected var _margin:Margin;
		protected var _enabled:Boolean = true;
		
		protected var _onTextChange:Signal;
		protected var _onChange:NativeSignal;
		protected var _onFocusIn:NativeSignal;
		protected var _onFocusOut:NativeSignal;
		
		public function TextBase(p:DisplayObjectContainer = null) {
			super();
			_margin = new Margin();
			_onChange = new NativeSignal( this, Event.CHANGE, Event);
			_onChange.add(onTitleChanged);
			_onTextChange = new Signal(String);
			if (p) p.addChild(this);
		}

		private function onTitleChanged (e:Event):void {
			_onTextChange.dispatch(text);
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
	
		public function get onTextChange():Signal {
			return _onTextChange;
		}
	
		public function get onFocusIn ():NativeSignal {
			if ( _onFocusIn == null ) 
				_onFocusIn = new NativeSignal(this, FocusEvent.FOCUS_IN, FocusEvent);
			
			return _onFocusIn;
		}
	
		public function get onFocusOut ():NativeSignal {
			if ( _onFocusOut == null ) 
				_onFocusOut = new NativeSignal(this, FocusEvent.FOCUS_OUT, FocusEvent);
			
			return _onFocusOut;
		}	
		
		///////////////////////////////////
		// toString
		///////////////////////////////////
		
		override public function toString():String {
			return "[bloom.core.TextBase]";
		}

		public function destroy ():void {
			_style = null;
			
			_onChange.removeAll();
			_onChange = null;
			_onTextChange.removeAll();
			_onTextChange = null;
			if ( _onFocusIn != null) _onFocusIn.removeAll();
			_onFocusIn = null;
			if ( _onFocusOut != null) _onFocusOut.removeAll();
			_onFocusOut = null;
		}
	
}

}