package com.somerandomdude.coordy.layouts.threedee;

	import com.somerandomdude.coordy.constants.LayoutType;
	import com.somerandomdude.coordy.constants.StackOrder;
	import com.somerandomdude.coordy.events.CoordyNodeEvent;
	import com.somerandomdude.coordy.layouts.IOrderedLayout;
	import com.somerandomdude.coordy.nodes.INode;
	import com.somerandomdude.coordy.nodes.threedee.OrderedNode3d;
	import com.somerandomdude.coordy.utils.Utilities;

	@:expose("Coordinates.layouts.threedee.Stack3d")
	class Stack3d extends Layout3d ,implements ILayout3d, implements IOrderedLayout
	{
		
		public var offset(get_offset,set_offset):Float;
		public var zOffset(get_zOffset,set_zOffset):Float;
		public var angle(get_offsetAngle,set_offsetAngle):Float;
		public var order(get_order,set_order):String;
		
		/**
		 * Mutator/accessor for the order in which the nodes are stacked (ascending or descending)
		 *
		 * @see com.somerandomdude.coordy.layouts.StackOrder
		 *
		 * @return String identifying stack order
		 *
		 */
		function get_order():String { return this.order; }
		function set_order(value:String):String
		{
			this.order=value;
			updateFunction();
			return order;
		}
		
		/**
		 * Mutator/accessor for the x & y offset of each node in the stack
		 *
		 * @see #offsetAngle
		 *
		 * @return x & y offset of nodes in stack
		 *
		 */
		function get_offset():Float { return this.offset; }
		function set_offset(value:Float):Float
		{
			this.offset=value;
			updateFunction();
			return offset;
		}
		
		/**
		 * Mutator/accessor for the z offset of each node in the stack
		 * @return z offset of nodes in stack
		 *
		 */
		function get_zOffset():Float { return this.zOffset; }
		function set_zOffset(value:Float):Float
		{
			this.zOffset=value;
			updateFunction();
			return zOffset;
		}
		
		/**
		 * Mutator/accessor for the angle of which the nodes are offset (in degrees)
		 *
		 * @see #offset
		 *
		 * @return Angle of offset
		 *
		 */
		function get_offsetAngle():Float { return this.angle; }
		function set_offsetAngle(value:Float):Float
		{
			this.angle=value;
			updateFunction();
			return angle;
		}
		
		/**
		 * Distributes nodes in a 3d stack.
		 *
		 * @param angle			Offset angle (in degrees)
		 * @param offset		x & y offset for each node
		 * @param zOffset		z offset for each node
		 * @param x				x position of the stack
		 * @param y				y position of the stack
		 * @param z				z position of the stack
		 * @param order			Determines whether stack is ordered by ascending or descending
		 * @param jitterX		Jitter multiplier for the layout's nodes on the x axis
		 * @param jitterY		Jitter multiplier for the layout's nodes on the y axis
		 * @param jitterZ		Jitter multiplier for the layout's nodes on the z axis
		 *
		 */
		public function new(angle:Float=45,
								offset:Float=5,
								zOffset:Float=5,
								x:Float=0,
								y:Float=0,
								z:Float=0,
								order:String=StackOrder.ASCENDING,
								jitterX:Float=0,
								jitterY:Float=0,
								jitterZ:Float=0):Void
		{
			super();
			this.angle=angle;
			this.offset=offset;
			this.zOffset=zOffset;
			this.x=x;
			this.y=y;
			this.z=z;
			this.jitterX=jitterX;
			this.jitterY=jitterY;
			this.jitterZ=jitterZ;
			this.order=order;
		}
		
		/**
		 * Returns the type of layout in a string format
		 *
		 * @see com.somerandomdude.coordy.layouts.LayoutType
		 * @return Layout's type
		 *
		 */
		override public function toString():String { return LayoutType.STACK_3D; }
		
		/**
		 * Adds object to layout in next available position.
		 *
		 * @param  object  Dynamic to add to layout
		 * @param  moveToCoordinates  automatically move DisplayObject to corresponding nodes's coordinates
		 *
		 * @return newly created node object containing a link to the object
		 */
		override public function addNode(object:Dynamic=null, moveToCoordinates:Bool=true):INode
		{
			if (object != null && !validateObject(object)) throw 'Dynamic does not implement at least one of the following properties: "x", "y", "z", "rotationX", "rotationY", "rotationZ"';
			if(object!=null && linkExists(object)) return null;
			var node:OrderedNode3d = new OrderedNode3d(object, this.size);
			this.storeNode(node);
			this.cleanOrder();
			this.update();
			
			if(object!=null && moveToCoordinates) this.render();
			
			dispatchEvent(new CoordyNodeEvent(CoordyNodeEvent.ADD, node));
			
			return node;
		}
			
		/**
		 * Adds object to layout in next available position <strong>This method is depreceated.</strong>
		 *
		 * @param  object  Dynamic to add to layout
		 * @param  moveToCoordinates  automatically move DisplayObject to corresponding node's coordinates
		 *
		 * @return newly created node object containing a link to the object
		 */
		override public function addToLayout(object:Dynamic, moveToCoordinates:Bool=true):INode
		{
			return addNode(object, moveToCoordinates);
		}
		
		/**
		 * Adds DisplayObject to layout in the specified order within the layout
		 *
		 * @param  object  Dynamic to add to layout
		 * @param  index   Index at which the DisplayObject is put in the layout
		 * @param  moveToCoordinates  automatically move DisplayObject to corresponding node's coordinates
		 *
		 * @return newly created node object containing a link to the object
		 */
		public function addToLayoutAt(object:Dynamic, index:Int, moveToCoordinates:Bool=true):INode
		{
			if (!validateObject(object)) throw 'Dynamic does not implement at least one of the following properties: "x", "y", "z", "rotationX", "rotationY", "rotationZ"';
			if(linkExists(object)) return null;
			var node:OrderedNode3d = new OrderedNode3d(object,index,0,0,0);
			
			storeNodeAt(node, index);
			this.cleanOrder();
			this.update();
			
			
			if(moveToCoordinates) this.render();
			dispatchEvent(new CoordyNodeEvent(CoordyNodeEvent.ADD, node));
			
			return node;
		}
		
		/**
		* Clones the current object's properties (does not include links to DisplayObjects)
		*
		* @return Stack3d clone of object
		*/
		override public function clone():ILayout3d
		{
			return new Stack3d(angle, offset, zOffset, x, y, z, order, jitterX, jitterY, jitterZ);
		}
		
		/**
		 * Updates the nodes' virtual coordinates. <strong>Note</strong> - this method does not update
		 * the actual objects linked to the layout.
		 *
		 */
		override public function update():Void
		{
			if(this.nodes==null) return;
			
			this.cleanOrder();
			var rad:Float = this.angle*Math.PI/180;
			if (this.order == StackOrder.ASCENDING) this.nodes.sort(Utilities.sortOnOrderDescending);
			
			var node:OrderedNode3d;
			for(i in 0...size)
			{
				node = this.nodes[i];
				node.x=this.x+(Math.cos(rad)*offset*i)+(node.jitterX*this.jitterX);
				node.y=this.y+(Math.sin(rad)*offset*i)+(node.jitterY*this.jitterY);
				node.z=this.z+(zOffset*i)+(node.jitterZ*this.jitterZ);
			}
		}
		
		/**
		 *@private
		 *
		 */
		private function cleanOrder():Void
		{
			this.nodes.sort(Utilities.sortOnOrderAscending);
			
			for( i in 0...size) { this.nodes[i].order=i; }
		}
		
	}