package com.somerandomdude.coordy.nodes.threedee;
import com.somerandomdude.coordy.nodes.INode;

interface INode3d implements INode {
	public var x(get_x, set_x):Float;
	public var y(get_y, set_y):Float;
	public var z(get_z, set_z):Float;
	
	public var jitterX(get_jitterX, set_jitterX):Float;
	public var jitterY(get_jitterY, set_jitterY):Float;
	
	public var rotationX(get_rotationX, set_rotationX):Float;
	public var rotationY(get_rotationY, set_rotationY):Float;
	public var rotationZ(get_rotationZ, set_rotationZ):Float;

	function clone():INode3d;
}