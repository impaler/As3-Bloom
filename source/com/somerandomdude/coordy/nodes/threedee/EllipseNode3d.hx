package com.somerandomdude.coordy.nodes.threedee;


@:expose("Coordinates.node.threedee.EllipseNode3d")
class EllipseNode3d extends Node3d ,implements INode3d
{
	/**
	 * Node used for Ellipse3d and WaveEllipse3d layouts
	 *
	 * @see com.somerandomdude.coordy.layouts.threedee.Ellipse3d
	 * @see com.somerandomdude.coordy.layouts.threedee.WaveEllipse3d
	 *
	 * @param link The node's target DisplayObject
	 * @param x Node's x position
	 * @param y Node's y position
	 * @param z Node's z position
	 * @param rotation Node's rotational value
	 * @param jitterX Node's x-jitter value
	 * @param jitterY Node's y-jitter value
	 * @param jitterZ Node's z-jitter value
	 *
	 */
	public function new(link:Dynamic=null, x:Float=0, y:Float=0, z:Float=0, rotationX:Float=0, rotationY:Float=0, rotationZ:Float=0, jitterX:Float=0, jitterY:Float=0, jitterZ:Float=0)
	{
		super(link, x, y, z, jitterX, jitterY, jitterZ);
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
	override public function clone():INode3d {
		return new EllipseNode3d(link, x, y, z, rotationX, rotationY, rotationZ, jitterX, jitterY, jitterZ);
	}
	
}

