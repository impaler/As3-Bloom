package bloom.themes.default 
{	
	import bloom.control.ObjectPool;

	/**
	 * DefaultTheme
	 */
	public class DefaultTheme {

		public function DefaultTheme() {
			label = ObjectPool.getObject(LabelStyle) as LabelStyle;
			button = ObjectPool.getObject(ButtonStyle) as ButtonStyle;
			buttonBase = ObjectPool.getObject(ButtonBaseStyle) as ButtonBaseStyle;
			checkBox = ObjectPool.getObject(CheckBoxStyle) as CheckBoxStyle;
			textInput = ObjectPool.getObject(TextInputStyle) as TextInputStyle;
			numericStepper = ObjectPool.getObject(NumericStepperStyle) as NumericStepperStyle;
			progressBar = ObjectPool.getObject(ProgressBarStyle) as ProgressBarStyle;
			container = ObjectPool.getObject(ContainerStyle) as ContainerStyle;
			flowContainer = ObjectPool.getObject(FlowContainerStyle) as FlowContainerStyle;
			slider = ObjectPool.getObject(SliderStyle) as SliderStyle;
			scrollContainer = ObjectPool.getObject(ScrollContainerStlye) as ScrollContainerStlye;
			window = ObjectPool.getObject(WindowStyle) as WindowStyle;
		}
		
		///////////////////////////////////
		// Global
		///////////////////////////////////
		
		public var alpha:Number = 0.5;
		
		///////////////////////////////////
		// Components
		///////////////////////////////////
		
		public var label:LabelStyle;
		
		public var button:ButtonStyle;
		
		public var buttonBase:ButtonBaseStyle;
		
		public var checkBox:CheckBoxStyle;
		
		public var textInput:TextInputStyle;
		
		public var numericStepper:NumericStepperStyle;
		
		public var progressBar:ProgressBarStyle;
		
		public var container:ContainerStyle;
	
		public var flowContainer:FlowContainerStyle;
		
		public var slider:SliderStyle;
		
		public var scrollContainer:ScrollContainerStlye;
		
		public var window:WindowStyle;
		
		///////////////////////////////////
		// toString
		///////////////////////////////////
		
		public function toString():String {
			return "[bloom.themes.default.DefaultTheme]";
		}
		
	}

}