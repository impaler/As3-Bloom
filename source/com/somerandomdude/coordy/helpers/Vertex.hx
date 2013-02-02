package com.somerandomdude.coordy.helpers;

@:expose("Coordinates.helpers.Vertex")
class Vertex
{
	
	public var x(get_x,set_x):Float;//position
	function get_x():Float return x
	function set_x(value:Float):Float {
		if (Math.isNaN(value)) {
			throw "x value is NaN";
		}
		return x = value ;
	}
	
	public var y:Float;
	
	public var z:Float;
	
	public var screenX:Float;//toScreen position
	public var screenY:Float;
	
	public var depth:Float;
	public var ratio:Float;
	public var color:Int;
	
	public function new( ?X:Float, ?Y:Float, ?Z:Float, C:Int = 0xFF000000 )
	{
		
		this.x = X == null?Math.random() - 0.5:X;
		this.y = Y == null?Math.random() - 0.5:Y;
		this.z = Z == null?Math.random() - 0.5:Z;
		color = C;
		
		screenX = screenY = ratio = depth = 0;
		
	}
	
	public function clone():Vertex
	{
		return new Vertex( x, y, z, color );
	}
	
}


