package bloom.brush {

import flash.display.Graphics;

public class ColorBrush extends Brush {

	public var colors:Vector.<uint>;

	public function ColorBrush (colors:Vector.<uint> = null) {
		super ();
		this.colors = colors;
	}

	override public function update (state:int,value:*,args:Object = null):void {
		var _value:Graphics = value as Graphics;

		_value.clear ();
		_value.beginFill (colors[state]);
		_value.drawRect (args.x,args.y,args.width,args.height);
		_value.endFill ();
	}

	override public function dispose ():void {
		colors = null;
	}

///////////////////////////////////
// toString
///////////////////////////////////

	public override function toString ():String {
		return "[bloom.brushes.ColorBrush]";
	}
}

}
