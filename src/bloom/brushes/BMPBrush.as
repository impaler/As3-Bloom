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
package bloom.brushes 
{
	import bloom.core.ScaleBitmap;
	import bloom.events.BrushEvent;
	
	[BrushEvent(name = "redraw", type = "bloom.events.BrushEvent")]
	
	/**
	 * BMPBrush
	 * <p>ScaleBitmap Brush.</p>
	 * 
	 * @date 2012/1/15 22:11
	 * @author sindney, impaler
	 */
	public class BMPBrush extends Brush {
		
		public var bitmap:Vector.<ScaleBitmap>;
		
		public function BMPBrush(bitmap:Vector.<ScaleBitmap> = null) {
			super();
			this.bitmap = bitmap;
		}
		
		/**
		 * Use this to make your changes up to date.
		 */
		override public function update():void {
			dispatchEvent(new BrushEvent("redraw"));
		}
		
		override public function clone():Brush {
			var data:Vector.<ScaleBitmap> = new Vector.<ScaleBitmap>(bitmap.length, true);
			var i:int, j:int = bitmap.length;
			for (i = 0; i < j; i++) {
				data[i] = bitmap[i].clone();
			}
			return new BMPBrush(data);
		}
		
		override public function destory():void {
			var data:ScaleBitmap;
			for each(data in bitmap) {
				data.bitmapData.dispose();
				data = null;
			}
			bitmap = null;
		}
		
		///////////////////////////////////
		// toString
		///////////////////////////////////
		
		public override function toString():String {
			return "[bloom.brushes.BMPBrush]";
		}
		
	}

}