package bloom.containers {

import bloom.core.IObjectBase;

import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;

public class HBox extends Container {

	public function HBox (p:DisplayObjectContainer = null) {
		super (p);
	}

	override public function positionContent ():void {
		var last:Number = 0;
		var object:DisplayObject;
		var component:IObjectBase;
		var i:int, j:int = container.numChildren;

		for (i = 0; i < j; i ++) {
			object = container.getChildAt (i);

			if (object is IObjectBase) {
				component = object as IObjectBase;
				component.x = last + component.padding.left;
				component.y = component.padding.top;
				last = component.x + component.width + component.padding.right;
			}
		}
	}

}
}
