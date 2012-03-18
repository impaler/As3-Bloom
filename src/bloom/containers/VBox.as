package bloom.containers {

import bloom.core.IObjectBase;

import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;

public class VBox extends Container {

	public function VBox (p:DisplayObjectContainer = null) {
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
				component.x = containerStyle.contentPadding;
				component.y = last + containerStyle.contentPadding;
				last = component.y + component.height;
			}
		}
	}

	override public function get height ():Number {
		if ( !_hasContent ) {
			return super.height;
		} else {
			return content.height + (containerStyle.contentPadding *2);
		}
	}


}
}
