package com.somerandomdude.coordy.layouts.twodee;

import com.somerandomdude.coordy.layouts.ILayout;
import com.somerandomdude.coordy.nodes.twodee.INode2d;
import com.somerandomdude.coordy.nodes.twodee.INode2d;

interface ILayout2d implements ILayout {
	
	public var x(default,set_x):Float;
	public var y(default,set_y):Float;
	public var width(get_width,set_width):Float;
	public var height(get_height,set_height):Float;
	public var rotation(default,set_rotation):Float;
	public var jitterX(default,set_jitterX):Float;
	public var jitterY(default,set_jitterY):Float;
		
	public	function renderNode(cell:INode2d):Void;
	public	function clone():ILayout2d;
}