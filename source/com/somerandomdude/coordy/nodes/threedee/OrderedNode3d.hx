package com.somerandomdude.coordy.nodes.threedee;

import com.somerandomdude.coordy.nodes.threedee.Node3d;


class OrderedNode3d extends Node3d
{
	
	public var order(get_order,set_order):Int;
	function get_order():Int { return this.order; }
	function set_order(value:Int):Int { return this.order=value; }
	
	/**
	 * Node used for Stack3d layouts
	 *
	 * @see com.somerandomdude.coordy.layouts.threedee.Stack3d
	 *
	 * @param link
	 * @param order
	 * @param x
	 * @param y
	 * @param z
	 * @param jitterX
	 * @param jitterY
	 * @param jitterZ
	 *
	 */
	public function new(link:Dynamic=null, order:Int=0, x:Float=0, y:Float=0, z:Float=0, jitterX:Float=0, jitterY:Float=0, jitterZ:Float=0)
	{
		super(link, x, y, z, jitterX, jitterY, jitterZ);
		this.order=order;
	}
	
	/**
	 * Creates an exact copy of node with link and position properties carried over
	 *
	 * @return Cloned node
	 *
	 */
	override public function clone():INode3d
	{
		var n:OrderedNode3d = new OrderedNode3d(link, order, x, y, z, jitterX, jitterY, jitterZ);
		return n;
	}
	
	/**
	 * Packages the node as a generic object - mainly used for exporting layout data.
	 *
	 * @return Generic object containing all the node's layout properties
	*/
	override public function toObject():Dynamic
	{
		return {order:order, x:x, y:y, z:z};
	}
	
}
