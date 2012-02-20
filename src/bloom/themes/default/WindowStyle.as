package bloom.themes.default {

import bloom.brush.Brush;
import bloom.brush.ColorBrush;
import bloom.brush.MethodBrush;
import bloom.components.Window;
import bloom.core.IStyleBase;

import flash.display.Sprite;

public class WindowStyle implements IStyleBase {
	
	public var backgroundBrush:Brush;
	public var scaleBrush:Brush;
	
	
	public function WindowStyle () {
		var data:Vector.<uint> = new Vector.<uint> ( 1 , true );
		data[Window.NORMAL] = 0x665511;
		backgroundBrush = new ColorBrush( data );

		var scaleBrushdata:Vector.<Function> = new Vector.<Function> ( 1 , true );
		scaleBrushdata[Window.NORMAL] = drawScaler;
		scaleBrush = new MethodBrush( scaleBrushdata );
	}

	private static function drawScaler ( scaler:* , args:Object ):void {
		var size:Number = args as Number;
		var _scaler:Sprite = scaler as Sprite;
		
		_scaler.graphics.beginFill(0xff3322);
		_scaler.graphics.moveTo(0, size);
		_scaler.graphics.lineTo(size, size);
		_scaler.graphics.lineTo(size, 0);
		_scaler.graphics.lineTo(0, size);
		_scaler.graphics.endFill();
	}
	
	
	///////////////////////////////////
	// toString
	///////////////////////////////////
	
	public function toString():String {
		return "[bloom.themes.default.WindowStyle]";
	}
	
}
}
