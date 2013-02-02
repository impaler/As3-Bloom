package omni.components.utils;

import nme.display.BitmapInt32;
import nme.display.Sprite;
import nme.display.Graphics;
import nme.display.BitmapData;
import nme.geom.Matrix;
import nme.geom.Point;
import nme.geom.Rectangle;

/**
* NME Sprite BitmapData Sprite Slice scaling
* Working in html5/cpp/flash targets
* 
* Based on work by RealyUniqueName in 
* https://github.com/RealyUniqueName/StablexUI
* 
**/
class BitmapScaleSliceUtil
{

	public static inline function slice9(target:Sprite, targetWidth:Float, targetHeight:Float, bmp:BitmapData,
	                                     slice:Array<Int>, smooth:Bool = false):Sprite
	{
		target.graphics.clear();

		var srcRectRect = new Rectangle();
		var dstRect = new Rectangle();

		//top left
		srcRectRect.x = 0;
		srcRectRect.y = 0;
		srcRectRect.width = slice[0];
		srcRectRect.height = slice[2];

		dstRect.x = 0;
		dstRect.y = 0;
		dstRect.width = slice[0];
		dstRect.height = slice[2];

		drawBitmapSlice(target, bmp, srcRectRect, dstRect, smooth);

		//top middle
		srcRectRect.x = slice[0];
		srcRectRect.y = 0;
		srcRectRect.width = slice[1] - slice[0];
		srcRectRect.height = slice[2];

		dstRect.x = slice[0];
		dstRect.y = 0;
		dstRect.width = targetWidth - slice[0] - (bmp.width - slice[1]);
		dstRect.height = slice[2];

		drawBitmapSlice(target, bmp, srcRectRect, dstRect, smooth);

		//top right
		srcRectRect.x = slice[1];
		srcRectRect.y = 0;
		srcRectRect.width = bmp.width - slice[1];
		srcRectRect.height = slice[2];

		dstRect.x = targetWidth - srcRectRect.width;
		dstRect.y = 0;
		dstRect.width = srcRectRect.width;
		dstRect.height = slice[2];

		drawBitmapSlice(target, bmp, srcRectRect, dstRect, smooth);

		//middle left
		srcRectRect.x = 0;
		srcRectRect.y = slice[2];
		srcRectRect.width = slice[0];
		srcRectRect.height = slice[3] - slice[2];

		dstRect.x = 0;
		dstRect.y = slice[2];
		dstRect.width = slice[0];
		dstRect.height = targetHeight - slice[2] - (bmp.height - slice[3]);

		drawBitmapSlice(target, bmp, srcRectRect, dstRect, smooth);

		//middle middle
		srcRectRect.x = slice[0];
		srcRectRect.y = slice[2];
		srcRectRect.width = slice[1] - slice[0];
		srcRectRect.height = slice[3] - slice[2];

		dstRect.x = slice[0];
		dstRect.y = slice[2];
		dstRect.width = targetWidth - slice[0] - (bmp.width - slice[1]);
		dstRect.height = targetHeight - slice[2] - (bmp.height - slice[3]);

		drawBitmapSlice(target, bmp, srcRectRect, dstRect, smooth);

		//middle right
		srcRectRect.x = slice[1];
		srcRectRect.y = slice[2];
		srcRectRect.width = bmp.width - slice[1];
		srcRectRect.height = slice[3] - slice[2];

		dstRect.x = targetWidth - srcRectRect.width;
		dstRect.y = slice[2];
		dstRect.width = srcRectRect.width;
		dstRect.height = targetHeight - slice[2] - (bmp.height - slice[3]);

		drawBitmapSlice(target, bmp, srcRectRect, dstRect, smooth);

		//bottom left
		srcRectRect.x = 0;
		srcRectRect.y = slice[3];
		srcRectRect.width = slice[0];
		srcRectRect.height = bmp.height - slice[3];

		dstRect.x = 0;
		dstRect.y = targetHeight - srcRectRect.height;
		dstRect.width = slice[0];
		dstRect.height = srcRectRect.height;

		drawBitmapSlice(target, bmp, srcRectRect, dstRect, smooth);

		//bottom middle
		srcRectRect.x = slice[0];
		srcRectRect.y = slice[3];
		srcRectRect.width = slice[1] - slice[0];
		srcRectRect.height = bmp.height - slice[3];

		dstRect.x = slice[0];
		dstRect.y = targetHeight - srcRectRect.height;
		dstRect.width = targetWidth - slice[0] - (bmp.width - slice[1]);
		dstRect.height = srcRectRect.height;

		drawBitmapSlice(target, bmp, srcRectRect, dstRect, smooth);

		//bottom right
		srcRectRect.x = slice[1];
		srcRectRect.y = slice[3];
		srcRectRect.width = bmp.width - slice[1];
		srcRectRect.height = bmp.height - slice[3];

		dstRect.x = targetWidth - srcRectRect.width;
		dstRect.y = targetHeight - srcRectRect.height;
		dstRect.width = srcRectRect.width;
		dstRect.height = srcRectRect.height;

		drawBitmapSlice(target, bmp, srcRectRect, dstRect, smooth);

		return target;
	}

