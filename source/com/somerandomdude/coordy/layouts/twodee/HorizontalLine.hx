/**
 * @author P.J. Onori ported to Haxe by M.Paraiso mparaiso@online.fr
 * @version 0.1
 * @url http://somerandomdude.com/
 */

package com.somerandomdude.coordy.layouts.twodee;

import com.somerandomdude.coordy.constants.LayoutType;
import com.somerandomdude.coordy.events.CoordyNodeEvent;
import com.somerandomdude.coordy.layouts.IOrderedLayout;
import com.somerandomdude.coordy.layouts.twodee.ILayout2d;
import com.somerandomdude.coordy.nodes.INode;
import com.somerandomdude.coordy.nodes.twodee.INode2d;
import com.somerandomdude.coordy.nodes.twodee.OrderedNode;
#if (js && jeash)
import flash.display.DisplayObject;
#end

@:expose
class HorizontalLine extends Layout2d , implements ILayout2d,  implements IOrderedLayout
{

	public var hPadding(get_hPadding, set_hPadding):Int;
	function get_hPadding():Int { return hPadding; }
	function set_hPadding(value:Int):Int { hPadding = value; updateFunction(); return hPadding; }
	
	public var order(get_order,set_order):String;
	function get_order():String { return this.order; }
	function set_order(value:String):String { this.order = value; updateFunction(); return this.order; }
	
	/** Distributes nodes in a horizontal line **/
	public function new(hPadding:Int = 0, x:Float = 0, y:Float = 0, jitterX:Float = 0, jitterY:Float = 0) {
		super();
		this.hPadding = hPadding;
		this.x = x;
		this.y = y;
		this.jitterX = jitterX;
		this.jitterY = jitterY;
		
	}
	
	/** returns the type of layout in a string format **/
	override public function toString():String
	{
		return LayoutType.HORIZONTAL_LINE;
	}
	
	/** Adds object to layout in next available position. **/
	override public function addNode(object:Dynamic = null,moveToCoordinates:Bool = true):INode
	{
		if (object != null && !validateObject(object)) throw 'Object does not implement at least one of the following properties: "x", "y", "width", "rotation"';
		if (object != null && linkExists(object)) return null;
		var node:OrderedNode = new OrderedNode(object, size);
		this.storeNode(node);
		this.cleanOrder();
		this.update();
		if (object != null && moveToCoordinates) this.render();
		dispatchEvent(new CoordyNodeEvent(CoordyNodeEvent.ADD, node));
		return node;
	}
	
	/** Adds object to layout in next available position <strong>This method is depreceated.</strong>**/
	//override public function addToLayout(object:Dynamic, moveToCoordinates:Bool = true):INode
	//{
		//trace("This method is depreceated , use addNode ");
		//return addNode(object, moveToCoordinates);
	//}
	
	/** Adds object to layout in the specified order within the layout **/
	public function addToLayoutAt(object:Dynamic, index:Int, moveToCoordinates:Bool = true):INode2d
	{
		if (!validateObject(object)) throw 'Object does not implement at least one of the following properties: "x", "y", "width", "rotation"';
		if (linkExists(object)) return null;
		if (nodes == null) nodes = new Array<Dynamic>();
		var node:OrderedNode = new OrderedNode(object, index, 0, 0);
		this.storeNodeAt(node, index);
		this.cleanOrder();
		this.update();
		if (moveToCoordinates) this.render();
		dispatchEvent(new CoordyNodeEvent(CoordyNodeEvent.ADD, node));
		return node;
	}
	
	/** Clones the current object's properties (does not include links to DisplayObjects) **/
	override public function clone():ILayout2d
	{
		return new HorizontalLine(hPadding, x, y, jitterX, jitterY);
	}

	/**
	 * Updates the nodes' virtual coordinates. <strong>Note</strong> -
	 * this method does not update
	 * the actual objects linked to the layout.
	 *
	 */
	override public function update():Void
	{
		if (size == 0) return;
		var node:OrderedNode;
		this.nodes.sort(function(x:Dynamic, y:Dynamic):Int {
			if (x.order == y.order) return 0;
			if (x.order > y.order) return 1;
			return -1; //when  x.order<y.order
		});
		var xPos:Float = 0;
		for (i in 0...size) {
			node = nodes[i];
			node.x = xPos + x + (node.jitterX * jitterX);
			node.y = this.y;
			if (node.link == null) continue;
			#if (js && jeash)
				xPos += cast(node.link,DisplayObject).width + hPadding;
			#else
				xPos += node.link.width + hPadding;
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
			return -1; //when  x.order<y.order
	}
	
	override dynamic public function validateObject(object:Dynamic):Bool
	{
		
		#if (js && jeash)
			if (super.validateObject(object) &&  cast(object,DisplayObject).width!=null ) return true;
		#else
				if(Reflect.hasField(object,'x')&&
				Reflect.hasField(object,'y')&&
				Reflect.hasField(object, 'rotation') &&
				Reflect.hasField(object,'width')
			) return true;
		#end
		return false;
	}
	
}