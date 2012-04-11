package bloom.utils {

import bloom.components.controls.ButtonBase;
import bloom.core.ComponentConstants;
import bloom.style.brush.ColorBrush;
import bloom.style.components.controls.ButtonBaseStyle;

import flash.display.DisplayObject;
import flash.display.Sprite;

public class ComponentUtils {

	public static function createTestButton (width:Number = 200,height:Number = 200):ButtonBase {
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

	public static function createTestIcon (width:Number = 50,height:Number = 50):Sprite {
		var testIcon:Sprite = new Sprite ();

		testIcon.graphics.beginFill (ColorUtils.randomColor ());
		testIcon.graphics.drawRect (0,0,width,height);
		testIcon.graphics.endFill ();

		return testIcon;
	}

	public static function resizeProportionaly (image:DisplayObject,maxW:Number = 100,maxH:Number = 100):void {

		var ratio:Number = image.height / image.width;

		if (image.width > maxW) {
			image.width = maxW;
			image.height = Math.round (image.width * ratio);
		}

		if (image.height > maxH) {
			image.height = maxH;
			image.width = Math.round (image.height / ratio);
		}
	}

	public static function random_min_max (max:Number,min:Number = 0):Number {
		return Math.random () * ( max - min ) + min;
	}

	public static function round_decimal_place (numIn:Number,decimalPlaces:int):Number {
		var nExp:int = Math.pow (10,decimalPlaces);
		var nRetVal:Number = Math.round (numIn * nExp) / nExp;

		return nRetVal;
	}

}
}
