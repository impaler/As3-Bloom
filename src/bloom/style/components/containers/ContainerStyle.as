package bloom.style.components.containers {

import bloom.components.containers.Container;
import bloom.core.IComponent;
import bloom.style.components.ComponentBackgroundBaseStyle;

/**
 * ContainerStyle
 */
public class ContainerStyle extends ComponentBackgroundBaseStyle {

	public var contentPadding:Number;

	override public function update (value:IComponent):void {
		var cont:Container = value as Container;

		if (cont.bgEnabled) {
			background.update (cont.state,cont.bg,cont.getDimensionObject);
		} else {
			cont.bg.graphics.clear();
		}
	}



	///////////////////////////////////
	// toString
	///////////////////////////////////

	override public function toString ():String {
		return "[bloom.styles.ContainerStyle]";
	}

}

}
