package omni.components.utils;

/**
 * ColorUtils
 * Useful color utils
 *
 */
class ColorUtils
{

	/**
	 *  Return a random Color
	 *
	 * @return
	 */
	public static inline function randomColor():Int
	{
		return Std.int(Math.random() * WHITE);
	}

	public static var WHITE:Int = 0xffffff;

	public static var LIGHT_GRAY:Int = 0xc0c0c0;

	public static var GRAY:Int = 0x808080;

	public static var DARK_GRAY:Int = 0x404040;

	public static var BLACK:Int = 0x000000;

	public static var RED:Int = 0xff0000;

	public static var PINK:Int = 0xffafaf;

	public static var DARKER_ORANGE:Int = 0xca2900;

	public static var ORANGE_BRIGHT:Int = 0xfe963e;

	public static var ORANGE:Int = 0xff6c00;

	public static var LIGHT_ORANGE:Int = 0xffa360;

	public static var HALO_ORANGE:Int = 0xFFC200;

	public static var YELLOW:Int = 0xffff00;

	public static var GREEN:Int = 0x00ff00;

	public static var GREEN_LIGHT:Int = 0xd4ff00;

	public static var HALO_GREEN:Int = 0x80FF4D;

	public static var MAGENTA:Int = 0xff00ff;

	public static var CYAN:Int = 0x00ffff;

	public static var BLUE:Int = 0x0000ff;

	public static var HALO_BLUE:Int = 0x2BF5F5;

}
