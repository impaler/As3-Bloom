package bloom.core 
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	
	import org.osflash.signals.natives.NativeSignal;
	import org.osflash.signals.Signal;
	
	import bloom.control.ThemeBase;
	import bloom.styles.IStyle;
	
	/**
	 * Component
	 */
	public class Component extends Sprite implements IComponent {
		
		protected var _enabled:Boolean = true;
		protected var _changed:Boolean = false;
		
		protected var _onResized:Signal;
		
		protected var _width:Number = 0;
		protected var _height:Number = 0;
		
		protected var _style:IStyle;
		
		protected var _margin:Margin;
		
		public function Component(p:DisplayObjectContainer = null) {
			super();
			var temp:NativeSignal = new NativeSignal(this, Event.ADDED_TO_STAGE, Event);
			temp.addOnce(onAddedToStage);
			_onResized = new Signal();
			_margin = new Margin();
			if (p) p.addChild(this);
		}
		
		public function move(x:Number, y:Number):void {
			this.x = x;
			this.y = y;
		}
		
		public function size(width:Number, height:Number):void {
			this.width = width;
			this.height = height;
		}
		
		public function drawDirectly():void {
			_changed = true;
			draw(null);
		}
		
		public function destroy():void {
			ThemeBase.onThemeChanged.remove(onThemeChanged);
			ThemeBase.onStageDraw.remove(draw);
			if (parent) parent.removeChild(this);
			_style = null;
			_margin = null;
		}
		
		protected function onThemeChanged():void {
			
		}
		
		protected function draw(e:Event):void {
			
		}
		
		protected function invalidate():void {
			if (stage) stage.invalidate();
		}
		
		private function onAddedToStage(e:Event):void {
			ThemeBase.onStageDraw.add(draw);
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
				_onResized.dispatch();
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
				_onResized.dispatch();
			}
		}
		
		override public function get height():Number {
			return _height;
		}
		
		public function get onResized():Signal {
			return _onResized;
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
		
		public function get style():IStyle {
			return _style;
		}
		
		public function set style(value:IStyle):void {
			if (_style != value) {
				_style = value;
				if (_style) drawDirectly();
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