package com.somerandomdude.coordy.nodes.threedee;

class ScatterNode3d extends Node3d ,implements INode3d
{
	
	public var xRelation(get_xRelation,set_xRelation):Float;
	public var yRelation(get_yRelation,set_yRelation):Float;
	public var zRelation(get_zRelation,set_zRelation):Float;
	
	/**
	 * Mutator/accessor for node's relative x position in the scatter layout
	 *
	 * @return value Relative x position
	 *
	 */
	 function get_xRelation():Float { return xRelation; }
	 function set_xRelation(value:Float):Float { this.xRelation = value; return xRelation; }
	
	/**
	 * Mutator/accessor for node's relative y position in the scatter layout
	 *
	 * @return value Relative y position
	 *
	 */
	 function get_yRelation():Float { return yRelation; }
	 function set_yRelation(value:Float):Float { this.yRelation = value; return yRelation; }
	
	/**
	 * Mutator/accessor for node's relative z position in the scatter layout
	 *
	 * @return value Relative z position
	 *
	 */
	 function get_zRelation():Float { return zRelation; }
	 function set_zRelation(value:Float):Float { this.zRelation = value; return zRelation; }
	
	/**
	 * Node used for Scatter3d layouts
	 *
	 * @see com.somerandomdude.coordy.layouts.threedee.Scatter3d
	 *
	 * @param link The node's target DisplayObject
	 * @param x Node's x position within the scatter layout
	 * @param y Node's y position within the scatter layout
	 * @param z Node's z position within the scatter layout
	 * @param rotation Node's rotational value
	 *
	 */
	public function new(link:Dynamic=null, x:Float=0, y:Float=0, z:Float=0, rotationX:Float=0, rotationY:Float=0, rotationZ:Float=0)
	{
		super(link, x, y, z);
		this.rotationX=rotationX;
		this.rotationY=rotationY;
		this.rotationZ=rotationZ;
	}

	/**
	 * Creates an exact copy of node with link and position properties carried over
	 *
	 * @return Cloned node
	 *
	 */
	override public function clone():INode3d
	{
		var n:ScatterNode3d = new ScatterNode3d(link, x, y, z, rotationX, rotationY, rotationZ);
		n.xRelation=xRelation;
		n.yRelation=yRelation;
		n.zRelation=zRelation;
		return n;
	}
	
}
