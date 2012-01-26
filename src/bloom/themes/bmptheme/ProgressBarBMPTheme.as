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
import flash.geom.Rectangle;

public class ProgressBarBMPTheme implements ITheme {
	[Embed(source="../../assets/defaultBMP/progressbar/progress_bg.png")]
	private var progress_bg:Class;

	[Embed(source="../../assets/defaultBMP/progressbar/progress_bar.png")]
	private var progress_bar:Class;

	public function initialize ():void {
		var data:Vector.<ScaleBitmap>;
		var scaleBMP0:ScaleBitmap;
		var scaleBMP1:ScaleBitmap;

		scaleBMP0 = new ScaleBitmap ( Bitmap ( new progress_bg () ).bitmapData );
		scaleBMP0.scale9Grid = new Rectangle ( 7 , 7 , 2 , 2 );

		scaleBMP1 = new ScaleBitmap ( Bitmap ( new progress_bar () ).bitmapData );
		scaleBMP1.scale9Grid = new Rectangle ( 7 , 7 , 2 , 2 );

		data = new Vector.<ScaleBitmap> ( 2 , true );
		data[0] = scaleBMP0;
		data[1] = scaleBMP1;
		ThemeBase.ProgressBar = new BMPBrush ( data );
	}
}
}






