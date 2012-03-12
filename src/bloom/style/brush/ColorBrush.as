package bloom.style.brush {

import bloom.core.ObjectBase;

import flash.display.Graphics;
import flash.display.Sprite;

public class ColorBrush extends Brush {

	public var colors:Vector.<uint>;

	public function ColorBrush (colors:Vector.<uint> = null) {
		super ();
		this.colors = colors;
	}

	override public function update (state:int,value:*,args:ObjectBase = null):void {
		var _value:Graphics = Sprite (value).graphics;

		_value.clear ();
		_value.beginFill (colors[state]);
		_value.drawRect (0,0,args.width,args.height);
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
