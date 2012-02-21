package bloom.style 
{
	import bloom.core.IStyleBase;
	import bloom.core.ScaleBitmap;
	
	/**
	 * CheckBoxStyle
	 */
	public class CheckBoxStyle implements IStyleBase {

		public var normal:ScaleBitmap;
		public var selected:ScaleBitmap;
		
		public var title_normal:TextStyle;
		public var title_selected:TextStyle;
		
		///////////////////////////////////
		// toString
		///////////////////////////////////
		
		public function toString():String {
			return "[bloom.style.default.CheckBoxStyle]";
		}
		
	}

}