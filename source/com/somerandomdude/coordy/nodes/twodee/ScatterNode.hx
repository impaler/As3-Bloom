/**
 * @author P.J. Onori
 * ported to Haxe by M.Paraiso
 * mparaiso@online.fr
 * @version 0.1
 *
 * @url http://somerandomdude.com/
 * @url https://github.com/Mparaiso/coordy.hx
 */
package com.somerandomdude.coordy.nodes.twodee;

import com.somerandomdude.coordy.nodes.INode;
import com.somerandomdude.coordy.nodes.twodee.INode2d;

class ScatterNode extends Node2d, implements INode
{
	/** node's relative x position in the scatter layout **/
	public var xRelation(get_xRelation, set_xRelation):Float;
	private function get_xRelation():Float {return xRelation;}
	private function set_xRelation(value:Float):Float { return xRelation = value; }
	
	/** node's relative y position in the scatter layout **/
	public var yRelation(get_yRelation, set_yRelation):Float;
	private function get_yRelation():Float {return yRelation;}
	private function set_yRelation(value:Float):Float { return yRelation = value; }
	
	/** Node used for Scatter layouts **/
	public function new(link:Dynamic=null,x:Float=0,y:Float=0,rotation:Float=0){
		super(link, x, y);
		this.rotation = rotation;
	}
	
	/** Creates an exact copy of node with link and position properties carried over **/
	override public function clone():INode2d
	{
		var n:ScatterNode = new ScatterNode(link, x, y, rotation);
		n.xRelation = xRelation;
		n.yRelation = yRelation;
		return n;
	}
	
}