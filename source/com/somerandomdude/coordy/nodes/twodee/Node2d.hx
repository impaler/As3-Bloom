package com.somerandomdude.coordy.nodes.twodee;

import com.somerandomdude.coordy.nodes.twodee.INode2d;
import com.somerandomdude.coordy.nodes.Node;

class Node2d extends Node , implements INode2d
{
	
	public var x(default,default):Float;
	public var y(default, default):Float;
	public var jitterX(default, setJitterX):Float;
	public var jitterY(default, setJitterY):Float;
	public var rotation(default, default):Float;

	private function setJitterX(value:Float):Float
	{
		return jitterX = Math.random()*value*((Math.random()>.5)?-1:1);
	}
	
	private function setJitterY(value:Float):Float
	{
		return jitterY = Math.random()*value*((Math.random()>.5)?-1:1);
	}
	
	
	/**
	 * Constructor
	 * @param	link
	 * @param	x
	 * @param	y
	 * @param	jitterX
	 * @param	jitterY
	 */
	public function new(link:Dynamic = null, x:Float = 0, y:Float=0, jitterX:Float=0, jitterY:Float = 0 )
	{
		this.x = x;
		this.y = y;
		this.jitterX = jitterX;
		this.jitterY = jitterY;
		rotation = 0;
		super(link);
	}
	

	public function clone():INode2d
	{
		var n:Node2d = new Node2d(link, x, y, jitterX, jitterY);
		n.rotation = rotation ;
		return n;
	}
	
	public override function toObject():Dynamic
	{
		return { x:x, y:y, rotation:rotation };
	}
	
}