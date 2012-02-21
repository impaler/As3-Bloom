package bloom.core 
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	
	import bloom.control.ObjectPool;
	import bloom.control.BloomCore;

import org.osflash.signals.natives.NativeSignal;

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
			var onAddedToStageSignal:NativeSignal = new NativeSignal( this, Event.ADDED_TO_STAGE, Event );
			onAddedToStageSignal.addOnce(onAddedToStage);
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
			BloomCore.onStageDraw.add(draw);
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
				alpha = _enabled ? 1 : BloomCore.theme.disabledAlpha;
			}
		}
		
		public function get enabled():Boolean {
			return _enabled;
		}
		
		public function get style():IStyleBase {
			return _style;
		}
		
		public function set style(value:IStyleBase):void {
			if (!_style) {
				if (value) {
					_style = ObjectPool.getObject(ObjectPool.getClassName(value)) as IStyleBase;
					drawDirectly();
				}
			} else if (!value) {
				if (_style) {
					ObjectPool.returnObject(_style);
					_style = null;
				}
			} else if (_style.toString() != value.toString()) {
				ObjectPool.returnObject(_style);
				_style = ObjectPool.getObject(ObjectPool.getClassName(value)) as IStyleBase;
				drawDirectly();
			}
		}
		
		public function get margin():Margin {
			return _margin;
		}
		
		public function get dimensionObject ():Object {
			var obj:Object = new Object ();
			obj.width = _width;
			obj.height = _height;
			obj.x = 0;
			obj.y = 0;
			return obj;
		}
	
		///////////////////////////////////
		// toString
		///////////////////////////////////
		
		override public function toString():String {
			return "[bloom.core.Component]";
		}
		
		public function destroy () :void {
			BloomCore.onStageDraw.remove(draw);
			_style = null;
			if ( parent!=null ) parent.removeChild(this);
		}
		
	}

}