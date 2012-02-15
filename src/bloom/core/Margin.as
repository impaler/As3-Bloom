package bloom.core 
{
	
	/**
	 * Margin
	 */
	public class Margin {
		
		public var top:Number;
		public var left:Number;
		public var bottom:Number;
		public var right:Number;
		
		public function Margin(top:Number = 5, left:Number = 5, bottom:Number = 5, right:Number = 5) {
			this.top = top;
			this.left = left;
			this.bottom = bottom;
			this.right = right;
		}
		
		public function reset(top:Number, left:Number, bottom:Number, right:Number):void {
			this.top = top;
			this.left = left;
			this.bottom = bottom;
			this.right = right;
		}
		
		public function copyForm(margin:Margin):void {
			this.top = margin.top;
			this.left = margin.left;
			this.bottom = margin.bottom;
			this.right = margin.right;
		}
		
		///////////////////////////////////
		// toString
		///////////////////////////////////
		
		public function toString():String {
			return "[bloom.core.Margin]";
		}
		
	}

}