package com.somerandomdude.coordy.nodes.twodee;

import com.somerandomdude.coordy.nodes.twodee.INode2d;
import com.somerandomdude.coordy.nodes.twodee.Node2d;
/**
 * ...
 * @author marc paraiso
 */

class OrderedNode extends Node2d
{

	private var _order:Int;
	public var order(get_order, set_order):Int;
	
	/**
	* Mutator/accessor for the node's order in the layout. Works in ascending order
	* @return Integer for node's order in layout
	*
	*/
	function get_order():Int { return this._order; }
	function set_order(value:Int):Int { return this._order = value; }
	
	/**
	 * Node used for HorizontalLine, VerticalLine and Stack layouts
	 * @param	link The node's target DisplayObject
	 * @param	order Node's order in the layout
	 * @param	x Node's x position
	 * @param	y Node's y position
	 * @param	jitterX Node's x-jitter value
	 * @param	jitterY Node's y-jitter value
	 */
	public function new(link:Dynamic = null, order:Int = 0, x:Float = 0, y:Float = 0,jitterX:Float=0,jitterY:Float=0 )
	{
		super(link, x, y, jitterX, jitterY);
		this._order = order;
	}
	
	/**
	 * Creates an exact copy of node with link and position properties carried over
	 *
	 * @return Cloned node
	 *
	 */
	override public function clone():INode2d
	{
		return new OrderedNode(link, order, x, y, jitterX, jitterY);
	}
	
	/**
	 * Packages the node as a generic object - mainly used for exporting layout data.
	 *
	 * @return Generic object containing all the node's layout properties
	*/
	override public function toObject():Dynamic
	{
		return { order:_order, x:x, y:y, rotation:rotation };
	}
	
}