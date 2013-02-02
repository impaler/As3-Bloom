package omni.examples.components;

#if cpp
import hxcpp.DebugSocket;
#end

import omni.components.core.signals.OSignal;

class SignalsTests
{

	public function new()
	{

		nme.Lib.trace("Log: Signal test");
		var signal = new OSignal<Void -> Void>();
		signal.add(signalVoid);
		//		signal.addOnce ( signal );
		//		signal.remove ( signal );
		//		signal.removeAll();
		for(i in 0...5)
			signal.dispatch();

		var Signal1 = new OSignal<Int -> Void>();
		Signal1.add(signalInt);
		Signal1.remove(signalInt);
		nme.Lib.trace("Log: Signal1 remove");
		for(i in 0...5)
			Signal1.dispatch(Math.random() * 32);
		nme.Lib.trace("Log: Signal1 remove Done");

		var Signal1 = new OSignal<Int -> Void>();
		Signal1.add(signalInt);
		Signal1.add(function(e:Int)
		            {
			            nme.Lib.trace(e);
		            });
		Signal1.add(function(e:Int)
		            {
			            nme.Lib.trace(e);
		            });
		Signal1.removeAll();
		nme.Lib.trace("Log: Signal1 removeAll");
		for(i in 0...5)
			Signal1.dispatch(Math.random() * 32);
		nme.Lib.trace("Log: Signal1 removeAll Done");

		var Signal1 = new OSignal<Int -> Void>();
		Signal1.addOnce(signalInt);
		nme.Lib.trace("Log: Signal1 addOnce");
		for(i in 0...5)
			Signal1.dispatch(Math.random() * 32);
		nme.Lib.trace("Log: Signal1 addOnce Done");

		nme.Lib.trace("Log: Signal1 add");
		Signal1.add(signalInt);
		for(i in 0...5)
			Signal1.dispatch(Math.random() * 32);
		nme.Lib.trace("Log: Signal1 add Done");
		
		#if cpp
		new DebugSocket("127.0.0.1", 65333, true);
		#end
		
		//todo
	}

	public function signalVoid():Void
	{
		nme.Lib.trace("Dispatched signalVoid");
	}

	public function signalInt(e:Int):Void
	{
		nme.Lib.trace(e);
	}

}
