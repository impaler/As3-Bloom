package bloom.themes.defaultTheme {

import bloom.brush.ColorBrush;
import bloom.brush.MethodBrush;
import bloom.components.Window;
import bloom.style.*;

import flash.display.Sprite;

public class DefaultWindowStyle extends WindowStyle {
	
	public function DefaultWindowStyle () {
		var data:Vector.<uint> = new Vector.<uint> ( 1 , true );
		data[Window.NORMAL] = 0x665511;
		backgroundBrush = new ColorBrush( data );

		var scalerBrushData:Vector.<Function> = new Vector.<Function> ( 1 , true );
		scalerBrushData[Window.NORMAL] = drawScaler;
		scalerBrush = new MethodBrush( scalerBrushData );
		
		header = new DefaultWindowHeaderContainerStyle();
		footer = new DefaultWindowFooterContainerStyle();
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
	
	override public function toString():String {
		return "[bloom.style.default.DefaultWindowStyle]";
	}
	
}
}
