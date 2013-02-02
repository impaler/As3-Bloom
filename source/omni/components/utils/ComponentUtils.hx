package omni.components.utils;

import nme.display.BitmapData;
import nme.geom.Matrix;
import omni.components.core.interfaces.IOComponent;
import omni.components.utils.ColorUtils;
import omni.components.core.OCore;

import nme.Lib;
import nme.display.Sprite;
import nme.geom.Rectangle;
import nme.text.TextFormatAlign;
import nme.display.DisplayObject;

/**
 * Class containing a variety of color utility methods.
 */
class ComponentUtils
{

	public inline static function moveToRandomSpot(component:IOComponent):Void
	{
		var maxX = Lib.current.stage.stageWidth;
		var maxY = Lib.current.stage.stageHeight;
		component.move(random_min_max(0, maxX), random_min_max(0, maxY));
	}

	public inline static function resizeProportionaly(image:DisplayObject, maxW:Float = 100, maxH:Float = 100):Void
	{
		var ratio:Float = image.height / image.width;
		if(image.width > maxW)
		{
			image.width = maxW;
			image.height = Math.round(image.width * ratio);
		}
		if(image.height > maxH)
		{
			image.height = maxH;
			image.width = Math.round(image.height / ratio);
		}
	}

	public inline static function random_min_max(max:Float, min:Float = 0):Float
	{
		return Math.random() * ( max - min ) + min;
	}

	public inline static function round_decimal_place(numIn:Float, decimalPlaces:Int):Float
	{
		var nExp:Float = Math.pow(10, decimalPlaces);
		var nRetVal:Float = Math.round(numIn * nExp) / nExp;
		return nRetVal;
	}

	public inline static function clamp(value:Float, min:Float, max:Float):Float
	{
		if(value < min)
			return min;
		else if(value > max)
			return max;
		else
			return value;
	}

	public static function convertTextAlignmentToString(value:Dynamic):String
	{
		return Std.string(value);
	}

	/**
	 * Method for converting string to TextFormatAlign
	 */
	#if (flash || js)

	public static function convertTextAlignmentFromString(strAlign:String):TextFormatAlign
	{
		if(strAlign == "right")
		{
			return TextFormatAlign.RIGHT;
		}
		else if(strAlign == "center")
		{
			return TextFormatAlign.CENTER;
		}
		else if(strAlign == "justify")
		{
			return TextFormatAlign.JUSTIFY;
		}
		else
		{
			return TextFormatAlign.LEFT;
		}
	}

	#elseif (cpp || neko)

	public static function convertTextAlignmentFromString(strAlign:String):String
	{
		return strAlign;
	}

	#end

	public static inline function VAlignToOther(moving:IOComponent, target:IOComponent):Void
	{
		moving.y = (target._height * .5) - (moving._height * .5);
	}

	public static inline function HAlignToOther(moving:IOComponent, target:IOComponent):Void
	{
		moving.x = (target._width * .5) - (moving._width * .5);
	}

	public static inline function createTestSprite():Sprite
	{
		var sprite = new Sprite();
		var graphics = sprite.graphics;
		graphics.beginFill(0xff0022);
		graphics.drawRect(0, 0, 200, 200);
		graphics.endFill();
		return sprite;
	}

	public static function scaleBitmapData(source:BitmapData, targetWidth:Float, targetHeight:Float,
	                                       smooth:Bool = true):BitmapData
	{
		var mat:Matrix = new Matrix();
		mat.scale(targetWidth / source.width, targetHeight / source.height);

		var newBitmap = new BitmapData(Std.int(targetWidth), Std.int(targetHeight), false);
		newBitmap.draw(source, mat, null, null, null, smooth);

		return newBitmap;
	}

	//todo test and do multiple directions

	public static function joinBitmapData(source1:BitmapData, source2:BitmapData, direction:Int = 0,
	                                      smooth:Bool = true):BitmapData
	{
		var newHeight=0;
		if(direction == 0)
		{
			newHeight = source1.height * 2;
		}

		var newWidth=0;
		if(direction == 0)
		{
			newWidth = source1.width;
		}

		var bitmapTestDouble = new BitmapData(newWidth, newHeight);
		bitmapTestDouble.draw(source1);

		var matrix = new Matrix();
		matrix.translate(0, source1.height);

		bitmapTestDouble.draw(source2, matrix, null, null, null, smooth);

		return bitmapTestDouble;
	}

}
