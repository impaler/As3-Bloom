package bloom.components 
{
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	
	import bloom.core.Component;
	import bloom.core.ThemeBase;
	import bloom.styles.IStyle;
	import bloom.styles.TabBoxContentStyle;
	
	/**
	 * TabBoxContent
	 */
	public class TabBoxContent {
		
		private var _style:IStyle;
		
		private var _title:ToggleButton;
		private var _content:FlowContainer;
		
		public function TabBoxContent(title:String = "", content:FlowContainer = null) {
			_title = new ToggleButton(null, title);
			if (content) {
				_content = content;
			} else {
				_content = new FlowContainer();
			}
			style = ThemeBase.theme.tabBoxContent;
		}
		
		public function dispose():void {
			if (_title.parent)_title.parent.removeChild(_title);
			_title.dispose();
			_title = null;
			if (_content.parent)_content.parent.removeChild(_content);
			_content.dispose();
			_content = null;
			_style = null;
		}
		
		///////////////////////////////////
		// getter/setters
		///////////////////////////////////
		
		public function get title():ToggleButton {
			return _title;
		}
		
		public function get content():FlowContainer {
			return _content;
		}
		
		public function get style():IStyle {
			return _style;
		}
		
		public function set style(value:IStyle):void {
			if (_style != value) {
				_style = value;
				if (_style) {
					var style:TabBoxContentStyle = _style as TabBoxContentStyle;
					_title.style = style.title;
					_content.style = style.content;
				}
			}
		}
		
		///////////////////////////////////
		// toString
		///////////////////////////////////
		
		public function toString():String {
			return "[bloom.components.TabBoxContent]";
		}
		
	}

}