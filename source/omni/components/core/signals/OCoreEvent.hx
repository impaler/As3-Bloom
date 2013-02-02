package omni.components.core.signals;

import omni.components.core.signals.OSignal;

import nme.events.Event;
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
class OCoreEvent extends OSignal<OCoreEvent -> Void>
{
//	inline public static var ACTIVATE = "activate";
//	inline public static var ADDED = "added";
	inline public static var ADDED_TO_STAGE = "addedToStage";
//	inline public static var CANCEL = "cancel";
	inline public static var CHANGE = "change";
//	inline public static var CLOSE = "close";
//	inline public static var COMPLETE = "complete";
//	inline public static var CONNECT = "connect";
//	inline public static var CONTEXT3D_CREATE = "context3DCreate";
//	inline public static var DEACTIVATE = "deactivate";
	inline public static var ENTER_FRAME = "enterFrame";
//	inline public static var ID3 = "id3";
//	inline public static var INIT = "init";
	inline public static var MOUSE_LEAVE = "mouseLeave";
//	inline public static var OPEN = "open";
//	inline public static var REMOVED = "removed";
	inline public static var REMOVED_FROM_STAGE = "removedFromStage";
	inline public static var RENDER = "render";
	inline public static var RESIZE = "resize";
//	inline public static var SCROLL = "scroll";
//	inline public static var SELECT = "select";
//	inline public static var SOUND_COMPLETE = "soundComplete";
//	inline public static var TAB_CHILDREN_CHANGE = "tabChildrenChange";
//	inline public static var TAB_ENABLED_CHANGE = "tabEnabledChange";
//	inline public static var TAB_INDEX_CHANGE = "tabIndexChange";
//	inline public static var UNLOAD = "unload";

	public var target:Dynamic;
	public var type:String;
	public var e:Event;
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
			case RESIZE: displayTarget.addEventListener(Event.RESIZE, eventHandler);
			case CHANGE: displayTarget.addEventListener(Event.CHANGE, eventHandler);
			case ENTER_FRAME: displayTarget.addEventListener(Event.ENTER_FRAME, eventHandler);
			case RENDER: displayTarget.addEventListener(Event.RENDER, eventHandler);
			case REMOVED_FROM_STAGE: displayTarget.addEventListener(Event.REMOVED_FROM_STAGE, eventHandler);
			case ADDED_TO_STAGE: displayTarget.addEventListener(Event.ADDED_TO_STAGE, eventHandler);
			case MOUSE_LEAVE: displayTarget.addEventListener(Event.MOUSE_LEAVE, eventHandler);
			default: OCore.error("The event you're trying to add does not exist. " + pos);
		}
	}

	function removeEventListener()
	{
		switch (type) {
			case RESIZE: displayTarget.removeEventListener(Event.RESIZE, eventHandler);
			case CHANGE: displayTarget.removeEventListener(Event.CHANGE, eventHandler);
			case ENTER_FRAME: displayTarget.removeEventListener(Event.ENTER_FRAME, eventHandler);
			case RENDER: displayTarget.removeEventListener(Event.RENDER, eventHandler);
			case REMOVED_FROM_STAGE: displayTarget.removeEventListener(Event.REMOVED_FROM_STAGE, eventHandler);
			case ADDED_TO_STAGE: displayTarget.removeEventListener(Event.ADDED_TO_STAGE, eventHandler);
			case MOUSE_LEAVE: displayTarget.removeEventListener(Event.MOUSE_LEAVE, eventHandler);
		}
	}

	function eventHandler(e:Event)
	{
		this.e = e;
		dispatch(this);
	}

	override public function destroy():Void
	{
		removeEventListener();
		super.destroy();
	}
}
