/**
 * Copyright (c) 2012 - 2100 Sindney
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */
package bloom.core 
{
	
	/**
	 * Margin
	 * 
	 * @date 2012/1/17 12:04
	 * @author sindney
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