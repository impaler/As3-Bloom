package bloom.themes.defaultTheme
{

import bloom.core.ThemeBase;

	/**
	 * DefaultTheme
	 */
	public class DefaultTheme extends ThemeBase {

		public function DefaultTheme() {
			
			label = DefaultTextStyle;
			textInput = DefaultTextInputStyle;
			button = DefaultButtonStyle;
			buttonBase = DefaultButtonBaseStyle;
			checkBox = DefaultCheckBoxStyle;
			textInput = DefaultTextInputStyle;
			numericStepper = DefaultNumericStepperStyle;
			progressBar = DefaultProgressBarStyle;
			container = DefaultContainerStyle;
			flowContainer = DefaultFlowContainerStyle;
			slider = DefaultSliderStyle;
			scrollContainer = DefaultScrollContainerStyle;
			window = DefaultWindowStyle;
			form = DefaultFormStyle;
			
			disabledAlpha = .05;
		}
		
		public static function toString():String {
			return "[bloom.style.default.DefaultTheme]";
		}
		
	}

}