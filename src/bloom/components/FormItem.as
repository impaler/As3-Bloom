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
package bloom.components 
{

import bloom.control.BloomCore;
import bloom.core.Component;
import bloom.style.FormItemStyle;

import flash.display.DisplayObjectContainer;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;

import org.osflash.signals.natives.NativeSignal;

	/**
	 * FormItem
	 * 
	 * @author sindney
	 */
	public class FormItem extends Component {
		
		protected var _data:Array = null;
		protected var _selected:Boolean = false;
		
		protected var _bg:Sprite;
		
		public static const NORMAL:int = 0;
		public static const SELECTED:int = 1;
		
		public var onClick:NativeSignal;
		public var onDown:NativeSignal;
		public var onUp:NativeSignal;
		
		public function FormItem(p:DisplayObjectContainer = null) {
			super(p);
			
			_bg = new Sprite();
			addChild(_bg);
			//todo maybe extend Toggle Button instead of recreating it here
			onClick = new NativeSignal ( this , MouseEvent.CLICK , MouseEvent );
			onDown = new NativeSignal ( this , MouseEvent.MOUSE_DOWN , MouseEvent );
			onUp = BloomCore.onStageMouseUp;
			
			style = BloomCore.theme.formStyle.formItemStyle;
			
			size(100, 20);
			
			buttonMode = true;
			tabEnabled = tabChildren = false;
			
			onDown.add(onMouseClick);
//			onUp.add(onMouseUP);
		}
		
		/**
		 * Call this when data:Array is modified.
		 */
		public function dataChanged():void {
			_changed = true;
			invalidate();
		}
		
		override protected function draw(e:Event):void {
			if (_changed) {
				_changed = false;
			} else {
				return;
			}
			
			var _state:int = _selected ? 0 : 1;
			formItemStyle.backgroundBrush.update(_state, _bg , dimensionObject);
			
		}
		
		private function onMouseClick(e:MouseEvent):void {
			selected = !_selected;
		}
		
		private function onMouseUP(e:MouseEvent):void {
			selected = false;
		}
		
		///////////////////////////////////
		// getter/setters
		///////////////////////////////////

		public function get formItemStyle ():FormItemStyle {
			return _style as FormItemStyle
		}
		
		public function set data(a:Array):void {
			if (_data != a) {
				_data = a;
				_changed = true;
				invalidate();
			}
		}
		
		public function get data():Array {
			return _data;
		}
		
		public function set selected(value:Boolean):void {
			if (_selected != value) {
				_selected = value;
				_changed = true;
				invalidate();
			}
		}
		
		public function get selected():Boolean {
			return _selected;
		}
		
		///////////////////////////////////
		// toString
		///////////////////////////////////
		
		override public function toString():String {
			return "[bloom.FormItem]";
		}

		override public function destroy ():void {
			super.destroy ();
			
			onClick.removeAll();
			onClick = null;
			onDown.removeAll();
			onDown = null;
		}
}

}