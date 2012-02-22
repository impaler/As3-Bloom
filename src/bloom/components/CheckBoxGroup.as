package bloom.components 
{
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import org.osflash.signals.Signal;
	
	/**
	 * CheckBoxGroup
	 */
	public class CheckBoxGroup extends Signal {
		
		private var _content:Array;
		
		private var _index:int;
		private var _target:CheckBox;
		
		public function CheckBoxGroup(index:int, ...rest) {
			super(CheckBoxGroup);
			
			_index = index;
		    
			if (_index == -1) {
				_content = [];
			} else {
				if (rest.length == 1 && rest[0] is Array) _content = rest[0];
				if( rest.length > 1) _content = rest;
				
				var i:int, j:int = numChildren;
				for (i = 0; i < j; i++) {
					(_content[i] as CheckBox).mouseClick.add(onChanged);
				}
			}
			
			update();
		}
		
		public function addChild(target:CheckBox):void {
			_content.push(target);
			target.value = false;
			target.mouseClick.add(onChanged);
		}
		
		public function removeChild(target:CheckBox):void {
			var index:int = _content.indexOf(target);
			if (index != -1) {
				if (_index == index) {
					_index = -1;
					_target = null;
				}
				_content.splice(index, 1);
				target.mouseClick.remove(onChanged);
			}
		}
		
		public function removeChildAt(index:int):CheckBox {
			var target:CheckBox = _content[index];
			if (target) {
				if (_index == index) {
					_index = -1;
					_target = null;
				}
				_content.splice(index, 1);
				target.mouseClick.remove(onChanged);
				
				return target;
			}
			return null;
		}
		
		private function update():void {
			var i:int, j:int = numChildren;
			for (i = 0; i < j; i++) {
				(_content[i] as CheckBox).value = false;
			}
			
			_target = _content[_index];
			if (_target)_target.value = true;
		}
		
		private function onChanged(e:MouseEvent):void {
			index = _content.indexOf(e.target);
		}
		
		///////////////////////////////////
		// getter/setters
		///////////////////////////////////
		
		public function get target():CheckBox {
			return _target;
		}
		
		public function set index(value:int):void {
			if (_index != value) {
				_index = value > _content.length - 1 ? _content.length - 1 : value;
				update();
			} else {
				_index = -1;
				_target = null;
			}
			dispatch(this);
		}
		
		public function get index():int {
			return _index;
		}
		
		public function get numChildren():int {
			return _content.length;
		}
		
		///////////////////////////////////
		// toString
		///////////////////////////////////
		
		public function toString():String {
			return "[bloom.components.CheckBoxGroup]";
		}
		
	}

}