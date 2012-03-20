package bloom.style.components.controls {

import bloom.components.controls.ToggleButton;
import bloom.style.brush.Brush;
import bloom.core.IComponent;

/**
 * CheckBoxStyle
 */
public class CheckBoxStyle extends ButtonBaseStyle {

	public var checkBoxTitle:Brush;

	override public function update (value:IComponent):void {
		var checkBox:ToggleButton = value as ToggleButton;

		background.update (checkBox.state,checkBox,checkBox.getDimensionObject);
		checkBoxTitle.update(checkBox.state, checkBox.title);
	}

	///////////////////////////////////
	// toString
	///////////////////////////////////

	override public function toString ():String {
		return "[bloom.styles.CheckBoxStyle]";
	}
}

}
