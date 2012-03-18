package bloom.components.style.components {

import bloom.components.style.*;

import bloom.core.IComponent;
import bloom.components.style.brush.Brush;

/**
 * ComponentBaseStyle
 */
public class ComponentBackgroundBaseStyle extends ComponentBaseStyle {

	public var background:Brush;

	override public function update (value:IComponent):void {
		background.update (value.state,value,value.getDimensionObject);
	}

	///////////////////////////////////
	// Dispose
	///////////////////////////////////

	override public function dispose (gc:Boolean = false):void {
		background.dispose ();
		background = null;
	}

	///////////////////////////////////
	// toString
	///////////////////////////////////

	override public function toString ():String {
		return "[bloom.styles.ComponentBaseStyle]";
	}

}
}
