/**
 * Date: 12/02/12
 * Time: 5:07 PM
 */
package {

import bloom.core.Bloom;
import bloom.core.ButtonBase;
import bloom.theme.defaultTheme.DefaultTheme;

import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;

public class example_00 extends Sprite {
	public function example_00 () {
		stage.align = StageAlign.TOP_LEFT;
		stage.scaleMode = StageScaleMode.NO_SCALE;
		stage.showDefaultContextMenu = false;

		Bloom.core ().init ( stage , DefaultTheme );
		
		var thing:ButtonBase = new ButtonBase(this);
		
		
	}
}
}
