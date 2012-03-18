package bloom.utils {

import bloom.components.controls.ButtonBase;
import bloom.core.ComponentConstants;
import bloom.components.style.brush.ColorBrush;
import bloom.components.style.components.controls.ButtonBaseStyle;

public class ComponentUtils {

	public static function createIconButtonTest ():ButtonBase {
		var IconButton:ButtonBase = new ButtonBase ();
		IconButton.size (50,50);
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
