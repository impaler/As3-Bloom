package bloom.components.containers {

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
				component.x = last + containerStyle.contentPadding;
				component.y = containerStyle.contentPadding;
				last = component.x + component.width;
			}
		}
	}

}
}
