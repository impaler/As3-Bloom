package bloom.core 
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import bloom.control.ObjectPool;
	import bloom.control.ThemeBase;
	
	[Event(name = "resize", type = "flash.events.Event")]
	
	/**
	 * Component
	 */
	public class Component extends Sprite implements IComponent {
		
		protected var _enabled:Boolean = true;
		protected var _changed:Boolean = false;
		
		protected var _width:Number = 0;
		protected var _height:Number = 0;
		
		protected var _style:IStyleBase;
		
		protected var _margin:Margin;
		
		public function Component(p:DisplayObjectContainer = null) {
			super();
			_margin = new Margin();
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			if (p) p.addChild(this);
		}
		
		/**
		 * Move this component.
		 */
		public function move(x:Number, y:Number):void {
			this.x = x;
			this.y = y;
		}
		
		/**
		 * Resize this component.
		 */
		public function size(width:Number, height:Number):void {
			this.width = width;
			this.height = height;
		}
		
		public function drawDirectly():void {
			_changed = true;
			draw(null);
		}
		
		protected function draw(e:Event):void {
			
		}
		
		protected function invalidate():void {
			if (stage) stage.invalidate();
		}
		
		private function onAddedToStage(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			stage.addEventListener(Event.RENDER, draw);
			invalidate();
		}
		
		///////////////////////////////////
		// getter/setters
		///////////////////////////////////
		
		override public function set width(value:Number):void {
			if (_width != value) {
				_width = value;
				_changed = true;
				invalidate();
				dispatchEvent(new Event(Event.RESIZE));
			}
		}
		
		override public function get width():Number {
			return _width;
		}
		
		override public function set height(value:Number):void {
			if (_height != value) {
				_height = value;
				_changed = true;
				invalidate();
				dispatchEvent(new Event(Event.RESIZE));
			}
		}
		
		override public function get height():Number {
			return _height;
		}
		
		public function set enabled(value:Boolean):void {
			if (_enabled != value) {
				_enabled = mouseEnabled = mouseChildren = value;
				alpha = _enabled ? 1 : ThemeBase.theme.alpha;
			}
		}
		
		public function get enabled():Boolean {
			return _enabled;
		}
		
		public function get style():IStyleBase {
			return _style;
		}
		
		public function set style(value:IStyleBase):void {
			if (_style != value) {
				if (_style) ObjectPool.returnObject(_style);
				_style = value;
				if (_style) {
					_style = ObjectPool.getObject(ObjectPool.getClassName(value)) as IStyleBase;
					drawDirectly();
				}
			}
		}
		
		public function get margin():Margin {
			return _margin;
		}
		
		///////////////////////////////////
		// toString
		///////////////////////////////////
		
		override public function toString():String {
			return "[bloom.core.Component]";
		}
		
	}

}