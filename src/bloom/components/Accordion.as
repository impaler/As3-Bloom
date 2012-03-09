package bloom.components 
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import org.osflash.signals.Signal;
	
	import bloom.core.Margin;
	import bloom.core.IObjectBase;
	import bloom.core.ThemeBase;
	import bloom.styles.AccordionContentStyle;
	import bloom.styles.IStyle;
	
	/**
	 * Accordion
	 */
	public class Accordion extends Sprite implements IObjectBase {
		
		private var _multiSelect:Boolean;
		private var _enabled:Boolean;
		
		private var _margin:Margin;
		private var _last:AccordionContent;
		private var _target:AccordionContent;
		private var _objects:Vector.<AccordionContent>;
		
		private var _style:IStyle;
		
		private var _onResized:Signal;
		
		public function Accordion(p:DisplayObjectContainer = null) {
			super();
			_margin = new Margin();
			if (p) p.addChild(this);
			
			_multiSelect = false;
			_enabled = true;
			
			_objects = new Vector.<AccordionContent>();
			
			_onResized = new Signal();
			
			_style = ThemeBase.theme.accordionContent;
			ThemeBase.onThemeChanged.add(onThemeChanged);
		}
		
		public function move(x:Number, y:Number):void {
			this.x = x;
			this.y = y;
		}
		
		public function addContent(value:AccordionContent):void {
			_objects.push(value);
			value.style = _style;
			value.mouseClicked.add(onContentClick);
			addChild(value);
		}
		
		public function removeContent(value:AccordionContent):void {
			removeContentAt(_objects.indexOf(value));
		}
		
		public function removeContentAt(index:int):AccordionContent {
			var object:AccordionContent = _objects[index];
			if (object) {
				_objects.splice(index, 1)[0];
				object.mouseClicked.remove(onContentClick);
				removeChild(object);
			}
			return object;
		}
		
		public function getContentAt(index:int):AccordionContent {
			return _objects[index];
		}
		
		/**
		 * Call update() after addContent/removeContent ... 
		 */
		public function update():void {
			var last:Number = 0;
			
			var object:AccordionContent;
			for each(object in _objects) {
				if (!_multiSelect) if (object != _target) object.selected = false;
				object.y = last;
				last = object.y + object.height;
			}
			_onResized.dispatch();
		}
		
		public function dispose():void {
			ThemeBase.onThemeChanged.remove(onThemeChanged);
			if (parent) parent.removeChild(this);
			_style = null;
			_margin = null;
			
			for each(var object:AccordionContent in _objects) object.dispose();
			_onResized.removeAll();
			_onResized = null;
			_objects = null;
		}
		
		protected function onThemeChanged():void {
			style = ThemeBase.theme.accordionContent;
		}
		
		private function onContentClick(e:Event):void {
			_target = e.target.parent as AccordionContent;
			update();
		}
		
		///////////////////////////////////
		// getter/setters
		///////////////////////////////////
		
		public function set multiSelect(value:Boolean):void {
			_multiSelect = value;
		}
		
		public function get multiSelect():Boolean {
			return _multiSelect;
		}
		
		public function set enabled(value:Boolean):void {
			if (_enabled != value) {
				for each(var object:AccordionContent in _objects) object.enabled = value;
				_enabled = mouseEnabled = mouseChildren = value;
				alpha = _enabled ? 1 : ThemeBase.theme.alpha;
			}
		}
		
		public function get enabled():Boolean {
			return _enabled;
		}
		
		public function get margin():Margin {
			return _margin;
		}
		
		public function get style():IStyle {
			return _style;
		}
		
		public function set style(value:IStyle):void {
			if (_style != value) {
				_style = value;
				if (_style) {
					for each(var object:AccordionContent in _objects) object.style = _style;
				}
			}
		}
		
		///////////////////////////////////
		// toString
		///////////////////////////////////
		
		override public function toString():String {
			return "[bloom.components.Accordion]";
		}
		
	}

}