package bloom.containers {

import bloom.core.IObjectBase;

import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;

public class HBox extends Container {

	public function HBox (p:DisplayObjectContainer = null) {
		super (p);
	}

	override public function layoutContent ():void {
		var last:Number = 0;
		var object:DisplayObject;
		var component:IObjectBase;
		var i:int, j:int = content.numChildren;

		for (i = 0; i < j; i ++) {
			object = content.getChildAt (i);

			if (object is IObjectBase) {
				component = object as IObjectBase;
				component.x = last + component.padding.left;
				component.y = component.padding.top;
				last = component.x + component.width + component.padding.right;
			}
		}
	}

	override public function get width ():Number {
		return content.width;
	}

	override public function get height ():Number {
		return content.height;
	}

}
}
