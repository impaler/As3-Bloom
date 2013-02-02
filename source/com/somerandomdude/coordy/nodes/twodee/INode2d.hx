package com.somerandomdude.coordy.nodes.twodee;
import com.somerandomdude.coordy.nodes.INode;

	interface INode2d implements INode {
		
		var x(default,default):Float;
		var y(default,default):Float;
		var jitterX(default,null):Float;
		var jitterY(default,null):Float;
		var rotation(default,default):Float;
		
		function clone():INode2d;
}