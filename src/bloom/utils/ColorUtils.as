/**
 * ColorUtils
 *
 * Useful color utils
 *
 * @see www.razorberry.com
 *
 */
package bloom.utils {

/**
 * Class containing a variety of color utility methods.
 */
public class ColorUtils {

	/**
	 *  Return a random Color
	 *
	 * @return
	 */
	public static function randomColor ():uint {
		var randArray:Array = new Array ();
		var randChar:String;
		var randNum:Number;
		var color:uint;
		var finalProduct:String = "0x";

		for (var j:int = 0; j < 6; j ++) {
			randNum = Math.round (Math.random () * 15);
			if (randNum < 10)
				randArray.push (String (randNum)); else {
				switch (randNum) {
					case 10:
						randChar = 'A';
						break;
					case 11:
						randChar = 'B';
						break;
					case 12:
						randChar = 'C';
						break;
					case 13:
						randChar = 'D';
						break;
					case 14:
						randChar = 'E';
						break;
					case 15:
						randChar = 'F';
						break;
				}
				randArray.push (randChar);
			}
		}

		for (var i:int = 0; i < 6; i ++) {
			finalProduct += randArray[i];
		}

		color = uint (finalProduct);

		return color;

	}

	/**
	 * Blend two colors with a scalar ratio.
	 * @param	first	The first color
	 * @param	second	The second color
	 * @param	ratio	The ratio of the second color to blend, .5 = equal ratio, .9 = 1:9, .2 = 8:2
	 * @return	The color value as a uint.
	 */
	public static function blend (first:uint,second:uint,ratio:Number):uint {
		var a:Number, b:Number, c:Number;
		a = ((first & 0xff) * (1 - ratio) + (second & 0xff) * ratio);
		b = (((first & 0xff00) >> 8) * (1 - ratio) + ((second & 0xff00) >> 8) * ratio);
		c = (((first & 0xff0000) >> 16) * (1 - ratio) + ((second & 0xff0000) >> 16) * ratio);

		return uint ((a) | (b << 8) | (c << 16));
	}

	/**
	 * Brighten (or darken) a color by a scalar amount.
	 * @param	color	The color to brighten/darken.
	 * @param	modifier	The scalar to modify the brightness, 0 = no change, ie. 0.9, 1.1
	 * @return	The modified color
	 */
	public static function brighten (color:uint,modifier:Number):Number {
		var z:Number = 0xff * modifier;
		var a:Number, b:Number, c:Number;
		a = (a = (color & 0xff) + z) > 0xFF ? 0xFF : ( a < 0 ? 0 : a);
		b = (b = ((color & 0xff00) >> 8) + z) > 0xFF ? 0xFF : ( b < 0 ? 0 : b);
		c = (c = ((color & 0xff0000) >> 16) + z) > 0xFF ? 0xFF : ( c < 0 ? 0 : c);

		return ((a) | (b << 8) | (c << 16));
	}

	/**
	 * Desaturate a color by a scalar amount. (0-1)
	 * This isn't a real desaturation, but blends the color with a neutral grey.
	 * @param	color	The color to desaturate
	 * @param	percent	The percentage of desaturation
	 * @return	The desaturated color
	 */
	public static function desaturate (color:uint,modifier:Number):Number {
		return blend (color,0x808080,modifier);
	}

	/**
	 * Fades a color by a scalar amount. (0-1)
	 * Basically just blends the color with white.
	 * @param	color	The color to fade
	 * @param	percent	The percentage of fade
	 * @return	The faded color
	 */
	public static function fade (color:uint,modifier:Number):Number {
		return blend (color,0xFFFFFF,modifier);
	}

	public static const WHITE:uint = 0xffffff;

	public static const LIGHT_GRAY:uint = 0xc0c0c0;

	public static const GRAY:uint = 0x808080;

	public static const DARK_GRAY:uint = 0x404040;

	public static const BLACK:uint = 0x000000;

	public static const RED:uint = 0xff0000;

	public static const PINK:uint = 0xffafaf;

	public static const ORANGE:uint = 0xffc800;

	public static const HALO_ORANGE:uint = 0xFFC200;

	public static const YELLOW:uint = 0xffff00;

	public static const GREEN:uint = 0x00ff00;

	public static const HALO_GREEN:uint = 0x80FF4D;

	public static const MAGENTA:uint = 0xff00ff;

	public static const CYAN:uint = 0x00ffff;

	public static const BLUE:uint = 0x0000ff;

	public static const HALO_BLUE:uint = 0x2BF5F5;

}

}

/*****************************************************************************
 *
 * blend,brighten,desaturate,fade from
 *
 * Razor Component Framework for ActionScript 3.
 * Copyright 2009 Ashley Atkins (www.razorberry.com)
 * Razor Component Framework, which is made available
 * under the MIT License.
 *
 *******************************************************************************/
