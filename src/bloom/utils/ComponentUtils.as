package bloom.utils {

import bloom.components.controls.ButtonBase;
import bloom.core.ComponentConstants;
import bloom.style.brush.ColorBrush;
import bloom.style.components.controls.ButtonBaseStyle;

public class ComponentUtils {

	public static function createIconButtonTest (width:Number=200,height:Number=200):ButtonBase {
		var IconButton:ButtonBase = new ButtonBase ();
		IconButton.size (width,height);
		var IconStyle:ButtonBaseStyle = new ButtonBaseStyle ();
		var _scaleBitmaps:Vector.<uint> = new Vector.<uint> (4,true);
		_scaleBitmaps[ComponentConstants.ACTIVE] = ColorUtils.randomColor ();
		_scaleBitmaps[ComponentConstants.OVER] = ColorUtils.randomColor ();
		_scaleBitmaps[ComponentConstants.ACTIVATED] = ColorUtils.randomColor ();
		_scaleBitmaps[ComponentConstants.DISABLED] = ColorUtils.randomColor ();
		IconStyle.background = new ColorBrush (_scaleBitmaps);
		IconButton.style = IconStyle;

		return IconButton;
	}

}
}