	public static inline function slice3(w:Sprite, targetWidth:Float, targetHeight:Float, bmp:BitmapData,
	                                     slice:Array<Int>, smooth:Bool = false):Sprite
	{
		w.graphics.clear();

		var w1:Int = 0;
		var w2:Int = 0;

		//slice two equal size parts
		if(slice == null || slice.length == 0)
		{
			w1 = Std.int(bmp.width / 2);
			w2 = w1 + 1;
			//two different size parts
		}
		else if(slice.length == 1)
		{
			w1 = slice[0];
			w2 = w1 + 1;
			//slice three parts
		}
		else
		{
			w1 = slice[0];
			w2 = slice[1];
		}

		var srcRect:Rectangle = new Rectangle();
		var dstRect:Rectangle = new Rectangle();

		//left
		srcRect.x = 0;
		srcRect.y = 0;
		srcRect.width = w1;
		srcRect.height = bmp.height;

		dstRect.x = 0;
		dstRect.y = 0;
		dstRect.width = w1;
		dstRect.height = (bmp.height);
		dstRect.height = bmp.height;

		drawBitmapSlice(w, bmp, srcRect, dstRect, smooth);

		//middle
		srcRect.x = w1;
		srcRect.y = 0;
		srcRect.width = w2 - w1;
		srcRect.height = bmp.height;

		dstRect.x = w1;
		dstRect.y = 0;
		dstRect.width = targetWidth - w1 - (bmp.width - w2);
		dstRect.height = bmp.height;

		drawBitmapSlice(w, bmp, srcRect, dstRect, smooth);

		//right
		srcRect.x = w2;
		srcRect.y = 0;
		srcRect.width = bmp.width - w2;
		srcRect.height = bmp.height;

		dstRect.x = targetWidth - srcRect.width;
		dstRect.y = 0;
		dstRect.width = srcRect.width;
		dstRect.height = bmp.height;

		drawBitmapSlice(w, bmp, srcRect, dstRect, smooth);

		return w;

	}

	/**
	* Draw a bitmap slice for 3- or 9- slice scaling
	* 
	*/

	public static inline function drawBitmapSlice(target:Sprite, sourceBitmap:BitmapData, sourceRect:Rectangle,
	                                              destinationRect:Rectangle, smooth:Bool = false):Void
	{
		#if neko
		var color = {rgb: 0xFF0000, a: 0xFF};
		var fill = new BitmapData(Std.int(sourceRect.width), Std.int(sourceRect.height), true, color);
		#else
		var fill = new BitmapData(Std.int(sourceRect.width), Std.int(sourceRect.height), true, 0x00FFFFFF);
		#end
		
		fill.copyPixels(sourceBitmap, sourceRect, new Point(0, 0));

		var drawMX = new Matrix();
		drawMX.scale(destinationRect.width / fill.width, destinationRect.height / fill.height);
		drawMX.translate(destinationRect.x, destinationRect.y);

		target.graphics.beginBitmapFill(fill, drawMX, false, smooth);
		target.graphics.drawRect(destinationRect.x, destinationRect.y, destinationRect.width, destinationRect.height);
		target.graphics.endFill();
	}

}