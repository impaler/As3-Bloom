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

		if (_autoSize) {
			var Heights:Array = new Array ();
			for (i = 0; i < j; i ++) {
				object = content.getChildAt (i);
				component = object as IObjectBase;
				Heights.push (component.height);
			}
			Heights.sort (Array.DESCENDING);
			if (_autoSize) this.height = Heights[0] + (_contentPadding * 2);

			for (i = 0; i < j; i ++) {
				object = content.getChildAt (i);

				if (object is IObjectBase) {
					component = object as IObjectBase;
					var YPos:Number;
					YPos = _contentPadding;
//					YPos = ((Heights[0] * .5) - (component.height * .5)) + _contentPadding;
					component.x = last + _contentPadding;
					component.y = YPos;
					last = component.x + component.width;
				}
			}

		} else {
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
}
