package com.somerandomdude.coordy.nodes.threedee;

import com.somerandomdude.coordy.nodes.Node;

class Node3d extends Node, implements INode3d
{
	public var x(get_x,set_x):Float;
	public var y(get_y,set_y):Float;
	public var z(get_z,set_z):Float;
	public var jitterX(get_jitterX,set_jitterX):Float;
	public var jitterY(get_jitterY,set_jitterY) :Float;
	public var jitterZ(get_jitterZ,set_jitterZ):Float;
	public var rotationX(get_rotationX,set_rotationX):Float;
	public var rotationY(get_rotationY,set_rotationY):Float;
	public var rotationZ(get_rotationZ,set_rotationZ):Float;
	
	/**
	 * Mutator/accessor for node's x position
	 *
	 * @return value Virtual x position for node
	 *
	 */
	public function get_x():Float { return x; }
	public function set_x(value:Float):Float { return this.x=value; }
	
	/**
	 * Mutator/accessor for node's y position
	 *
	 * @return value Virtual y position for node
	 *
	 */
	public function get_y():Float { return y; }
	public function set_y(value:Float):Float { return this.y=value; }
	
	/**
	 * Mutator/accessor for node's z position
	 *
	 * @return value Virtual z position for node
	 *
	 */
	public function get_z():Float { return z; }
	public function set_z(value:Float):Float { return this.z=value; }
	
	/**
	 * Mutator/accessor for node's x jitter value
	 *
	 * @return value Jitter multiplier for the x position of the node
	 *
	 */
	public function get_jitterX():Float { return jitterX; }
	public function set_jitterX(value:Float):Float { return this.jitterX=Math.random()*value*((Math.random()>.5)?-1:1); }
	
	/**
	 * Mutator/accessor for node's y jitter value
	 *
	 * @return value Jitter multiplier for the y position of the node
	 *
	 */
	public function get_jitterY():Float { return jitterY; }
	public function set_jitterY(value:Float):Float { return jitterY=Math.random()*value*((Math.random()>.5)?-1:1); }
	
	/**
	 * Mutator/accessor for node's z jitter value
	 *
	 * @return value Jitter multiplier for the z position of the node
	 *
	 */
	public function get_jitterZ():Float { return jitterZ; }
	public function set_jitterZ(value:Float):Float { return this.jitterZ=value; }
	
	/**
	 * Mutator/accessor for node's rotational value on the x-axis axis
	 * @return Node's x-axis rotation
	 *
	 */
	public function get_rotationX():Float { return this.rotationX; }
	public function set_rotationX(value:Float):Float { return  this.rotationX=value; }
	
	/**
	 * Mutator/accessor for node's rotational value on the y-axis axis
	 * @return Node's y-axis rotation
	 *
	 */
	public function get_rotationY():Float { return this.rotationY; }
	public function set_rotationY(value:Float):Float { return  this.rotationY=value; }
	
	/**
	 * Mutator/accessor for node's rotational value on the z-axis axis
	 * @return Node's z-axis rotation
	 *
	 */
	public function get_rotationZ():Float { return this.rotationZ; }
	public function set_rotationZ(value:Float):Float { return  this.rotationZ=value; }
	
	/**
	 * Base node for all 3D layouts. Contains basic information for recording and projecting 3D positioning. Used in Sphere3d and Snapshot3d layouts.
	 *
	 * @see com.somerandomdude.coordy.layouts.threedee.Sphere3d
	 * @see com.somerandomdude.coordy.layouts.threedee.Snapshot3d
	 *
	 * @param link The node's target object
	 * @param x Node's x position
	 * @param y Node's y position
	 * @param z Node's z position
	 * @param jitterX Node's x-jitter value
	 * @param jitterY Node's y-jitter value
	 * @param jitterZ Node's z-jitter value
	 *
	 */
	public function new(link:Dynamic=null, x:Float=0, y:Float=0, z:Float=0, jitterX:Float=0, jitterY:Float=0, jitterZ:Float=0)
	{
		super(link);
		this.x=x;
		this.y=y;
		this.z=z;
		this.jitterX=jitterX;
		this.jitterY=jitterY;
		this.jitterZ=jitterZ;
	}
	
	/**
	 * Creates an exact copy of node with link and position properties carried over
	 *
	 * @return Cloned node
	 *
	 */
	public function clone():INode3d
	{
		var n:Node3d = new Node3d(link, x, y, z, jitterX, jitterY, jitterZ);
		n.rotationX=rotationX;
		n.rotationY=rotationY;
		n.rotationZ=rotationZ;
		return n;
	}
	
	/**
	 * Packages the node as a generic object - mainly used for exporting layout data.
	 *
	 * @return Generic object containing all the node's layout properties
	*/
	override public function toObject():Dynamic
	{
		return {x:x, y:y, z:z, rotationX:rotationX, rotationY:rotationY, rotationZ:rotationZ};
	}

}
