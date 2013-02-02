package com.somerandomdude.coordy.layouts.threedee;


import com.somerandomdude.coordy.constants.LayoutUpdateMethod;
import com.somerandomdude.coordy.events.CoordyNodeEvent;
import com.somerandomdude.coordy.layouts.Layout;
import com.somerandomdude.coordy.nodes.INode;
import com.somerandomdude.coordy.nodes.threedee.INode3d;
import com.somerandomdude.coordy.proxyupdaters.IProxyUpdater;

class Layout3d extends Layout , implements ILayout3d
{
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
	
	public var updateMethod(default,set_updateMethod):String;
	public var updateFunction:Dynamic;
	public var proxyUpdater(default,set_proxyUpdater):IProxyUpdater;
	
	/**
	 * Sets a proxy update method for altering layouts as opposed to internal update methods
	 * such as update(), render() or updateAndRender()
	 *
	 * This allows more customization for the updating sequence.
	 *
	 * @see com.somerandomdude.coordy.proxyupdaters.IProxyUpdater
	 * @see #updateMethod
	 *
	 */
	@:getter function get_proxyUpdater():IProxyUpdater { return proxyUpdater; }
	@:setter function set_proxyUpdater(value:IProxyUpdater):IProxyUpdater
	{
		this.updateMethod=value.name;
		this.updateFunction = value.update;
		return proxyUpdater;
	}
	
	/**
	 * Specifies whether layout properties (x, y, width, height, etc.) adjust the layout
	 * automatically without calling apply() method.
	 *
	 * An alternative method for updating layouts is to define a proxy updater using
	 * the proxyUpdater property
	 *
	 * @see com.somerandomdude.coordy.layouts.LayoutUpdateMethod
	 * @see #proxyUpdater
	 *
	 * @return  Current setting of auto-adjust (defaults to false)
	 */
	function get_updateMethod():String { return this.updateMethod; }
	function set_updateMethod(value:String):String
	{
		this.updateMethod = value;
		switch(value)
		{
			case LayoutUpdateMethod.NONE:
				this.updateFunction=function():Void {};
			case LayoutUpdateMethod.UPDATE_ONLY:
				this.updateFunction=update;
			default :
				this.updateFunction = updateAndRender;
		}
		return updateMethod;
	}
	
	/**
	 * Accessor for rotation property
	 *
	 * @return Global rotation position of layout
	 *
	 */
	function get_rotation():Float { return this.rotation; }
	function set_rotation(value:Float):Float
	{
		this.rotation=value;
		this.updateFunction();
		return rotation;
	}
	
	/**
	 * Mutator/accessor for layout x property
	 *
	 * @return	X position of layout organizer
	 */
	function get_x():Float { return this.x; }
	function set_x(value:Float):Float
	{
		this.x=value;
		this.updateFunction();
		return x;
	}
	
	/**
	 * Mutator/accessor for layout y property
	 *
	 * @return	Y position of layout organizer
	 */
	function get_y():Float { return this.y; }
	function set_y(value:Float):Float
	{
		this.y=value;
		this.updateFunction();
		return y;
	}
	
	/**
	 * Mutator/accessor for layout z property
	 *
	 * @return	Z position of layout organizer
	 */
	function get_z():Float { return this.z; }
	function set_z(value:Float):Float
	{
		this.z=value;
		this.updateFunction();
		return z;
	}
	
	/**
	 * Mutator/accessor for layout width property
	 *
	 * @return	Width of layout organizer
	 */
	function get_width():Float { return this.width; }
	function set_width(value:Float):Float
	{
		this.width=value;
		this.updateFunction();
		return width;
	}
	
	/**
	 * Mutator/accessor for layout height property
	 *
	 * @return	Height of layout organizer
	 */
	function get_height():Float { return this.height; }
	function set_height(value:Float):Float
	{
		this.height=value;
		this.updateFunction();
		return height;
	}
	
	/**
	 * Mutator/accessor for layout depth property
	 *
	 * @return	Depth of layout organizer
	 */
	function get_depth():Float { return this.depth; }
	function set_depth(value:Float):Float
	{
		this.depth=value;
		this.updateFunction();
		return depth;
	}
	
	/**
	 * Mutator/accessor for the jitterX property. This value then mulitplied by each node's
	 * corresponding jitterX multiplier value to get_its jitter offset.
	 *
	 * @return Global x-axis jitter base value
	 *
	 */
	function get_jitterX():Float { return this.jitterX; }
	function set_jitterX(value:Float):Float
	{
		this.jitterX=value;
		this.updateFunction();
		return jitterX;
	}
	
