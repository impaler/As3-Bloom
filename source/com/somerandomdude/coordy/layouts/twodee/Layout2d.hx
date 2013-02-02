package com.somerandomdude.coordy.layouts.twodee;

import com.somerandomdude.coordy.constants.LayoutUpdateMethod;
import com.somerandomdude.coordy.events.CoordyNodeEvent;
import com.somerandomdude.coordy.layouts.ILayout;
import com.somerandomdude.coordy.layouts.Layout;
import com.somerandomdude.coordy.nodes.INode;
import com.somerandomdude.coordy.nodes.twodee.INode2d;
import com.somerandomdude.coordy.proxyupdaters.IProxyUpdater;

#if (js && jeash)
import flash.display.DisplayObject;
#end

class Layout2d extends Layout , implements ILayout2d {
	
		public var x(default,set_x):Float;
		public var y(default,set_y):Float;
		public var width(get_width,set_width):Float;
		public var height(get_height,set_height):Float;
		public var rotation(default,set_rotation):Float;
		public var jitterX(default,set_jitterX):Float;
		public var jitterY(default,set_jitterY):Float;
		
		
		public var updateMethod(default,set_updateMethod):String;//=LayoutUpdateMethod.UPDATE_AND_RENDER;
		//public var updateFunction(default, default):Dynamic;//Function=updateAndRender;
		public var updateFunction:Dynamic;
		
		private var proxyUpdater(default,set_proxyUpdater):IProxyUpdater;
		
		function new() {
			super();
			updateFunction = updateAndRender;
			updateMethod = LayoutUpdateMethod.UPDATE_AND_RENDER;
		}
		
		
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
		public function set_proxyUpdater(value:IProxyUpdater):IProxyUpdater
		{
			updateMethod=value.name;
			updateFunction = value.update;
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
		public function set_updateMethod(value:String):String
		{
			this.updateMethod = value;
			switch(value)
			{
				case LayoutUpdateMethod.NONE:
					this.updateFunction=function(){};
				case LayoutUpdateMethod.UPDATE_ONLY:
					this.updateFunction=update;
				default :
					this.updateFunction=updateAndRender;
			}
			return this.updateMethod;
		}
		
		/**
		 * Mutator/accessor for rotation property
		 *
		 * @return Global rotation position of layout
		 *
		 */
		public function set_rotation(value:Float):Float
		{
			rotation=value;
			updateFunction();
			return rotation;
		}
		
		/**
		 * Mutator/accessor for layout x property
		 *
		 * @return	X position of layout
		 */
		public function set_x(value:Float):Float
		{
			this.x=value;
			this.updateFunction();
			return x;
		}
		
		/**
		 * Mutator/accessor for layout y property
		 *
		 * @return	Y position of layout
		 */
		public function set_y(value:Float):Float
		{
			this.y=value;
			this.updateFunction();
			return this.y;
		}
		
		/**
		 * Mutator/accessor for layout width property
		 *
		 * @return	Width of layout
		 */
		function get_width():Float { return width;}
		public function set_width(value:Float):Float
		{
			this.width=value;
			this.updateFunction();
			return width;
		}
		
		/**
		 * Mutator/accessor for layout height property
		 *
		 * @return	Height position of layout
		 */
		function get_height():Float { return height;}
		public function set_height(value:Float):Float
		{
			this.height=value;
			this.updateFunction();
			return height;
		}
		
		/**
		 * Mutator/accessor for the jitterX property. This value then mulitplied by each node's
		 * corresponding jitterX multiplier value to get its jitter offset.
		 *
		 * @return Global x-axis jitter base value
		 *
		 */
		public function set_jitterX(value:Float):Float
		{
			this.jitterX=value;
			this.updateFunction();
			return jitterX;
		}
		
		/**
		 * Mutator/accessor for the jitterY property. This value then mulitplied by each node's
		 * corresponding jitterY multiplier value to get its jitter offset.
		 *
		 * @return Global y-axis jitter base value
		 *
		 */
		public function set_jitterY(value:Float):Float
		{
			this.jitterY=value;
			this.updateFunction();
			return jitterY;
		}
		
		/**
		 * Core class for all 2D layouts. Cannot be instantiated as is - use child classes.
		 *
		 * @param  target  The object to contain all items managed by LayoutOrganizer
		 */
		//public function Layout2d():Void {}
	
		/**
		 * Adds object to layout in next available position. <strong>Note</strong> - This method is to be
		 * overridden by child classes for implmentation.
		 *
		 * @param  object  Dynamic to add to organizer
		 * @param  moveToCoordinates  automatically move DisplayDynamic to corresponding cell's coordinates
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
		 * Performs the update method defined by the <em>updateMethod</em> property. Is helpful for
		 * for behaviors and proxy updaters to work within the defined functiality set at runtime.
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
		 * Updates the nodes virtual coordinates. <strong>Note</strong> - this method does not update
		 * the actual objects linked to the layout.
		 *
		 */
		public function update():Void {}
		
		/**
		 * Renders all layout property values to all objects in the collection
		 *
		 */
		dynamic public function render():Void
		{
			var n:INode2d;
			for(i in 0...size){
				n = this.nodes[i];
				if (n.link==null) continue;
				//prevent js/jeash bug
				#if (js && jeash)
					cast(n.link, DisplayObject).x = n.x;
					cast(n.link, DisplayObject).y = n.y;
				#else
					n.link.x = n.x;
					n.link.y = n.y;
				#end
			}
		}
		
		/**
		* Clones the current object's properties (does not include links to DisplayDynamics)
		*
		* @return Wave3d clone of object
		*/
		public function clone():ILayout2d
		{
			throw 'Method must be overriden by child class';
			return null;
		}
		
		/**
		 * Renders all layout property values of a specified node
		 * @param node
		 *
		 */
		public function renderNode(node:INode2d):Void
		{
			node.link.x = node.x;
			node.link.y = node.y;
		}
		
		/**
		 * Determines if an object added to the layout contains the properties/methods
		 * required from the layout.
		 *
		 * @see #addToLayout()
		 */
		public dynamic function validateObject(object:Dynamic):Bool
		{
			#if (js && jeash)
			if(Std.is(object,DisplayObject)){
				var _object:DisplayObject = cast(object, DisplayObject);
				if (_object.x != null && _object.y != null && _object.rotation != null) return true;
			}
			#end
			if(Reflect.hasField(object,'x')&&
				Reflect.hasField(object,'y')&&
				Reflect.hasField(object, 'rotation')
			) return true;
			return false;
		}
}