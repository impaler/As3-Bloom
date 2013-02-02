package com.somerandomdude.coordy.layouts.threedee ;
import com.somerandomdude.coordy.layouts.ILayout;
import com.somerandomdude.coordy.nodes.threedee.INode3d;

interface ILayout3d implements ILayout {
	
	public var x(get_x,set_x):Float;
	public var y(get_y,set_y):Float;
	public var z(get_z,set_z):Float;
	public var width(get_width,set_width):Float;
	public var height(get_height,set_height):Float;
	public var depth(get_depth,set_depth):Float;
	public var rotation(get_rotation, set_rotation):Float;
	public var jitterX(get_jitterX,set_jitterX):Float;
	public var jitterY(get_jitterY,set_jitterY):Float;
	public var jitterZ(get_jitterZ,set_jitterZ):Float;
	
	function renderNode(node:INode3d):Void;
	function clone():ILayout3d;
}