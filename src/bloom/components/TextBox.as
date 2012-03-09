package bloom.components 
{
	import flash.display.BitmapData;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.text.TextFieldType;
	
	import bloom.core.Component;
	import bloom.core.TextBase;
	import bloom.core.ThemeBase;
	import bloom.styles.TextBoxStyle;
	
	/**
	 * TextBox
	 */
	public class TextBox extends Component {
		
		private var _scrollBar:ScrollBar;
		private var _textBase:TextBase;
		
		private var background:BitmapData;
		
		private var active:Boolean = false;
		private var moving:Boolean = false;
		
		public function TextBox(p:DisplayObjectContainer = null, text:String = "") {
			super(p);
			_textBase = new TextBase(this);
			_textBase.multiline = true;
			_textBase.wordWrap = true;
			_textBase.selectable = true;
			_textBase.text = text;
			_textBase.type = TextFieldType.INPUT;
			_textBase.onTextChanged.add(onTextChanged);
			_textBase.onTextScroll.add(onTextScroll);
			_textBase.onFocusedIn.add(onFocusedIn);
			_textBase.onFocusedOut.add(onFocusedOut);
			
			_scrollBar = new ScrollBar(this, 0, 0, 0);
			_scrollBar.step = 1;
			_scrollBar.autoHide = false;
			_scrollBar.width = 20;
			_scrollBar.valueChanged.add(onScrollBarChanged);
			_scrollBar.scrolling.add(onScrollBarMove);
			
			_style = ThemeBase.theme.textBox;
			size(100, 100);
		}
		
		public function appendText(text:String):void {
			_textBase.appendText(text);
			onTextChanged();
		}
		
		override public function dispose():void {
			super.dispose();
			if (background) background.dispose();
			background = null;
			
			removeChild(_textBase);
			_textBase.dispose();
			_textBase = null;
			
			removeChild(_scrollBar);
			_scrollBar.dispose();
			_scrollBar = null;
			
			graphics.clear();
		}
		
		override protected function onThemeChanged():void {
			style = ThemeBase.theme.textBox;
		}
		
		override protected function draw(e:Event):void {
			if (!_changed) return;
			_changed = false;
			
			var style:TextBoxStyle = _style as TextBoxStyle;
			if (background) background.dispose();
			
			graphics.clear();
			if (active) {
				_textBase.style = style.text_active;
				style.active.setSize(_width - _scrollBar.width, _height);
				background = style.active.bitmapData.clone();
			} else {
				_textBase.style = style.text_normal;
				style.normal.setSize(_width - _scrollBar.width, _height);
				background = style.normal.bitmapData.clone();
			}
			graphics.beginBitmapFill(background);
			graphics.drawRect(0, 0, _width - _scrollBar.width, _height);
			graphics.endFill();
			
			_textBase.size(_width - _scrollBar.width, _height);
			
			_scrollBar.style = style.scrollBar;
			_scrollBar.height = _height;
			_scrollBar.move(_width - _scrollBar.width, 0);
			
			onScrollBarChanged();
			onTextChanged();
		}
		
		///////////////////////////////////
		// scrollBar handles
		///////////////////////////////////
		
		private function onScrollBarChanged(scrollBar:ScrollBar = null):void {
			_textBase.scrollV = _scrollBar.value + 1;
			moving = false;
		}
		
		private function onScrollBarMove(scrollBar:ScrollBar = null):void {
			_textBase.scrollV = _scrollBar.value + 1;
			moving = true;
		}
		
		///////////////////////////////////
		// text handle
		///////////////////////////////////
		
		private function onTextChanged(e:Event = null):void {
			_scrollBar.pageSize = _textBase.numLines - _textBase.maxScrollV + 1;
			_scrollBar.contentSize = _textBase.numLines;
		}
		
		private function onTextScroll(e:Event = null):void {
			if (!moving) _scrollBar.value = _textBase.scrollV - 1;
		}
		
		protected function onFocusedIn(e:FocusEvent):void {
			active = true;
			_changed = true;
			invalidate();
		}
		
		protected function onFocusedOut(e:FocusEvent):void {
			active = false;
			_changed = true;
			invalidate();
		}
		
		///////////////////////////////////
		// getter/setters
		///////////////////////////////////
		
		override public function set enabled(value:Boolean):void {
			if (_enabled != value) {
				_enabled = _textBase.tabEnabled = mouseEnabled = mouseChildren = value;
				alpha = _enabled ? 1 : ThemeBase.theme.alpha;
			}
		}
		
		public function get scrollBar():ScrollBar {
			return _scrollBar;
		}
		
		public function get textBase():TextBase {
			return _textBase;
		}
		
		public function set text(value:String):void {
			_textBase.text = value;
			onTextChanged();
		}
		
		public function get text():String {
			return _textBase.text;
		}
		
		///////////////////////////////////
		// toString
		///////////////////////////////////
		
		override public function toString():String {
			return "[bloom.components.TextBox]";
		}
	}

}