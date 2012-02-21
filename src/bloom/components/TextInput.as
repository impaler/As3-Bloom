package bloom.components 
{

import bloom.style.TextInputStyle;

import flash.display.DisplayObjectContainer;
import flash.display.Shape;
import flash.events.Event;
import flash.events.FocusEvent;

import bloom.control.BloomCore;
import bloom.core.Component;
import bloom.core.TextBase;

import org.osflash.signals.Signal;


/**
	 * TextInput
	 */
	public class TextInput extends Component {
		
		protected var _bg:Shape;
		protected var _textBase:TextBase;
		
		protected var _focused:Boolean = false;
	
		public var onTextChange:Signal;
		
		public function TextInput(p:DisplayObjectContainer = null, text:String = "") {
			super(p);
			
			_bg = new Shape();
			addChild(_bg);
			
			_textBase = new TextBase(this);
			_textBase.selectable = true;
			_textBase.multiline = false;
			_textBase.type = "input";
			_textBase.text = text;
			
			style = BloomCore.theme.textInputStyle;
			
			size(100, 20);
			
			onTextChange = _textBase.onTextChange;
			
			_textBase.onFocusIn.add(onFocusIn);
			_textBase.onFocusOut.add(onFocusOut);
		}
		
		protected function onThemeChanged():void {
			style = BloomCore.theme.textInputStyle;
		}
		
		override protected function draw(e:Event):void {
			if (_changed) {
				_changed = false;
			} else {
				return;
			}
			
			var style:TextInputStyle = _style as TextInputStyle;
			
			_bg.graphics.clear();
			
			if (_focused) {
				style.active.setSize(_width, _height);
				_bg.graphics.beginBitmapFill(style.active.bitmapData);
				_textBase.style = style.text_active;
			} else {
				style.normal.setSize(_width, _height);
				_bg.graphics.beginBitmapFill(style.normal.bitmapData);
				_textBase.style = style.text_normal;
			}
			
			_bg.graphics.drawRect(0, 0, _width, _height);
			_bg.graphics.endFill();
			
			_textBase.size(_width, _height);
		}
		
		///////////////////////////////////
		// protected methods
		///////////////////////////////////
		
		protected function onFocusIn(e:FocusEvent):void {
			_focused = true;
			_changed = true;
			invalidate();
		}
		
		protected function onFocusOut(e:FocusEvent):void {
			_focused = false;
			_changed = true;
			invalidate();
		}
		
		///////////////////////////////////
		// getter/setters
		///////////////////////////////////
		
		override public function set enabled(value:Boolean):void {
			if (_enabled != value) {
				_enabled = _textBase.tabEnabled = mouseEnabled = mouseChildren = value;
				alpha = _enabled ? 1 : BloomCore.theme.disabledAlpha;
			}
		}
		
		public function set text(value:String):void {
			_textBase.text = value;
		}
		
		public function get text():String {
			return _textBase.text;
		}
		
		public function get textBase():TextBase {
			return _textBase;
		}
		
		///////////////////////////////////
		// toString
		///////////////////////////////////
		
		override public function toString():String {
			return "[bloom.components.TextInput]";
		}
		
		override public function destroy () : void {
			super.destroy();

			_textBase.destroy();
			_textBase = null;
			_bg = null;
		}
	}

}