	/**
	 * Mutator/accessor for the jitterY property. This value then mulitplied by each node's
	 * corresponding jitterY multiplier value to get_its jitter offset.
	 *
	 * @return Global y-axis jitter base value
	 *
	 */
	function get_jitterY():Float { return this.jitterY; }
	function set_jitterY(value:Float):Float
	{
		this.jitterY=value;
		this.updateFunction();
		return jitterY;
	}
	
	/**
	 * Mutator/accessor for the jitterZ property. This value then mulitplied by each node's
	 * corresponding jitterZ multiplier value to get_its jitter offset.
	 *
	 * @return Global z-axis jitter base value
	 *
	 */
	function get_jitterZ():Float { return this.jitterZ; }
	function set_jitterZ(value:Float):Float
	{
		this.jitterZ=value;
		this.updateFunction();
		return jitterZ;
	}
	
	/**
	 * Core class for all 3D layouts. Cannot be instantiated as is - use child classes.
	 *
	 */
	public function new() {
		super();
		updateMethod=LayoutUpdateMethod.UPDATE_AND_RENDER;
		updateFunction = updateAndRender;
		x = 0;
		y = 0;
		z = 0;
		width = 0;
		height = 0;
		depth = 0;
		rotation = 0;
	}
	
	/**
	 * Adds object to layout in next available position. <strong>Note</strong> - This method is to be
	 * overridden by child classes for implmentation.
	 *
	 * @param  object  Dynamic to add to layout
	 * @param  moveToCoordinates  automatically move DisplayObject to corresponding node's coordinates
	 *
	 * @return newly created node object containing a link to the object
	 */
	override public function addToLayout(object:Dynamic,  moveToCoordinates:Bool=true):INode
	{
		throw 'Method must be overriden by child class';
		return null;
	}
	
	/**
	 * Removes specified cell and its link from layout organizer and adjusts layout appropriately
	 *
	 * @param  cell  cell object to remove
	 */
	override public function removeNode(node:INode):Void
	{
		super.removeNode(node);
		this.updateFunction();
		dispatchEvent(new CoordyNodeEvent(CoordyNodeEvent.REMOVE, node));
	}
	
	/**
	* Clones the current object's properties (does not include links to DisplayObjects)
	*
	* @return Wave3d clone of object
	*/
	public function clone():ILayout3d
	{
		throw 'Method must be overriden by child class';
		return null;
	}
	
	/**
	 * Performs the update method defined by the <em>updateMethod</em> property. Is helpful for
	 * for behaviors and proxy updaters to work within the defined functiality set_at runtime.
	 *
	 * @see com.somerandomdude.coordy.layouts.LayoutUpdateMethod
	 * @see #updateMethod
	 *
	 */
	public function executeUpdateMethod():Void
	{
		updateFunction();
	}
	
	/**
	 * Performs an update on all the nodes' positions and renders each node's corresponding link
	 *
	 */
	public function updateAndRender():Void
	{
		this.update();
		this.render();
	}
	
	/**
	 * Updates the nodes' virtual coordinates. <strong>Note</strong> - this method does not update
	 * the actual objects linked to the layout.
	 *
	 */
	public function update():Void
	{
		throw 'Method must be overriden by child class';
	}
	
	/**
	 * Renders all layout property values to all objects in the collection
	 *
	 */
	public dynamic function render():Void
	{
		var n:INode3d;
		for(i in 0...size)
		{
			n = this.nodes[i];
			if(n.link==null) continue;
			n.link.x = n.x;
			n.link.y = n.y;
			n.link.z = n.z;
		}
		
	}
	
	/**
	 * Renders all layout property values of a specified node
	 * @param node
	 *
	 */
	public function renderNode(node:INode3d):Void
	{
		if (node.link == null) return;
		node.link.x = node.x;
		node.link.y = node.y;
		node.link.z = node.z;
	}
	
	/**
	 * Determines if an object added to the layout contains the properties/methods
	 * required from the layout.
	 *
	 * @see #addToLayout()
	 */
	dynamic public function validateObject(object:Dynamic):Bool
	{
		if(	Reflect.hasField(object,'x')&&
			Reflect.hasField(object,'y')&&
			Reflect.hasField(object,'z')&&
			Reflect.hasField(object,'rotationX')&&
			Reflect.hasField(object,'rotationY')&&
			Reflect.hasField(object,'rotationZ')
		) return true;
		
		return false;
	}

}
