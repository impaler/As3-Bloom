/**
 * Copyright (c) 2012 - 2100 Sindney
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */
package bloom.core 
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import bloom.brushes.Brush;
	import bloom.events.BrushEvent;
	import bloom.themes.ThemeBase;
	
	/** 
	 * Dispatched when this Component has resized.
	 * @eventType flash.events.Event
	 */
	[Event(name = "resize", type = "flash.events.Event")]
	
	/**
	 * Component
	 * 
	 * @date 2012/1/10 20:17
	 * @author sindney
	 */
	public class Component extends Sprite implements IComponent {
		
		protected var _enabled:Boolean = true;
		protected var _changed:Boolean = false;
		
		protected var _width:Number = 0;
		protected var _height:Number = 0;
		
		protected var _brush:Brush;
		
		protected var _margin:Margin;
		
		public function Component(p:DisplayObjectContainer = null) {
			super();
			_margin = new Margin();
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			if (p != null) p.addChild(this);
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
		public function size(w:Number, h:Number):void {
			if (_width != w || _height != h) {
				_width = w;
				_height = h;
				_changed = true;
				invalidate();
				dispatchEvent(new Event("resize"));
			}
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
		
		protected function onBrushChanged(e:BrushEvent):void {
			_changed = true;
			invalidate();
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
				dispatchEvent(new Event("resize"));
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
				dispatchEvent(new Event("resize"));
			}
		}
		
		override public function get height():Number {
			return _height;
		}
		
		public function set brush(b:Brush):void {
			if (_brush != b) {
				if (_brush) _brush.removeEventListener(BrushEvent.REDRAW, onBrushChanged);
				_brush = b;
				if (_brush) {
					_changed = true;
					invalidate();
					_brush.addEventListener(BrushEvent.REDRAW, onBrushChanged);
				}
			}
		}
		
		public function get brush():Brush {
			return _brush;
		}
		
		public function set enabled(value:Boolean):void {
			if (_enabled != value) {
				_enabled = mouseEnabled = mouseChildren = value;
				alpha = _enabled ? 1 : ThemeBase.ALPHA;
			}
		}
		
		public function get enabled():Boolean {
			return _enabled;
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