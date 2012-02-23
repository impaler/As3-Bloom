package bloom.themes 
{
	import bloom.styles.*;
	
	/**
	 * Theme
	 */
	public class Theme implements ITheme {
		
		protected var _alpha:Number = 0.5;
		
		protected var _label:TextStyle;
		protected var _button:ButtonStyle;
		protected var _buttonBase:ButtonBaseStyle;
		protected var _checkBox:CheckBoxStyle;
		protected var _textInput:TextInputStyle;
		protected var _numericStepper:NumericStepperStyle;
		
		public function Theme() {
			
		}
		
		///////////////////////////////////
		// getter/setters
		///////////////////////////////////
		
		public function get alpha():Number {
			return _alpha;
		}
		
		public function get buttonBase():ButtonBaseStyle {
			return _buttonBase;
		}
		
		public function get label():TextStyle {
			return _label;
		}
		
		public function get button():ButtonStyle {
			return _button;
		}
		
		public function get checkBox():CheckBoxStyle {
			return _checkBox;
		}
		
		public function get textInput():TextInputStyle {
			return _textInput;
		}
		
		public function get numericStepper():NumericStepperStyle {
			return _numericStepper;
		}
		
		///////////////////////////////////
		// toString
		///////////////////////////////////
		
		public function toString():String {
			return "[bloom.themes.Theme]";
		}
	}

}