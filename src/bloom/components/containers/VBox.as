package bloom.components.containers {

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

		if (_autoSize) {
			var Widths:Array = new Array ();
			for (i = 0; i < j; i ++) {
				object = content.getChildAt (i);

				if (object is IObjectBase) {
					component = object as IObjectBase;
					Widths.push (component.width);
				}
			}

			Widths.sort (Array.DESCENDING);

			if (_autoSize) this.width = Widths[0] + (_contentPadding * 2);

			for (i = 0; i < j; i ++) {
				object = content.getChildAt (i);

				if (object is IObjectBase) {
					component = object as IObjectBase;

					var XPos:Number;
					XPos = ((Widths[0] * .5) - (component.width * .5)) + _contentPadding;
					component.x = XPos;
					component.y = last + _contentPadding;
					last = component.y + component.height;
				}
			}
		} else {
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

	}

}
}
