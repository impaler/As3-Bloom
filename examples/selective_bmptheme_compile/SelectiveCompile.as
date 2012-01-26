package selective_bmptheme_compile {

import bloom.*;
import bloom.containers.*;
import bloom.themes.*;

import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;

/**
 * Selective Compile
 *
 * @author sindney
 */
[SWF(backgroundColor=0x000000 , frameRate=40 , width=640 , height=320)]
public class SelectiveCompile extends Sprite {

	public function SelectiveCompile () {
		super ();
		stage.align = StageAlign.TOP_LEFT;
		stage.scaleMode = StageScaleMode.NO_SCALE;
		stage.showDefaultContextMenu = false;

		// setup a theme to only compile the required BMP assets, we have to do this manually
		ThemeBase.setTheme ( new SelectiveBMPTheme () );

		// flow container object.
		var flowContainer:FlowContainer = new FlowContainer ( this );
		flowContainer.direction = FlowContainer.VERTICALLY;
		flowContainer.move ( 10 , 10 );
		flowContainer.size ( 150 , 600 );

		var button:Button = new Button ( flowContainer , "We only have two components and the filesize is still small :)" );
		button.size( 600, 200 );

		var numericStepper:NumericStepper = new NumericStepper ( flowContainer , 50 , 100 , - 100 , 10 );

	}

}

}
