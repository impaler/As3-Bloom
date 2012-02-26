package bloom.components 
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	
	import bloom.core.IObjectBase;
	
	/**
	 * FlowContainer
	 */
	public class FlowContainer extends Container {
		
		public static const VERTICALLY:int = 0;
		public static const HORIZONTALLY:int = 1;
		
		protected var _direction:int;
		
		public function FlowContainer(p:DisplayObjectContainer = null, direction:int = 0) {
			super(p);
			_direction = direction;
			update();
		}
		
		public function update():void {
			var last:Number = 0;
			
			var object:DisplayObject;
			var component:IObjectBase;
			var i:int, j:int = numChildren;
			for (i = 0; i < j; i++) {
				object = getChildAt(i);
				if (object is IObjectBase) {
					component = object as IObjectBase;
					if (_direction == HORIZONTALLY) {
						component.x = last + component.margin.left;
						component.y = component.margin.top;
						last = component.x + component.width + component.margin.right;
					} else if (_direction == VERTICALLY) {
						component.x = component.margin.left;
						component.y = last + component.margin.top;
						last = component.y + component.height + component.margin.bottom;
					}
				}
			}
		}
		
		///////////////////////////////////
		// getter/setters
		///////////////////////////////////
		
		public function set direction(value:int):void {
			if (_direction != value) {
				_direction = value;
				update();
			}
		}
		
		public function get direction():int {
			return _direction;
		}
		
		///////////////////////////////////
		// toString
		///////////////////////////////////
		
		override public function toString():String {
			return "[bloom.components.FlowContainer]";
		}
		
	}

}