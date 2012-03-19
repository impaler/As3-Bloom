package bloom.components.containers
{

import bloom.components.controls.ToggleButton;

/**
	 * TabBoxContent
	 */
	public class TabBoxContent {


		private var _title:ToggleButton;
		private var _content:Container;

		public function TabBoxContent(title:String = "", content:Container = null) {
//			_title = new ToggleButton(null, title);
//			_title.lock = true;
//			if (content) {
//				_content = content;
//			} else {
//				_content = new FlowContainer();
//			}
//			_content.lock = true;
//			style = ThemeBase.theme.tabBox;
		}

/*		public function dispose():void {
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
					var style:TabBoxStyle = _style as TabBoxStyle;
					_title.style = style.title;
					_content.style = style.content;
				}
			}
		}*/

		///////////////////////////////////
		// toString
		///////////////////////////////////

		public function toString():String {
			return "[bloom.components.TabBoxContent]";
		}

	}

}
