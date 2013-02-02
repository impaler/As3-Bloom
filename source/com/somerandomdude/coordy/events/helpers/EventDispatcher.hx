package com.somerandomdude.coordy.events.helpers;

class Listener
{
	public var mListner : Dynamic->Void;
	public var mUseCapture : Bool;
	public var mPriority : Int;
	static var sIDs = 1;
	public var mID:Int;

	public function new(inListener,inUseCapture,inPriority)
	{
		mListner = inListener;
		mUseCapture = inUseCapture;
		mPriority = inPriority;
		mID = sIDs++;
	}

	public function Is(inListener,inCapture)
		return Reflect.compareMethods(mListner, inListener) && mUseCapture == inCapture

	public function dispatchEvent(event : Event)
		mListner(event)
}

typedef ListenerList = Array<Listener>;
typedef EventMap = Array<ListenerList>;

class EventDispatcher implements IEventDispatcher
{
	var jeashTarget:IEventDispatcher;
	var jeashEventMap : EventMap;

	static private function compareListeners(l1:Listener,l2:Listener):Int{
		return l1.mPriority==l2.mPriority?0:(l1.mPriority>l2.mPriority?-1:1);
	}

	public function new(?target : IEventDispatcher) : Void {
		if(target != null)
			jeashTarget = target;
		else
			jeashTarget = this;
		jeashEventMap = [];
	}

	private function getList(type:String)
		untyped return jeashEventMap[type]
	
	private function setList(type:String, list:ListenerList)
		untyped jeashEventMap[type] = list

	private function existList(type:String)
		untyped return jeashEventMap[type] != __js__("undefined")

	public function addEventListener(type:String, inListener:Dynamic->Void,
			?useCapture:Bool /*= false*/, ?inPriority:Int /*= 0*/,
			?useWeakReference:Bool /*= false*/):Void {
		var capture:Bool = useCapture==null ? false : useCapture;
		var priority:Int = inPriority==null ? 0 : inPriority;

		var list = getList(type);

		if (!existList(type)) {
			list = [];
			setList(type, list);
		}

		list.push(new Listener(inListener,capture,priority));
		list.sort(compareListeners);
	}

	public function dispatchEvent(event : Event) : Bool {
		if(event.target == null)
			event.target = jeashTarget;

		var capture = event.eventPhase==EventPhase.CAPTURING_PHASE;
		if (existList(event.type)) {
			var list = getList(event.type);
			var idx = 0;
			while(idx<list.length) {
				var listener = list[idx];
				if (listener.mUseCapture==capture) {
					listener.dispatchEvent(event);
					if (event.jeashGetIsCancelledNow())
						return true;
				}
				// Detect if the just used event listener was removed...
				if (idx<list.length && listener!=list[idx]) {
					// do not advance to next item because it looks like one was just removed
				} else
					idx++;
			}
			return true;
		}

		return false;
	}

	public function hasEventListener(type : String)
		return existList(type)

	public function removeEventListener(type : String, listener : Dynamic->Void,
			?inCapture : Bool) : Void
	{
		if (!existList(type)) return;

		var list = getList(type);
		var capture:Bool = inCapture==null ? false : inCapture;
		for(i in 0...list.length)
		{
			if (list[i].Is(listener,capture))
			{
				list.splice(i,1);
				return;
			}
		}
	}

	public function toString() return Std.string(this)

	public function willTrigger(type : String) : Bool
		return hasEventListener(type)
}
