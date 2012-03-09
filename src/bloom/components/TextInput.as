package bloom.components 
{

import bloom.core.Component;
import bloom.core.TextBase;
import bloom.core.OmniCore;
import bloom.components.TextInputStyle;

import flash.display.BitmapData;
import flash.display.DisplayObjectContainer;
import flash.events.Event;
import flash.events.FocusEvent;
import flash.text.TextFieldType;

/**
	 * TextInput
	 */
	public class TextInput extends Component {
		
		private var _textBase:TextBase;
		
		private var background:BitmapData;
		
		private var active:Boolean = false;
		
		public function TextInput(p:DisplayObjectContainer = null, text:String = "") {
			super(p);
			
			_textBase = new TextBase(this);
			_textBase.text = text;
			_textBase.selectable = true;
			_textBase.multiline = false;
			_textBase.type = TextFieldType.INPUT;
			_textBase.onFocusedIn.add(onFocusedIn);
			_textBase.onFocusedOut.add(onFocusedOut);
			
			style = OmniCore.theme.textInput;
			size(100, 20);
		}
		
		override public function dispose (gc:Boolean = false):void {
			super.dispose (gc);
			if (background) background.dispose();
			background = null;
			removeChild(_textBase);
			_textBase.dispose (false);
			_textBase = null;
		}
		
		override protected function onThemeChanged():void {
			style = OmniCore.theme.textInput;
		}
		
		override protected function draw (e:Event = null):void {
			if (!_changed) return;
			_changed = false;
			
			var style:TextInputStyle = _style as TextInputStyle;
			if (background) background.dispose();
			
			graphics.clear();
			if (active) {
				_textBase.style = style.text_active;
				style.active.setSize(_width, _height);
				background = style.active.bitmapData.clone();
			} else {
				_textBase.style = style.text_normal;
				style.normal.setSize(_width, _height);
				background = style.normal.bitmapData.clone();
			}
			graphics.beginBitmapFill(background);
			graphics.drawRect(0, 0, _width, _height);
			graphics.endFill();
			
			_textBase.size(_width, _height);
		}
		
		private function onFocusedIn(e:FocusEvent):void {
			active = true;
			_changed = true;
			invalidate();
		}
		
		private function onFocusedOut(e:FocusEvent):void {
			active = false;
			_changed = true;
			invalidate();
		}
		
		///////////////////////////////////
		// getter/setters
		///////////////////////////////////
		
		override public function set enabled(value:Boolean):void {
			if (_enabled != value) {
				_textBase.tabEnabled = _enabled = mouseEnabled = mouseChildren = value;
				alpha = _enabled ? 1 : OmniCore.theme.alpha;
			}
		}
		
		public function get textBase():TextBase {
			return _textBase;
		}
		
		///////////////////////////////////
		// toString
		///////////////////////////////////
		
		public override function toString():String {
			return "[bloom.components.TextInput]";
		}
	}

}