package bloom.core 
{

import bloom.components.TextStyle;

import flash.display.DisplayObjectContainer;
import flash.events.Event;
import flash.events.FocusEvent;
import flash.text.TextField;

import org.osflash.signals.natives.NativeSignal;

/**
	 * TextBase
	 */
	public class TextBase extends TextField implements IComponent {
		
		protected var _style:TextStyle;
		
		protected var _margin:Margin;
		protected var _enabled:Boolean = true;
		
		protected var _onTextChanged:NativeSignal;
		protected var _onFocusedIn:NativeSignal;
		protected var _onFocusedOut:NativeSignal;
		protected var _onTextScroll:NativeSignal;
		
		public function TextBase(p:DisplayObjectContainer = null) {
			super();
			
			_margin = new Margin();
			if (p) p.addChild(this);
			
			_onTextChanged = new NativeSignal(this, Event.CHANGE, Event);
			
			OmniCore.onThemeChanged.add(onThemeChanged);
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
		
		public function dispose (gc:Boolean = false):void {
			OmniCore.onThemeChanged.remove(onThemeChanged);
			_style = null;
			_onTextChanged.removeAll();
			_onTextChanged = null;
			if (_onFocusedIn) _onFocusedIn.removeAll();
			_onFocusedIn = null;
			if (_onFocusedOut) _onFocusedOut.removeAll();
			_onFocusedOut = null;
		}
		
		protected function onThemeChanged():void {
			
		}
		
		///////////////////////////////////
		// getter/setters
		///////////////////////////////////
		
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
				alpha = _enabled ? 1 : OmniCore.theme.alpha;
			}
		}
		
		public function get margin():Margin {
			return _margin;
		}
		
		public function get onTextChanged():NativeSignal {
			return _onTextChanged;
		}
		
		public function get onFocusedIn():NativeSignal {
			if (!_onFocusedIn)_onFocusedIn = new NativeSignal(this, FocusEvent.FOCUS_IN, FocusEvent);
			return _onFocusedIn;
		}
		
		public function get onFocusedOut():NativeSignal {
			if (!_onFocusedOut)_onFocusedOut = new NativeSignal(this, FocusEvent.FOCUS_OUT, FocusEvent);
			return _onFocusedOut;
		}
		
		public function get onTextScroll():NativeSignal {
			if (!_onTextScroll)_onTextScroll = new NativeSignal(this, Event.SCROLL, Event);
			return _onTextScroll;
		}
		
		///////////////////////////////////
		// toString
		///////////////////////////////////
		
		override public function toString():String {
			return "[bloom.core.TextBase]";
		}
		
	}
}