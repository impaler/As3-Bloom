package bloom.components 
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	
	import bloom.core.ThemeBase;
	import bloom.styles.IStyle;
	import bloom.styles.TabBoxContentStyle;
	
	/**
	 * TabBox
	 */
	public class TabBox extends Container {
		
		private var _headerSize:Number;
        private var _headerPadding:Number;
		
		private var _group:CheckBoxGroup;
		
		private var _objects:Vector.<TabBoxContent>;
		
		private var _header:FlowContainer;
		private var _target:TabBoxContent;
		
		public function TabBox(p:DisplayObjectContainer = null) {
			super(p);
			_header = new FlowContainer(this, FlowContainer.HORIZONTALLY);
			
			_objects = new Vector.<TabBoxContent>();
			
			_group = new CheckBoxGroup(-1);
			_group.add(onTabChanged);
			
			_headerSize = 30;
			_headerPadding = 20;
			
			style = ThemeBase.theme.tabBoxContent;
		}
		
		public function addContent(value:TabBoxContent):void {
			_objects.push(value);
			_group.addChild(value.title);
			value.style = _style;
			
			value.title.width = value.title.title.width + _headerPadding;
			if (value.title.icon) value.title.width += value.title.icon.width + value.title.margin.right;
			value.title.height = _headerSize - value.title.margin.top;
			
			_header.content.addChild(value.title);
			
			if (!_target) toggleTab(value.title.title.text);
		}
		
		public function removeContent(value:TabBoxContent):void {
			var index:int = _objects.indexOf(value);
			if (index != -1) removeContentAt(index);
		}
		
		public function removeContentAt(index:int):TabBoxContent {
			var result:TabBoxContent = _objects[index];
			if (result) {
				_group.removeChild(result.title);
				_header.removeChild(result.title);
				if (result.content.parent) removeChild(result.content);
				if (result == _target)_target = null;
			}
			return result;
		}
		
		public function getContentAt(index:int):TabBoxContent {
			return _objects[index];
		}
		
		/**
		 * Toggle a certain tab.
		 */
		public function toggleTab(name:String):void {
			var i:int, j:int = _objects.length;
			var object:TabBoxContent;
			for (i = 0; i < j; i++) {
				object = _objects[i];
				if (object.title.title.text == name) {
					_group.index = i;
				}
			}
		}
		
		public function update():void {
			_header.size(_width, _headerSize);
			if (_target) {
				if (!_target.content.parent) addChild(_target.content);
				_target.content.y = _headerSize;
				_target.content.width = _width;
				_target.content.height = _height - _headerSize;
			}
		}
		
		override public function dispose():void {
			super.dispose();
			_header.dispose();
			for each(var object:TabBoxContent in _objects) object.dispose();
			_objects = null;
			_group.removeAll();
			_group = null;
			_target = null;
		}
		
		override protected function onThemeChanged():void {
			style = ThemeBase.theme.tabBoxContent;
		}
		
		override protected function draw(e:Event):void {
			if (!_changed) return;
			_changed = false;
			update();
		}
		
		private function updatePadding():void {
			var object:TabBoxContent;
			for each(object in _objects) {
				object.title.width = object.title.title.width + _headerPadding;
				if (object.title.icon) object.title.width += object.title.icon.width + object.title.margin.right;
				object.title.height = _headerSize - object.title.margin.top;
			}
		}
		
		private function onTabChanged(object:CheckBoxGroup):void {
			if (_target) {
				_target.title.mouseEnabled = true;
				removeChild(_target.content);
			}
			_target = _objects[object.index];
			_target.title.mouseEnabled = false;
			update();
		}
		
		///////////////////////////////////
		// getter/setters
		///////////////////////////////////
		
		override public function set style(value:IStyle):void {
			if (_style != value) {
				_style = value;
				if (_style) {
					_header.style = (_style as TabBoxContentStyle).header;
					for each(var object:TabBoxContent in _objects) object.style = style;
				}
			}
		}
		
		public function get header():FlowContainer {
			return _header;
		}
		
		public function get target():TabBoxContent {
			return _target;
		}
		
		public function set headerSize(value:Number):void {
			if (_headerSize != value) {
				_headerSize = value;
				updatePadding();
				update();
			}
		}
		
		public function get headerSize():Number {
			return _headerSize;
		}
		
		public function set headerPadding(value:Number):void {
			if (_headerPadding != value) {
				_headerPadding = value;
				updatePadding();
			}
		}
		
		public function get headerPadding():Number {
			return _headerPadding;
		}
		
		///////////////////////////////////
		// toString
		///////////////////////////////////
		
		override public function toString():String {
			return "[bloom.components.TabBox]";
		}
		
	}

}
