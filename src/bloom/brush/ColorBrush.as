
package bloom.brush {

import flash.display.Sprite;

public class ColorBrush extends Brush {

	public var colors:Vector.<uint>;

	public function ColorBrush ( colors:Vector.<uint> = null ) {
		super ();
		this.colors = colors;
	}

	override public function update ( state:int , value:* , args:Object = null ):void {
		var _value:Sprite = value as Sprite;
		
		_value.graphics.clear ();
		_value.graphics.beginFill ( colors[state] );
		_value.graphics.drawRect ( args.x , args.y , args.width , args.height );
		_value.graphics.endFill ();
	}

	override public function destroy ():void {
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
