package bloom.core {

import flash.system.System;

/**
 * ThemeBase
 */
public class Theme {

	///////////////////////////////////
	// Global
	///////////////////////////////////

	public var disabledAlpha:Number = 0.5;

	private var _text:*;
	private var _button:*;
	private var _buttonBase:*;
	private var _checkBox:*;
	private var _textInput:*;
	private var _flowContainerStyle:*;
	private var _numericStepper:*;
	private var _progressBar:*;
	private var _container:*;
	private var _slider:*;
	private var _scrollContainer:*;
	private var _window:*;
	private var _formStyle:*;

	///////////////////////////////////
	// Component Getter Setters
	///////////////////////////////////

	public function set text (value:Class):void {
		_text = new value ();
	}

	public function get text ():* {
		return _text;
	}

	///////////////////////////////////

	public function set button (value:Class):void {
		_button = new value ();
	}

	public function get buttonStyle ():* {
		return _button;
	}

	///////////////////////////////////

	public function set buttonBase (value:Class):void {
		_buttonBase = new value ();
	}

	public function get buttonBaseStyle ():* {
		return _buttonBase;
	}

	///////////////////////////////////

	public function set checkBox (value:Class):void {
		_checkBox = new value ();
	}

	public function get checkBoxStyle ():* {
		return _checkBox;
	}

	///////////////////////////////////

	public function set textInput (value:Class):void {
		_textInput = new value ();
	}

	public function get textInputStyle ():* {
		return _textInput;
	}

	///////////////////////////////////

	public function set flowContainer (value:Class):void {
		_flowContainerStyle = new value ();
	}

	public function get flowContainerStyle ():* {
		return _flowContainerStyle;
	}

	///////////////////////////////////

	public function set numericStepper (value:Class):void {
		_numericStepper = new value ();
	}

	public function get numericStepperStyle ():* {
		return _numericStepper;
	}

	///////////////////////////////////

	public function set progressBar (value:Class):void {
		_progressBar = new value ();
	}

	public function get progressBarStyle ():* {
		return _progressBar;
	}

	///////////////////////////////////

	public function set container (value:Class):void {
		_container = new value ();
	}

	public function get containerStyle ():* {
		return _container;
	}

	///////////////////////////////////

	public function set slider (value:Class):void {
		_slider = new value ();
	}

	public function get sliderStyle ():* {
		return _slider;
	}

	///////////////////////////////////

	public function set scrollContainer (value:Class):void {
		_scrollContainer = new value ();
	}

	public function get scrollContainerStyle ():* {
		return _scrollContainer;
	}

	///////////////////////////////////

	public function set window (value:Class):void {
		_window = new value ();
	}

	public function get windowStyle ():* {
		return _window;
	}

	///////////////////////////////////

	public function set form (value:Class):void {
		_formStyle = new value ();
	}

	public function get formStyle ():* {
		return _formStyle;
	}

	///////////////////////////////////
	// Dispose
	///////////////////////////////////

	public function dispose (gc:Boolean = false):void {
		if (_text != null)IStyle (_text).dispose ();
		_text = null;
		if (_button != null)IStyle (_button).dispose ();
		_button = null;
		if (_buttonBase != null)IStyle (_buttonBase).dispose ();
		_buttonBase = null;
		if (_checkBox != null)IStyle (_checkBox).dispose ();
		_checkBox = null;
		if (_textInput != null)IStyle (_textInput).dispose ();
		_textInput = null;

		_flowContainerStyle = null;

		_numericStepper = null;

		_progressBar = null;

		_container = null;

		_slider = null;

		_scrollContainer = null;

		_window = null;

		_formStyle = null;

		if (gc) System.gc ();
	}

	///////////////////////////////////
	// toString
	///////////////////////////////////

	public static function toString ():String {
		return "[bloom.style.default.ThemeBase]";
	}

}

}


