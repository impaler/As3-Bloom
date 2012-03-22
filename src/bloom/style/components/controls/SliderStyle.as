package bloom.style.components.controls {

import bloom.components.controls.Slider;
import bloom.core.IComponent;
import bloom.style.components.ComponentBackgroundBaseStyle;

/**
 * SliderStyle
 */
public class SliderStyle extends ComponentBackgroundBaseStyle {

	public var button:ButtonBaseStyle;


	override public function update (value:IComponent):void {
		var slider:Slider = value as Slider;
		background.update (slider.state,slider.bg,slider.getDimensionObject);
		button.update(slider.button);
	}

	///////////////////////////////////
	// toString
	///////////////////////////////////

	override public function toString ():String {
		return "[bloom.styles.SliderStyle]";
	}
}

}
