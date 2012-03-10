package bloom.style.brush {

public class MethodBrush extends Brush {

	public var methods:Vector.<Function>;

	public function MethodBrush (methods:Vector.<Function> = null) {
		super ();
		this.methods = methods;
	}

	override public function update (state:int,value:*,args:Object = null):void {
		var methodToPerform:Function = methods[state];
		methodToPerform (value,args);
	}

	override public function dispose ():void {
		for each(var func:Function in methods) {
			func = null;
		}
		methods = null;
	}

	///////////////////////////////////
	// toString
	///////////////////////////////////

	public override function toString ():String {
		return "[bloom.brushes.MethodBrush]";
	}
}

}
