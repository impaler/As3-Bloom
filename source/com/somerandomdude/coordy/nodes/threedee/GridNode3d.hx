package com.somerandomdude.coordy.nodes.threedee;
import com.somerandomdude.coordy.nodes.threedee.INode3d;

class GridNode3d extends Node3d, implements INode3d {
	public var row(get_row, set_row):Int;
	function get_row():Int
	{return row;}
	function set_row(value:Int):Int { return row = value; }
	public var column(get_column, set_column):Int;
	function get_column():Int{	return column;	}
	function set_column(value:Int):Int {return column = value;}
	public var layer(get_layer,set_layer):Int;
	function get_layer():Int {return layer;}
	function set_layer(value:Int):Int {	return layer = value;	}
	
	public function new(link:Dynamic=null,column:Int=1,row:Int=1,layer:Int=1,x:Float=0,y:Float=0,z:Float=0,jitterX:Float=0,jitterY:Float=0,jitterZ:Float=0){
		super(link, x, y, z, jitterX, jitterY, jitterZ);
		this.row = row;
		this.column = column;
		this.layer = layer;
	}
	
	override public function clone():INode3d
	{
		return new GridNode3d(link, column, row, layer, x, y, z, jitterX, jitterY, jitterZ);
	}
	
	override public function toObject():Dynamic
	{
		return { row:row, column:column, layer:layer, x:x, y:y, z:z, jitterX:jitterX, jitterY:jitterY, jitterZ:jitterZ };
	}
}