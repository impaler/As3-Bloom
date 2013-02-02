package omni.examples.components;

import omni.examples.components.DragTest;
import omni.components.core.OCore;
import omni.components.theme.orange.Orange;

import nme.Lib;
import nme.display.StageScaleMode;
import nme.display.Sprite;
import nme.display.StageAlign;
import nme.text.TextField;
import nme.display.MovieClip;

#if cpp
import hxcpp.DebugSocket;
#end

class HelloWorld extends MovieClip
{

	private var debug:TextField;

	public function new()
	{
		Lib.current.stage.align = StageAlign.TOP_LEFT;
		Lib.current.stage.scaleMode = StageScaleMode.NO_SCALE;
		super();
		
		OCore.instance.init(Orange);
		
//		var signals = new SignalsTests();
//		var brushes = new BrushTests();
//		var buttons = new ButtonTests();
//		var layouts = new LayoutTests();
//		var sliders = new SliderTests();
		var scrollContainers = new ScrollContainerTests();
//		var drag = new DragTest();
//		var grid = new GridLayout();
//		var text = new TextTest();
		
	}

	public static function main()
	{
		Lib.current.addChild(new HelloWorld());
	}

}
