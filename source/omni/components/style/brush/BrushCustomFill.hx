package omni.components.style.brush;

import omni.components.core.interfaces.IOComponent;
import omni.components.core.interfaces.IBrush;

import nme.display.Sprite;
import nme.display.Graphics;

class BrushCustomFill implements IBrush {


	public var drawFunctions:Hash<Dynamic>;

	public function new( )
	{
		drawFunctions = new Hash();
	}

	public function setDrawFunctionState( state:String, drawFunction:Dynamic ):Void
	{
		drawFunctions.set(state, drawFunction);
	}
	
	public function update( drawTarget:IOComponent )
	{
		var drawFunction = drawFunctions.get(drawTarget.state);
		
		Reflect.callMethod( this, drawFunction, [drawTarget] );
	}

	public function destroy( ):Void
	{
		drawFunctions = null;
	}


}
