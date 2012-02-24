package bloom.themes 
{
	import bloom.styles.*;
	
	/**
	 * ITheme
	 */
	public interface ITheme {
		
		function get alpha():Number;
		
		function get buttonBase():ButtonBaseStyle;
		
		function get button():ButtonStyle;
		
		function get label():TextStyle;
		
		function get checkBox():CheckBoxStyle;
		
		function get textInput():TextInputStyle;
		
		function get numericStepper():NumericStepperStyle;
		
		function get progressBar():ProgressBarStyle;
		
		function get slider():SliderStyle;
		
		function get textBox():TextBoxStyle;
		
		function get toggleButton():ToggleButtonStyle;
		
	}
	
}