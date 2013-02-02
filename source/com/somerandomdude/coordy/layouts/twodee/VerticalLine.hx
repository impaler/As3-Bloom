package com.somerandomdude.coordy.layouts.twodee;

import com.somerandomdude.coordy.constants.LayoutType;
import com.somerandomdude.coordy.events.CoordyNodeEvent;
import com.somerandomdude.coordy.layouts.IOrderedLayout;
import com.somerandomdude.coordy.layouts.twodee.ILayout2d;
import com.somerandomdude.coordy.nodes.INode;
import com.somerandomdude.coordy.nodes.twodee.OrderedNode;
#if (js && jeash)
import flash.display.DisplayObject;
#end

@:expose("Coordinates.layouts.twodee.VerticalLine")
class VerticalLine extends Layout2d ,implements ILayout2d,implements IOrderedLayout
{

	var vPadding(get_vPadding,set_vPadding):Int;
	function get_vPadding():Int { return vPadding; }
	function set_vPadding(value:Int):Int { vPadding = value; updateFunction(); return vPadding; }
	
	public var order(get_order, set_order):String;
	function get_order():String { return order; }
	function set_order(value:String):String { order = value; updateFunction(); return order;}
	
	/** Distributes nodes in a vertical line **/
	public function new(vPadding:Int = 0,x:Float=0,y:Float=0,jitterX:Float=0,jitterY:Float=0)
	{
		super();
		this.vPadding = vPadding;
		this.x = x;
		this.y = y;
		this.jitterX = jitterX;
		this.jitterY = jitterY;
		
	}
	
	/**  Returns the type of layout in a string format **/
	override public function toString():String {
		return LayoutType.VERTICAL_LINE;
	}
	
	/** Adds object to layout in next available position. **/
	override public function addNode(object:Dynamic = null, moveToCoordinates:Bool = true):INode
	{
		if (object != null && !validateObject(object)) throw 'Object does not implement at least one of the following properties: "x", "y", "height", "rotation"';
		if (object != null && linkExists(object)) return null;
		var node:OrderedNode = new OrderedNode(object, size);
		this.storeNode(node);
	  this.cleanOrder();
		this.update();
		if (object != null && moveToCoordinates) this.render();
		dispatchEvent(new CoordyNodeEvent(CoordyNodeEvent.ADD, node));
		return node;
	}
	
	/** Clones the current object's properties (does not include links to DisplayObjects) **/
	override public function clone():ILayout2d
	{
		return new VerticalLine(vPadding, x, y, jitterX, jitterY);
	}

	/** Updates the nodes' virtual coordinates. <strong>Note</strong> - this method does not update the actual objects linked to the layout.*/
	override public function update():Void
	{
		if (size == 0) return;
		var node:OrderedNode;
		this.nodes.sort(sortOnOrder);
		var yPos:Float = 0;
		for (i in 0...size) {
			node = this.nodes[i];
			node.y = yPos + y + (node.jitterY * this.jitterY);
			node.x = this.x + (node.jitterX * this.jitterX);
			if (node.link == null) continue;
			#if (js && jeash)
				yPos += cast(node.link, DisplayObject).height + vPadding;
			#else
				yPos += node.link.height + vPadding;
			#end
		}
	}
	
	/** Cleans out duplicates and gaps **/
	private function cleanOrder()
	{
		this.nodes.sort(sortOnOrder);
		for (i in 0...size) {
			this.nodes[i].order = i;
		}
	}
	
	/** fonction d'aide pour le trie des noeux **/
	function sortOnOrder(x:OrderedNode, y:OrderedNode):Int {
			if (x.order == y.order) return 0;
			if (x.order > y.order) return 1;
			return -1;
	}
	
	
	
	override  public  function validateObject(object:Dynamic):Bool
	{
		#if (js && jeash)
			if (Std.is(object, DisplayObject)) {
				var link:DisplayObject = cast(object, DisplayObject);
				return (super.validateObject(link) && link.height !=null);
			}else {
				return (super.validateObject(object) && Reflect.hasField(object, "height"));
			}
		#end
			if(Reflect.hasField(object,'x')&&
				Reflect.hasField(object,'y')&&
				Reflect.hasField(object, 'rotation') &&
				Reflect.hasField(object, "height")
			) return true;
			return false;
	}
	
}