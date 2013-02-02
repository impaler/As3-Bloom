package com.somerandomdude.coordy.events.helpers;

//import jeash.display.InteractiveObject;

//@:expose("Coordinantes.events.helpers.Event")
//@:keep
class Event
{
	public var bubbles(default,null) : Bool;
	public var cancelable(default,null) : Bool;
	public var eventPhase(default,null) : Int;
	public var target : Dynamic;
	public var currentTarget : Dynamic;
	public var type(default,null) : String;

	var jeashIsCancelled:Bool;
	var jeashIsCancelledNow:Bool;

	public static var ACTIVATE = "activate";
	public static var ADDED = "added";
	public static var ADDED_TO_STAGE = "addedToStage";
	public static var CANCEL = "cancel";
	public static var CHANGE = "change";
	public static var CLOSE = "close";
	public static var COMPLETE = "complete";
	public static var CONNECT = "connect";
	public static var DEACTIVATE = "deactivate";
	public static var ENTER_FRAME = "enterFrame";
	public static var ID3 = "id3";
	public static var INIT = "init";
	public static var MOUSE_LEAVE = "mouseLeave";
	public static var OPEN = "open";
	public static var REMOVED = "removed";
	public static var REMOVED_FROM_STAGE = "removedFromStage";
	public static var RENDER = "render";
	public static var RESIZE = "resize";
	public static var SCROLL = "scroll";
	public static var SELECT = "select";
	public static var TAB_CHILDREN_CHANGE = "tabChildrenChange";
	public static var TAB_ENABLED_CHANGE = "tabEnabledChange";
	public static var TAB_INDEX_CHANGE = "tabIndexChange";
	public static var UNLOAD = "unload";
	public static var SOUND_COMPLETE = "soundComplete";

	public function jeashSetPhase(phase:Int) { eventPhase = phase; }

	public function jeashGetIsCancelled() { return jeashIsCancelled; }
	public function jeashGetIsCancelledNow() { return jeashIsCancelledNow; }

	public function new(inType : String, inBubbles : Bool=false, inCancelable : Bool=false) {
		type = inType;
		bubbles = inBubbles;
		cancelable = inCancelable;
		jeashIsCancelled = false;
		jeashIsCancelledNow = false;
		target = null;
		currentTarget = null;
		eventPhase = EventPhase.AT_TARGET;
	}

	public function clone() : Event {
		return new Event(type,bubbles,cancelable);
	}

	public function stopImmediatePropagation() { jeashIsCancelledNow = jeashIsCancelled = true; }
	public function stopPropagation() { jeashIsCancelled = true; }

	public function toString():String { return "Event"; }

	public function jeashCreateSimilar(type:String, ?related:Dynamic, ?targ:Dynamic):Event {
		var result = new Event(type, bubbles, cancelable);

		if (targ!=null)
			result.target = targ;
		return result;
	}
}
