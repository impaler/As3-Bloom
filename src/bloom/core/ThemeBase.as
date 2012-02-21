package bloom.core 
{

import bloom.style.*;

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
		
		private var _label:TextStyle;

		public function set label ( value:Class ):void {
			_label = ObjectPool.getObject(value);
		}
	
		public function get labelStyle ():TextStyle {
			return _label as TextStyle;
		}
	
		///////////////////////////////////

		private var _button:ButtonStyle;
	
		public function set button ( value:Class ):void {
			_button = ObjectPool.getObject(value);
		}	
	
		public function get buttonStyle ():ButtonStyle {
			return _button as ButtonStyle;
		}
	
		///////////////////////////////////
	
		private var _buttonBase:ButtonBaseStyle;
	
		public function set buttonBase ( value:Class ):void {
			_buttonBase = ObjectPool.getObject(value);
		}	
	
		public function get buttonBaseStyle ():ButtonBaseStyle {
			return _buttonBase as ButtonBaseStyle;
		}	
	
		///////////////////////////////////
	
		private var _checkBox:CheckBoxStyle;
	
		public function set checkBox ( value:Class ):void {
			_checkBox = ObjectPool.getObject(value);
		}	
	
		public function get checkBoxStyle ():CheckBoxStyle {
			return _checkBox as CheckBoxStyle;
		}	
	
		///////////////////////////////////
	
		private var _textInput:TextInputStyle;
	
		public function set textInput ( value:Class ):void {
			_textInput = ObjectPool.getObject(value);
		}	
	
		public function get textInputStyle ():TextInputStyle {
			return _textInput as TextInputStyle;
		}		
		
		///////////////////////////////////
	
		private var _flowContainerStyle:ContainerStyle;
	
		public function set flowContainer ( value:Class ):void {
			_flowContainerStyle = ObjectPool.getObject(value);
		}	
	
		public function get flowContainerStyle ():ContainerStyle {
			return _flowContainerStyle as ContainerStyle;
		}	
	
		///////////////////////////////////
	
		private var _numericStepper:NumericStepperStyle;
	
		public function set numericStepper ( value:Class ):void {
			_numericStepper = ObjectPool.getObject(value);
		}	
	
		public function get numericStepperStyle ():NumericStepperStyle {
			return _numericStepper as NumericStepperStyle;
		}		
	
		///////////////////////////////////
	
		private var _progressBar:ProgressBarStyle;
	
		public function set progressBar ( value:Class ):void {
			_progressBar = ObjectPool.getObject(value);
		}	
	
		public function get progressBarStyle ():ProgressBarStyle {
			return _progressBar as ProgressBarStyle;
		}	
	
		///////////////////////////////////
	
		private var _container:ContainerStyle;
	
		public function set container ( value:Class ):void {
			_container = ObjectPool.getObject(value);
		}	
	
		public function get containerStyle ():ContainerStyle {
			return _container as ContainerStyle;
		}		
			
		///////////////////////////////////
	
		private var _slider:SliderStyle;
	
		public function set slider ( value:Class ):void {
			_slider = ObjectPool.getObject(value);
		}	
	
		public function get sliderStyle ():SliderStyle {
			return _slider as SliderStyle;
		}		
		
		///////////////////////////////////
	
		private var _scrollContainer:ScrollContainerStyle;
	
		public function set scrollContainer ( value:Class ):void {
			_scrollContainer = ObjectPool.getObject(value);
		}	
	
		public function get scrollContainerStyle ():ScrollContainerStyle {
			return _scrollContainer as ScrollContainerStyle;
		}		

		///////////////////////////////////
	
		private var _window:WindowStyle;
	
		public function set window ( value:Class ):void {
			_window = ObjectPool.getObject(value);
		}	
	
		public function get windowStyle ():WindowStyle {
			return _window as WindowStyle;
		}	
		
		///////////////////////////////////
		// toString
		///////////////////////////////////
		
		public static function toString():String {
			return "[bloom.style.default.ThemeBase]";
		}
		
	}

}