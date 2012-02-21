package bloom.style 
{
	import bloom.core.IStyleBase;
	import bloom.core.ScaleBitmap;
	import bloom.style.TextStyle;
	
	/**
	 * NumericStepperStyle
	 */
	public class NumericStepperStyle implements IStyleBase {

		public var bt_increase:ButtonBaseStyle;
		public var bt_decrease:ButtonBaseStyle;
		
		public var normal:ScaleBitmap;
		public var active:ScaleBitmap;
		
		public var text_normal:TextStyle;
		public var text_active:TextStyle;
		
		///////////////////////////////////
		// toString
		///////////////////////////////////
		
		public function toString():String {
			return "[bloom.style.default.NumericStepperStyle]";
		}
		
	}
}