package omni.components.core;

import omni.components.core.interfaces.IOComponent;

import nme.Lib;
import nme.display.Stage;
import nme.events.Event;
import nme.events.TimerEvent;

/**
* 
* Render Manager
* 
* @description The render manager controls all of the main draw calls 
* of every component through a very basic invalidation cycle.
* 
* Based on code from aswing.org and their wonderful haxe port
* 
**/
class ORenderManager
{

	public var rendering:Bool;
	private var renderList:Array<IOComponent>;

	public static var instance(getInstance, null):ORenderManager;

	private static function getInstance():ORenderManager
	{
		if(instance == null)
		{
			instance = new ORenderManager();
		}
		return instance;
	}

	public function new()
	{
		rendering = false;
		renderList = new Array<IOComponent>();
	}

	public function addToRenderList(com:IOComponent):Void
	{
		if(com.invalid)
		{
			renderList.push(com);
			renderLater();
		}
	}

	private function renderLater():Void
	{
		var st:Stage = nme.Lib.current.stage;

		st.addEventListener(Event.RENDER, _render, false, 0, true);
		st.invalidate();
	}

	private function _render(e:Dynamic = null):Void
	{
		if(e != null)
		{
			var st:Stage = nme.Lib.current.stage;
			st.removeEventListener(Event.RENDER, _render);
		}

		var i:Int;
		var n:Int;
		var component:IOComponent;
		var time:Int = Lib.getTimer();
		var processRenderList:Array<IOComponent> = renderList.copy();
		renderList = new Array<IOComponent>();
		n = processRenderList.length;
		rendering = true;
		i = - 1;
		while((++ i) < n)
		{
			component = processRenderList[i];
			component.draw();
		}
		if(n > 0)
		{
//			trace("Rendered - " + n + " with render time of : " + (Lib.getTimer() - time) + " ms");
			processRenderList = null;
			rendering = false;
		}
	}

}
