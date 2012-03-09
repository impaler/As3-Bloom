package bloom.components 
{

import bloom.core.OmniCore;
import bloom.components.ButtonStyle;

import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.events.Event;

/**
	 * Button
	 */
	public class Button extends ButtonBase {
		
		protected var _title:Label;
		protected var _icon:DisplayObject;
		
		public function Button(p:DisplayObjectContainer = null, title:String = "") {
			super(p);
			
			_title = new Label(this, title);
			_title.onTextChanged.add(onTitleChanged);
			
			style = OmniCore.theme.button;
		}
		
		protected function onTitleChanged(e:Event):void {
			if (_icon) {
				_icon.x = (_width - _icon.width - _title.margin.left - _title.width) * 0.5;
				_icon.y = (_height - _icon.height) * 0.5;
				_title.x = _icon.x + _icon.width + _title.margin.left;
			} else {
				_title.x = (_width - _title.width) * 0.5;
			}
			_title.y = (_height - _title.height) * 0.5;
		}
		
		override public function dispose (gc:Boolean = false):void {
			super.dispose (gc);
			removeChild(_title);
			_title.dispose (false);
			_title = null;
			if (_icon) removeChild(_icon);
			_icon = null;
		}
		
		override protected function onThemeChanged():void {
			style = OmniCore.theme.buttonBase;
		}
		
		override protected function draw (e:Event = null):void {
			if (!_changed) return;
			_changed = false;
			
			var style:ButtonStyle = _style as ButtonStyle;
			if (background) background.dispose();
			
			graphics.clear();
			switch(state){
				case NORMAL:
					_title.style = style.title_normal;
					style.normal.setSize(_width, _height);
					background = style.normal.bitmapData.clone();
					break;
				case OVER:
					_title.style = style.title_over;
					style.over.setSize(_width, _height);
					background = style.over.bitmapData.clone();
					break;
				case DOWN:
					_title.style = style.title_down;
					style.down.setSize(_width, _height);
					background = style.down.bitmapData.clone();
					break;
			}
			graphics.beginBitmapFill(background);
			graphics.drawRect(0, 0, _width, _height);
			graphics.endFill();
			
			onTitleChanged(null);
		}
		
		///////////////////////////////////
		// getter/setters
		///////////////////////////////////
		
		public function get icon():DisplayObject {
			return _icon;
		}
		
		public function set icon(value:DisplayObject):void {
			if (_icon != value) {
				if (_icon) removeChild(_icon);
				_icon = value;
				if (_icon) {
					addChild(_icon);
					onTitleChanged(null);
				}
			}
		}
		
		public function get title():Label {
			return _title;
		}
		
		///////////////////////////////////
		// toString
		///////////////////////////////////
		
		public override function toString():String {
			return "[bloom.components.Button]";
		}
		
	}

}