package com.somerandomdude.coordy.layouts.twodee;


import com.somerandomdude.coordy.constants.GridLayoutDirection;
import com.somerandomdude.coordy.constants.LayoutType;
import com.somerandomdude.coordy.events.CoordyNodeEvent;
import com.somerandomdude.coordy.layouts.twodee.ILayout2d;
import com.somerandomdude.coordy.nodes.INode;
import com.somerandomdude.coordy.nodes.twodee.GridNode;
import com.somerandomdude.coordy.nodes.twodee.INode2d;
import com.somerandomdude.coordy.geom.Rectangle;

@:expose("Coordinates.layouts.twoodee.Grid")
class Grid extends Layout2d , implements ILayout2d{
	
	
	
	public var rows(default, default):Int;
	public var columns(default, default):Int;
	public var paddingX(default, default):Float;
	public var paddingY(default, default):Float;
	public var hDirection(default, set_hDirection):String;
	public var vDirection(default, default):String;
	public var maxNodes(default, default):Int;


	public function new(width:Float,
							height:Float,
							columns:Int,
							rows:Int,
							paddingX:Float=0,
							vPadding:Float=0,
							x:Float=0,
							y:Float=0,
							jitterX:Float=0,
							jitterY:Float=0)
	{
		super();
			this.width=width;
			this.height=height;
			this.rows=rows;
			this.columns=columns;
			this.maxNodes=rows*columns;
			this.paddingX=paddingX;
			this.paddingY=vPadding;
			this.x=x;
			this.y=y;
			this.jitterX=jitterX;
			this.jitterY=jitterY;
	}
	

		
	function set_hDirection(value:String):String{
		hDirection = value;
		this.updateFunction();
		return hDirection;
	}
		
	function set_vDirection(value:String):String{
		vDirection = value;
		this.updateFunction();
		return vDirection;
	}
		
		
	/**
	* Returns the type of layout in a string format
	*
	* @see com.somerandomdude.coordy.layouts.LayoutType
	* @return Layout's type
	*
	*/
	override public function toString():String { return LayoutType.GRID; }
		
	/**
	 * Get cell objects by column index
	 *
	 * @param  column  cell index of grid
	 * @return      an array of cell objects by column index
	 * @see         Cell
	 */
	public function getColumn(column:Int):Array<Dynamic>
	{
		var c:Array<Dynamic> = new Array();
		for(i in 0...rows)
		{
			c.push(nodes[(i*columns)+column]);
		}
		return c;
	}
		
		
		/**
		 * Get cell objects by row index
		 *
		 * @param  row  row index of grid
		 * @return      an array of cell objects by row index
		 * @see         Cell
		 */
		public function getRow(row:Int):Array<Dynamic>
		{
			var c:Array<Dynamic> = new Array();
			for( i in (row*columns)...((row*columns)+columns))
			{
				c.push(nodes[i]);
			}
			return c;
		}
		
		/**
		 * Removes cell link of DisplayObject at specified grid coordinates
		 *
		 * @param  column  column index of grid
		 * @param  row  row index of grid
		 */
		public function removeItemAt(column:Int, row:Int)
		{
			this.getNodeFromCoordinates(column, row).link=null;
		}
		
		/**
		 * Adds cell link of object at specified grid coordinates
		 *
		 * @param  column  column index of grid
		 * @param  row  row index of grid
		 * @param  moveToCoordinates  automatically move DisplayObject to corresponding cell's coordinates
		 */
		public function addItemAt(object:Dynamic, column:Int, row:Int, moveToCoordinates:Bool=true):INode
		{
			if(!validateObject(object)) throw 'Object does not implement at least one of the following properties: "x", "y", "rotation"';
			if(linkExists(object)) return null;
			var node:GridNode = this.getNodeFromCoordinates(column, row);
			node.link=object;
			if(moveToCoordinates)
			{
				object.x=node.x;
				object.y=node.y;
			}
			return node;
		}
		
