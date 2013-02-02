package omni.components.core.signals;

import omni.components.core.signals.OSignal;

import nme.events.MouseEvent;
import nme.display.DisplayObjectContainer;

/**
* 
* NME Based Mouse Signal
* 
* Provides a new API and organisation for the event system of all mouse events to an nme.display
* .DisplayObjectContainer.
* 
* Based on work by ralcr/sdk.ralcr and robertpenner/as3-signals
* 
**/
class OSignalMouse extends OSignal<OSignalMouse -> Void>
{

	inline public static var UP = "mouseup";
	inline public static var DOWN = "mousedown";
	inline public static var OVER = "mouseover";
	inline public static var OUT = "mouseout";
	inline public static var MOVE = "mousemove";
	inline public static var CLICK = "mouseclick";
	inline public static var DOUBLE_CLICK = "mousedoubleclick";
	inline public static var WHEEL = "mousewheel";

	public var target:Dynamic;
	public var type:String;
	public var event:MouseEvent;
	public var delta:Int;

	private var displayTarget:DisplayObjectContainer;

	public function new(type:String, target:DisplayObjectContainer, ?pos:haxe.PosInfos)
	{
		super();

		this.type = type;
		this.target = target;
		this.delta = 0;
		this.displayTarget = target;

		addEventListener(pos);
	}

	function addEventListener(?pos:haxe.PosInfos):Void
	{
		switch (type) {
			case UP: displayTarget.addEventListener(MouseEvent.MOUSE_UP, mouseHandler);
			case DOWN: displayTarget.addEventListener(MouseEvent.MOUSE_DOWN, mouseHandler);
			case OVER: displayTarget.addEventListener(MouseEvent.MOUSE_OVER, mouseHandler);
			case OUT: displayTarget.addEventListener(MouseEvent.MOUSE_OUT, mouseHandler);
			case MOVE: displayTarget.addEventListener(MouseEvent.MOUSE_MOVE, mouseHandler);
			case CLICK: displayTarget.addEventListener(MouseEvent.CLICK, mouseHandler);
			case DOUBLE_CLICK: displayTarget.addEventListener(MouseEvent.DOUBLE_CLICK, mouseHandler);
			case WHEEL: displayTarget.addEventListener(MouseEvent.MOUSE_WHEEL, mouseHandler);
			default: OCore.error("The mouse event you're trying to add does not exist. " + pos);
		}
	}

	function removeEventListener()
	{
		switch (type) {
			case UP: displayTarget.removeEventListener(MouseEvent.MOUSE_UP, mouseHandler);
			case DOWN: displayTarget.removeEventListener(MouseEvent.MOUSE_DOWN, mouseHandler);
			case OVER: displayTarget.removeEventListener(MouseEvent.MOUSE_OVER, mouseHandler);
			case OUT: displayTarget.removeEventListener(MouseEvent.MOUSE_OUT, mouseHandler);
			case MOVE: displayTarget.removeEventListener(MouseEvent.MOUSE_MOVE, mouseHandler);
			case CLICK: displayTarget.removeEventListener(MouseEvent.CLICK, mouseHandler);
			case DOUBLE_CLICK: displayTarget.removeEventListener(MouseEvent.DOUBLE_CLICK, mouseHandler);
			case WHEEL: displayTarget.removeEventListener(MouseEvent.MOUSE_WHEEL, mouseHandler);
		}
	}

	function mouseHandler(e:MouseEvent)
	{
		//todo?
//		e.stopImmediatePropagation();
//		e.stopPropagation();
		this.event = e;
		this.delta = e.delta;
		dispatch(this);
	}

	public function updateAfterEvent():Void
	{
		event.updateAfterEvent();
	}

	override public function destroy():Void
	{
		removeEventListener();
		super.destroy();
	}
}