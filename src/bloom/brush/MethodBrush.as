package bloom.brush {

public class MethodBrush extends Brush {

	public var methods:Vector.<Function>;

	public function MethodBrush ( methods:Vector.<Function> = null ) {
		super ();
		this.methods = methods;
	}

	override public function update ( state:int , value:* , args:Object = null ):void {
		var methodToPerform:Function = methods[state];
		methodToPerform(value, args);
	}

	override public function destroy ():void {
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
