/**
 * @author P.J. Onori
 * ported to Haxe by M.Paraiso
 * mparaiso@online.fr
 * @version 0.1
 *
 * @url http://somerandomdude.com/
 * @url https://github.com/Mparaiso/coordy.hx
 */


package com.somerandomdude.coordy.layouts.twodee;
import com.somerandomdude.coordy.constants.LayoutType;
import com.somerandomdude.coordy.events.CoordyNodeEvent;
import com.somerandomdude.coordy.layouts.twodee.ILayout2d;
import com.somerandomdude.coordy.nodes.INode;
import com.somerandomdude.coordy.nodes.twodee.ScatterNode;
#if (js && jeash)
import flash.display.DisplayObject;
#end


@:expose
class Scatter extends Layout2d
{
	/** Global jitter value of scatter layout    **/
	public var jitter(get_jitter, set_jitter):Float;
	function get_jitter():Float { return jitter; }
	function set_jitter(value:Float):Float { jitter = value; updateFunction(); return jitter;}
	
	/** Boolean value of jitter rotation state 	 **/
	public var jitterRotation(get_jitterRotation, set_jitterRotation):Bool;
	function get_jitterRotation():Bool { return jitterRotation; }
	function set_jitterRotation(value:Bool):Bool { jitterRotation = value; updateFunction(); return jitterRotation;}
	
	/** Distributes nodes in a scattered fashion. **/
	public function new(width:Float, height:Float, x:Float=0, y:Float=0, jitter:Float = 1, jitterRotation:Bool = false) {
		super();
		this.width = width;
		this.height = height;
		this.x = x;
		this.y = y;
		this.jitter = jitter;
		this.jitterRotation = jitterRotation;
		
	}
	
	/** Returns the type of layout in a string format **/
	override public function toString():String
	{
		return LayoutType.SCATTER;
	}
	
	/** Adds object to layout in next available position. **/
	override public function addNode(object:Dynamic = null, moveToCoordinates:Bool = true):INode
	{
		if (object != null && !validateObject(object)) throw 'Object does not implement at least one of the following properties: "x", "y", "z", "rotationX", "rotationY", "rotationZ"';
		if (object != null && linkExists(object)) return null;
		var p:Int = getP();
		var xPos:Float = getXPos(p);
		p = getP();
		var yPos:Float = getYPos(p);
		p = getP();
		var node:ScatterNode = new ScatterNode(object, xPos, yPos, jitterRotation  ?Math.random() * p * 360:0);
		node.xRelation = node.x / width;
		node.yRelation = node.y / height;
		this.storeNode(node);
		if (object != null && moveToCoordinates) {
			object.x = node.x;
			object.y = node.y ;
			object.rotation = node.rotation;
		}
		dispatchEvent(new CoordyNodeEvent(CoordyNodeEvent.ADD, node));
		return node;
		
	}
	
	/** Adds object to layout in next available position <strong>This method is depreceated.</strong> **/
	override public function addToLayout(object:Dynamic, moveToCoordinates:Bool = true):INode
	{
		return addNode(object, moveToCoordinates);
	}
	
	/**  Applies all layout property values to all cells/display objects in the collection **/
	override dynamic public function render():Void
	{
		for (i in 0...size) {
				//prevent js/jeash bug
			#if (js && jeash)
			if (Std.is(this.nodes[i].link, DisplayObject)) {
					var localNode:DisplayObject = cast(this.nodes[i].link, DisplayObject);
					localNode.x = this.nodes[i].x;
					localNode.y = this.nodes[i].y;
					localNode.rotation = this.nodes[i].rotation;
			}else
			#end
			{
					var localNode = this.nodes[i].link;
					localNode.x = this.nodes[i].x;
					localNode.y = this.nodes[i].y;
					localNode.rotation = this.nodes[i].rotation;
			}

		}
	}
	
	/**  Updates the nodes' virtual coordinates. <strong>Note</strong> - this method does not update the actual objects linked to the layout. **/
	override public function update():Void
	{
		for (i in 0...size) {
			nodes[i].x = (nodes[i].xRelation * width) + x;
			nodes[i].y = (nodes[i].yRelation * height) + y;
		}
	}
	
	/** Re-scatters layout and adjusts cell links appropriately **/
	public function scatter()
	{
		var p:Int;
		var node:ScatterNode;
		var xPos:Float;
		var yPos:Float;
		for (i in 0...size) {
			node = nodes[i];
			p = Math.round(Math.random()) != 0 ? -1:1;
			xPos = getXPos(p);
			p = Math.round(Math.random()) != 0? -1:1;
			yPos = getYPos(p);
			node.x = xPos;
			node.y = yPos;
			node.xRelation = (node.x) / width;
			node.yRelation = (node.y) / height;
			node.rotation  =  jitterRotation?Math.random() * p * 360:0;
		}
		updateFunction();
		
	}

	/** helper function **/
	inline function getP():Int {
		return  (Math.round(Math.random()))!=0 ? -1:1;
	}
	/** helper function **/
	function getXPos(p:Int):Float {
		return (width / 2 + ((Math.random() * width * jitter) / 2) * p) + x;
	}
	/** helper function **/
	function getYPos(p:Int):Float {
		return (height / 2 + ((Math.random() * height * jitter) / 2) * p) + y;
	}
	
	/**  Clones the current object's properties (does not include links to DisplayObjects) **/
	override public function clone():ILayout2d
	{
		return new Scatter(width, height, jitter, x, y, jitterRotation);
	}
}