package bloom.core 
{
import bloom.control.ObjectPool;

	/**
	 * ThemeBase
	 */
	public class ThemeBase {
		
		///////////////////////////////////
		// Global
		///////////////////////////////////
		
		public var disabledAlpha:Number = 0.5;
		
		///////////////////////////////////
		// Components
		///////////////////////////////////
		
		private var _label:*;

		public function set label ( value:Class ):void {
			_label = ObjectPool.getObject(value);
		}
	
		public function get labelStyle ():* {
			return _label;
		}
	
		///////////////////////////////////

		private var _button:*;
	
		public function set button ( value:Class ):void {
			_button = ObjectPool.getObject(value);
		}	
	
		public function get buttonStyle ():* {
			return _button;
		}
	
		///////////////////////////////////
	
		private var _buttonBase:*;
	
		public function set buttonBase ( value:Class ):void {
			_buttonBase = ObjectPool.getObject(value);
		}	
	
		public function get buttonBaseStyle ():* {
			return _buttonBase;
		}	
	
		///////////////////////////////////
	
		private var _checkBox:*;
	
		public function set checkBox ( value:Class ):void {
			_checkBox = ObjectPool.getObject(value);
		}	
	
		public function get checkBoxStyle ():* {
			return _checkBox;
		}	
	
		///////////////////////////////////
	
		private var _textInput:*;
	
		public function set textInput ( value:Class ):void {
			_textInput = ObjectPool.getObject(value);
		}	
	
		public function get textInputStyle ():* {
			return _textInput;
		}		
		
		///////////////////////////////////
	
		private var _flowContainerStyle:*;
	
		public function set flowContainer ( value:Class ):void {
			_flowContainerStyle = ObjectPool.getObject(value);
		}	
	
		public function get flowContainerStyle ():* {
			return _flowContainerStyle;
		}	
	
		///////////////////////////////////
	
		private var _numericStepper:*;
	
		public function set numericStepper ( value:Class ):void {
			_numericStepper = ObjectPool.getObject(value);
		}	
	
		public function get numericStepperStyle ():* {
			return _numericStepper;
		}		
	
		///////////////////////////////////
	
		private var _progressBar:*;
	
		public function set progressBar ( value:Class ):void {
			_progressBar = ObjectPool.getObject(value);
		}	
	
		public function get progressBarStyle ():* {
			return _progressBar;
		}	
	
		///////////////////////////////////
	
		private var _container:*;
	
		public function set container ( value:Class ):void {
			_container = ObjectPool.getObject(value);
		}	
	
		public function get containerStyle ():* {
			return _container;
		}		
			
		///////////////////////////////////
	
		private var _slider:*;
	
		public function set slider ( value:Class ):void {
			_slider = ObjectPool.getObject(value);
		}	
	
		public function get sliderStyle ():* {
			return _slider;
		}		
		
		///////////////////////////////////
	
		private var _scrollContainer:*;
	
		public function set scrollContainer ( value:Class ):void {
			_scrollContainer = ObjectPool.getObject(value);
		}	
	
		public function get scrollContainerStyle ():* {
			return _scrollContainer;
		}		

		///////////////////////////////////
	
		private var _window:*;
	
		public function set window ( value:Class ):void {
			_window = ObjectPool.getObject(value);
		}	
	
		public function get windowStyle ():* {
			return _window;
		}	
	
		///////////////////////////////////
	
		private var _formStyle:*;
	
		public function set form ( value:Class ):void {
			_formStyle = ObjectPool.getObject(value);
		}	
	
		public function get formStyle ():* {
			return _formStyle;
		}		
	
		
		///////////////////////////////////
		// toString
		///////////////////////////////////
		
		public static function toString():String {
			return "[bloom.style.default.ThemeBase]";
		}
		
	}

}