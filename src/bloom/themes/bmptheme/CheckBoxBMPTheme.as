/**
 * Created by IntelliJ IDEA.
 * User: omni
 * Date: 24/01/12
 * Time: 7:49 PM
 * To change this template use File | Settings | File Templates.
 */
package bloom.themes.bmptheme {

import bloom.brushes.BMPBrush;
import bloom.core.ScaleBitmap;
import bloom.themes.ITheme;
import bloom.themes.ThemeBase;

import flash.display.Bitmap;

public class CheckBoxBMPTheme implements ITheme {
	// checkBox
	[Embed(source="../../assets/defaultBMP/checkbox/checkbox_on.png")]
	private var checkbox_on:Class;

	[Embed(source="../../assets/defaultBMP/checkbox/checkbox_off.png")]
	private var checkbox_off:Class;

	public function initialize ():void {
		var data:Vector.<ScaleBitmap>;
		var scaleBMP0:ScaleBitmap;
		var scaleBMP1:ScaleBitmap;

		var OFF:int = 0;
		var ON:int = 1;

		// CheckBox
		data = new Vector.<ScaleBitmap> ( 2 , true );
		data[OFF] = new ScaleBitmap ( Bitmap ( new checkbox_off () ).bitmapData );
		data[ON] = new ScaleBitmap ( Bitmap ( new checkbox_on () ).bitmapData );
		ThemeBase.CheckBox = new BMPBrush ( data );

	}
}
}

