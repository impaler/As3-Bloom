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
import com.somerandomdude.coordy.nodes.twodee.INode2d;
import com.somerandomdude.coordy.nodes.twodee.Node2d;

class FlowNode extends Node2d ,implements INode2d
{
	/** Property as to whether node's position exists outside of the layouts current bounds **/
	public var outsideBounds(get_outsideBounds, set_outsideBounds):Bool;
	function get_outsideBounds():Bool { return outsideBounds; }
	function set_outsideBounds(value:Bool) { return (outsideBounds = value);}

	/** Node used for Flow layout **/
	public function new(link:Dynamic=null,x:Float=0,y:Float=0)
	{
		super(link, x, y);
	}
	
	override public function clone():INode2d {
		var n:FlowNode = new FlowNode(link, x, y);
		n.outsideBounds = outsideBounds;
		return n;
	}
	
}