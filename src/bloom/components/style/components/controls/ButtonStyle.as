package bloom.components.style.components.controls {

import bloom.components.controls.Button;
import bloom.components.style.brush.Brush;
import bloom.core.IComponent;

/**
 * ButtonStyle
 */
public class ButtonStyle extends ButtonBaseStyle {

	public var buttonText:Brush;

	override public function update (value:IComponent):void {
		var button:Button = value as Button;

		background.update (button.state,button,button.getDimensionObject);
		buttonText.update(button.state, button.title);
	}

	///////////////////////////////////
	// toString
	///////////////////////////////////

	override public function toString ():String {
		return "[bloom.styles.ButtonStyle]";
	}
}

}
