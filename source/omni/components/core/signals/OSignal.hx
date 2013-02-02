package omni.components.core.signals;

import omni.components.core.interfaces.IDestroyable;

/**
* 
* NME Based Signal Event System
* 
* Provides a basic signal based event system.
* 
* Based on work by ralcr/sdk.ralcr and robertpenner/as3-signals
* 
**/
class OSignal<T> implements IDestroyable
{

	private var listeners:List<T>;
	private var exposableListener:T;

	public var enabled:Bool;

	public function new()
	{
		enabled = true;
		removeAll();
	}

	public function add(listener:T)
	{
		listeners.add(listener);
	}

	//todo list of exposablelisteners???
	public function addOnce(listener:T, ?pos:haxe.PosInfos)
	{
		if(exists(listener))
		{
			//			OCore.error(trace("This listener is already added, it will not be called only once as you expect. " + pos));
		}
		exposableListener = listener;
	}

	public function addFirst(listener:T, ?pos:haxe.PosInfos)
	{
		listeners.push(listener);
	}

	public function remove(listener:T):Void
	{
		for(l in listeners)
		{
			if(Reflect.compareMethods(l, listener))
			{
				listeners.remove(l);
				//todo Using listener instead of l will not work (tested in js haxe 2.9)
				break;
			}
		}
		if(Reflect.compareMethods(exposableListener, listener))
		{
			exposableListener = null;
		}
	}

	public function removeAll():Void
	{
		listeners = new List<T>();
		exposableListener = null;
	}

	public function dispatch(?p1:Dynamic, ?p2:Dynamic, ?p3:Dynamic, ?p4:Dynamic, ?pos:haxe.PosInfos):Void
	{
		if(! enabled) return;
		var args = new Array<Dynamic>();
		for(p in [p1, p2, p3, p4])
			if(p != null)
				args.push(p);
			else
				break;

		for(o in listeners) {
			callMethod(o, args, pos);
		}
		
		if(exposableListener != null)
		{
			callMethod(exposableListener, args, pos);
			exposableListener = null;
		}
	}

	function callMethod(listener:T, ?args:Array<Dynamic>, ?pos:haxe.PosInfos)
	{
		try
		{
			Reflect.callMethod(null, listener, args);
		}
		catch(e:Dynamic)
		{
			//			OCore.error("OSignal error: " + e + ", called from: " + Std.string(pos));
		}
	}

	public function exists(listener:T):Bool
	{
		for(l in listeners)
		{
			if(l == listener)
				return true;
		}
		return false;
	}

	public function destroy():Void
	{
		listeners = null;
		exposableListener = null;
	}
}