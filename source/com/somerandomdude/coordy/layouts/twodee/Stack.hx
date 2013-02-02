package com.somerandomdude.coordy.layouts.twodee;
import com.somerandomdude.coordy.constants.LayoutType;
import com.somerandomdude.coordy.constants.StackOrder;
import com.somerandomdude.coordy.events.CoordyNodeEvent;
import com.somerandomdude.coordy.layouts.IOrderedLayout;
import com.somerandomdude.coordy.layouts.twodee.ILayout2d;
import com.somerandomdude.coordy.nodes.INode;
import com.somerandomdude.coordy.nodes.twodee.OrderedNode;
import com.somerandomdude.coordy.utils.Utilities;

/**
 * ...
 * @author marc paraiso
 */

@:expose
class Stack extends Layout2d ,implements ILayout2d,implements IOrderedLayout
{

	public var offset(get_offset,set_offset):Float;
	private function get_offset() {	return offset;}
	private function set_offset(value:Float) { offset = value; updateFunction(); return offset; }
	
	public var angle(get_angle,set_angle):Float;
	function get_angle() { return angle; }
	function set_angle(value:Float):Float { angle = value; updateFunction(); return angle; }
	
	public var order(get_order, set_order):String;
	function get_order():String {	return order;}
	function set_order(value:String):String { order = value;  updateFunction() ; return order ; }
	
	public function new(angle:Float=45,offset:Float=5,x:Float=0,y:Float=0,order:String=StackOrder.ASCENDING,jitterX:Float=0,jitterY:Float=0){
		super();
		this.angle = angle;
		this.offset = offset;
		this.x = x;
		this.y = y;
		this.jitterX = jitterX;
		this.jitterY = jitterY;
		this.order = order;
	}
	/** Returns the type of layout in a string format **/
	override public function toString():String
	{
		return LayoutType.STACK;
	}
	
	/** Adds object to layout in next available position. **/
	override public function addNode(object:Dynamic = null, moveToCoordinates:Bool = true):INode
	{
		if (object!=null && !validateObject(object)) throw 'Object does not implement at least one of the following properties: "x", "y", "z", "rotationX", "rotationY", "rotationZ"';
		if (object != null && linkExists(object)) return null;
		var node:OrderedNode = new OrderedNode(object, this.size);
		this.storeNode(node);
		cleanOrder();
		update();
		if (object != null && moveToCoordinates) render();
		dispatchEvent(new CoordyNodeEvent(CoordyNodeEvent.ADD, node));
		return node;
	}
	
	/**  Adds object to layout in the specified order within the layout **/
	public function addToLayoutAt(object:Dynamic, index:Int, moveToCoordinates:Bool = true):INode {
		if(!validateObject(object)) throw 'Object does not implement at least one of the following properties: "x", "y", "rotation"';
		if(linkExists(object)) return null;
		if (nodes==null) nodes = [];
		var node:OrderedNode = new OrderedNode(object, index);
		
		storeNodeAt(node, index);
		this.cleanOrder();
		this.update();
		
		if(moveToCoordinates) this.render();
		
		dispatchEvent(new CoordyNodeEvent(CoordyNodeEvent.ADD, node));
		
		return node;
	}
	
	/** Clones the current object's properties (does not include links to DisplayObjects) **/
	override public function clone():ILayout2d
	{
		return new Stack(angle, offset, x, y, order, jitterX, jitterY);
	}
	
	/** Updates the nodes' virtual coordinates. <strong>Note</strong> - this method does not update the actual objects linked to the layout.**/
	override public function update():Void
	{
		if (nodes == null) return;
		this.cleanOrder();
		var rad:Float = this.angle * Math.PI / 180;
		if (order == StackOrder.ASCENDING) nodes.sort(Utilities.sortOnOrderAscending);
		var node:OrderedNode;
		for (i in 0...size) {
			node = nodes[i];
			node.x = this.x + (Math.cos(rad) * offset * i) + (node.jitterX * jitterX);
			node.y = this.y + (Math.sin(rad) * offset * i) + (node.jitterY * jitterY);
		}
	}
	
	private function cleanOrder()
	{
		nodes.sort(Utilities.sortOnOrderDescending);
		for (i in 0...size) nodes[i].order = i;
	}

	

	
}