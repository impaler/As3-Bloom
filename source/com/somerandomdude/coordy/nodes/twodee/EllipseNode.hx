package com.somerandomdude.coordy.nodes.twodee;

class EllipseNode extends Node2d,implements INode2d
{
	
	/**
	 * Node used for Ellipse layout
	 *
	 * @see com.somerandomdude.coordy.layouts.twodee.Ellipse
	 *
	 * @param link The node's target DisplayObject
	 * @param x Node's x position
	 * @param y Node's y position
	 * @param rotation Node's rotational value
	 * @param jitterX Node's x-jitter value
	 * @param jitterY Node's y-jitter value
	 *
	 */
	public function new(link:Dynamic=null, x:Float=0, y:Float=0, rotation:Float=0, jitterX:Float=0, jitterY:Float=0)
	{
		super(link, x, y, jitterX, jitterY);
		this.rotation=rotation;
	}
	
	/**
	 * Creates an exact copy of node with link and position properties carried over
	 *
	 * @return Cloned node
	 *
	 */
	override public function clone():INode2d { return new EllipseNode(link, x, y, rotation, jitterX, jitterY); }
	
}