		/**
		 * Returns cell at specified grid coordinates
		 *
		 * @param  column  column index of grid
		 * @param  row  row index of grid
		 * @return GridNode object from specified coordinates
		 */
		public function getNodeFromCoordinates(column:Int, row:Int):GridNode
		{
			return this.nodes[(row*columns)+column];
		}
		
		/**
		 * Adds object to layout in next
		 * available position.
		 *
		 * @param  object  Dynamic to add to layout
		 * @param  moveToCoordinates
		 * automatically move DisplayObject to
		 * corresponding nodes's coordinates
		 *
		 * @return newly created node object containing a link to the object
		 */
		override public function addNode(object:Dynamic=null, moveToCoordinates:Bool=true):INode
		{
			// @TODO fix constructor for jeash to use Dynamic instead of DisplayObject
			if(object!=null&&!validateObject(object)) throw 'Dynamic does not implement at least one of the following properties: "x", "y", "rotation"';
			if(object!=null&&linkExists(object)||size>=maxNodes) return null;
			
			var d:Rectangle = this.calculateCellSize();
			var c:Int = size%columns;
			var r:Int = Math.floor(size/(maxNodes/rows));
			var node:GridNode = new GridNode(object, c,r,((d.width*c)+(c*paddingX)+x),((d.height*r)+(r*paddingY)+y));
			
			storeNode(node);
			
			if (object!=null && moveToCoordinates) { object.x = node.x ;  object.y = node.y; };
			
			dispatchEvent(new CoordyNodeEvent(CoordyNodeEvent.ADD, node));
			
			return node;
		}
			override public function addNodes(count:Int):Void {}

		/**
		 * Adds object to layout in next available position
		 * <strong>This method is depreceated.</strong>
		 *
		 * @param  object  Dynamic to add to layout
		 * @param  moveToCoordinates  automatically move DisplayObject
		 * to corresponding node's coordinates
		 *
		 * @return newly created node object containing a link to the object
		 */
		override public function addToLayout(object:Dynamic, moveToCoordinates:Bool=true):INode
		{
			if(!validateObject(object)) throw 'Object does not implement at least one of the following properties: "x", "y", "rotation"';
			if(object!=null&&linkExists(object)||size>=maxNodes) return null;
			
			var d:Rectangle = this.calculateCellSize();
			var c:Int = size%columns;
			var r:Int = Math.floor(size/(maxNodes/rows));
			var node:GridNode = new GridNode(object, c,r,((d.width*c)+(c*paddingX)+x),((d.height*r)+(r*paddingY)+y));
			
			storeNode(node);
			if (moveToCoordinates) { object.x = node.x ; object.y = node.y; }
			
			dispatchEvent(new CoordyNodeEvent(CoordyNodeEvent.ADD, node));
			
			return node;
		}
			
		
		
		
		
	/**
	* Clones the current object's properties
	* (does not include links to DisplayObjects)
	* @return Grid clone of object
	*/
	override public function clone():ILayout2d
	{
		return new Grid(width, height, columns, rows, paddingX, paddingY, x, y, jitterX, jitterY);
	}

	
		
	/**
	 * Updates the nodes' virtual coordinates.
	 * <strong>Note</strong> - this method does not update
	 * the actual objects linked to the layout.
	 */
	public override function update():Void {
		var total:Int = columns * rows;
		var d:Rectangle = calculateCellSize();
		var c:Int;
		var r:Int;
		var node:GridNode;
		for (i in 0...size) {
			node = this.nodes[i];
			if (node == null) break;
			c = i % columns;
			r = Math.floor(i / (total / rows));
			if (hDirection == GridLayoutDirection.RIGHT_TO_LEFT) c = (columns - 1) - c;
			if (vDirection == GridLayoutDirection.BOTTOM_TO_TOP) r = (rows - 1) - r;
			node.x = ((d.width * c) + (c * paddingX) + x);
			node.y = ((d.height * r) + (r * paddingY) + y);
		}
	}
	
	function calculateCellSize():Rectangle
	{
		return new Rectangle(0, 0, (width - ((columns - 1) * paddingX)) / columns, (height - ((rows - 1) * paddingY)) / rows);
	}
	
		

	
}