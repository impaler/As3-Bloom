package bloom.styles 
{
	import bloom.core.ScaleBitmap;
	
	/**
	 * NumericStepperStyle
	 */
	public class NumericStepperStyle implements IStyle {
		
		public var text_normal:TextStyle;
		public var text_active:TextStyle;
		
		public var normal:ScaleBitmap;
		public var active:ScaleBitmap;
		
		public var increase:ButtonBaseStyle;
		public var decrease:ButtonBaseStyle;
		
		public function NumericStepperStyle() {
			
		}
		
		///////////////////////////////////
		// toString
		///////////////////////////////////
		
		public function toString():String {
			return "[bloom.styles.NumericStepperStyle]";
		}
	}

}