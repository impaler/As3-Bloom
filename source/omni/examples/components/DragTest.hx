package omni.examples.components;

import omni.components.utils.ComponentUtils;
import nme.display.Sprite;
import nme.events.MouseEvent;
import nme.events.Event;

class DragTest
{


	public function new():Void
	{
		var myDraggerThing:MouseSpeed = new MouseSpeed(.1,.95); 
		nme.Lib.stage.addChild (myDraggerThing);  
	}


}