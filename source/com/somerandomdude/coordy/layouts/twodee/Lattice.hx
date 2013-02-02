package com.somerandomdude.coordy.layouts.twodee;

import com.somerandomdude.coordy.constants.LatticeAlternationPattern;
import com.somerandomdude.coordy.constants.LatticeOrder;
import com.somerandomdude.coordy.constants.LatticeType;
import com.somerandomdude.coordy.constants.LayoutType;
import com.somerandomdude.coordy.events.CoordyNodeEvent;
import com.somerandomdude.coordy.nodes.INode;
import com.somerandomdude.coordy.nodes.twodee.GridNode;

@:expose("Coordinates.layouts.twodee.Lattice")
class Lattice extends Layout2d ,implements ILayout2d{
	
	public var order:String;
	public var rows:Int;
	public var columns:Int;
	public var paddingX:Float;
	public var paddingY:Float;
	public var columnWidth:Float;
	public var rowHeight:Float;
	public var latticeType:String;
	public var alternate:String;
	public var allowOverflow:Bool;
	public var maxCells:Int;
	
	/**
	 * Mutator/accessor for lattice type property
	 *
	 * @see com.somerandomdude.coordy.constants.LatticeType
	 *
	 * @return Lattice type in string format
	 *
	 */
	public function get_latticeType():String { return latticeType; }
	public function set_latticeType(value:String):Void
	{
		latticeType=value;
		updateFunction();
	}
	
	/**
	 * Mutator/accessor for alternate property
	 *
	 * @return	the alternating order in which the diagonal lattice is created (horizontal or vertical)
	 */
	public function get_alternate():String { return this.alternate; }
	public function set_alternate(value:String):Void
	{
		this.alternate=value;
		this.updateFunction();
	}
	
	/**
	 * Mutator/accessor for order property
	 *
	 * @return 	the order in which elements are put in the lattice (horizonal or vertical)
	 */
	public function get_order():String { return order; }
	public function set_order(value:String):Void
	{
		this.order=value;
		this.adjustLattice();
		this.updateFunction();
	}
	
	/**
	 * Mutator/accessor for allowOverflow property
	 *
	 * @param	value	Bool value determining whether overflow is allowed
	 */
	 function get_allowOverflow():Bool { return this.allowOverflow; }
	 function set_allowOverflow(value:Bool):Bool
	{
		this.allowOverflow = value;
		return allowOverflow;
	}
	
	/**
	 * Mutator/accessor for width property
	 *
	 * @param	value	Global width dimension of layout organizer
	 */
	override  function get_width():Float { return columnWidth*columns; }
	override  function set_width(value:Float):Float
	{
		this.width=value;
		this.columnWidth = value/columns;
		this.updateFunction();
		return width;
	}

	/**
	 * Mutator/accessor for height property
	 *
	 * @param	value	Global height dimension of layout organizer
	 */
	override  function get_height():Float { return rowHeight*rows; }
	override  function set_height(value:Float):Float
	{
		
		this.height=value;
		this.rowHeight = value/rows;
		this.updateFunction();
		return height;
	}
	
	/**
	 * Mutator/accessor for paddingY property
	 *
	 * @return	X padding of grid nodes for layout
	 */
	 function get_paddingX():Float { return paddingX; }
	 function set_paddingX(value:Float):Float
	{
		this.paddingX=value;
		this.updateFunction();
		return paddingX;
	}

	/**
	 * Mutator/accessor for paddingY property
	 *
	 * @return	Y padding of grid nodes for layout
	 */
	 function get_paddingY():Float { return paddingY; }
	 function set_paddingY(value:Float):Float
	{
		this.paddingY=value;
		this.updateFunction();
		return paddingY;
	}
	
	/**
	 * Mutator/accessor for columnWidth property
	 *
	 * @return	column width of each individual node
	 */
	 function get_columnWidth():Float { return this.columnWidth; }
	 function set_columnWidth(value:Float):Float
	{
		this.columnWidth=value;
		this.updateFunction();
		return columnWidth;
	}
	
	/**
	 * Mutator/accessor for rowHeight property
	 *
	 * @return	row height of each individual node
	 */
	 function get_rowHeight():Float { return this.rowHeight; }
	 function set_rowHeight(value:Float):Float
	{
		this.rowHeight=value;
		this.updateFunction();
		return rowHeight;
	}
	
	/**
	 * Mutator/accessor for rows property
	 *
	 * @return	Row length
	 */
	function get_rows():Int { return rows; }
	function set_rows(value:Int):Int
	{
		this.rows=value;
		this.order=LatticeOrder.ORDER_VERTICALLY;
		this.adjustLattice();
		this.updateFunction();
		this.maxCells = rows * columns;
		return rows;
	}
	
	/**
	 * Mutator/accessor for columns property
	 *
	 * @return	Column length
	 */
	function get_columns():Int { return columns; }
	function set_columns(value:Int):Int
	{
		this.columns=value;
		this.order=LatticeOrder.ORDER_HORIZONTALLY;
		this.adjustLattice();
		this.updateFunction();
		this.maxCells = rows * columns;
		return columns;
	}
	
	/**
	 * Distributes nodes in a lattice.
	 *
	 * @param width				Width of the lattice
	 * @param height			Height of the lattice
	 * @param columns			Float of columns in the lattice
	 * @param rows				Float of rows in the lattice
	 * @param allowOverflow		Determines whether nodes beyond the total number of lattice cells are added to the lattice
	 * @param order				The order in which the lattice nodes are laid out
	 * @param hPadding			Horizontal padding between columns
	 * @param vPadding			Vertical padding between rows
	 * @param x					x position of the grid
	 * @param y					x position of the grid
	 * @param jitterX			Jitter multiplier for the layout's nodes on the x axis
	 * @param jitterY			Jitter multiplier for the layout's nodes on the y axis
	 *
	 */
	public function new(width:Float,
							height:Float,
							columns:Int=1,
							rows:Int=1,
							allowOverflow:Bool=true,
							order:String=LatticeOrder.ORDER_HORIZONTALLY,
							hPadding:Float=0,
							vPadding:Float=0,
							x:Float=0,
							y:Float=0,
							jitterX:Float=0,
							jitterY:Float=0):Void
	{
		super();
		this.paddingX=hPadding;
		this.paddingY=vPadding;
		this.x=x;
		this.y=y;
		this.columns=columns;
		this.rows=rows;
		this.columnWidth=width/columns;
		this.rowHeight=height/rows;
		this.width=width;
		this.height=height;
		this.maxCells=rows*columns;
		this.allowOverflow=allowOverflow;
		this.jitterX=jitterX;
		this.jitterY = jitterY;
		this.latticeType = LatticeType.DIAGONAL;
		this.alternate = LatticeAlternationPattern.ALTERNATE_VERTICALLY;
		
	}
	
	/**
	 * Returns the type of layout in a string format
	 *
	 * @see com.somerandomdude.coordy.layouts.LayoutType
	 * @return Layout's type
	 *
	 */
	override public function toString():String { return LayoutType.LATTICE; }
	
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
		if(!allowOverflow&&size>=maxCells) return null;
		
		var c:Int = (order==LatticeOrder.ORDER_VERTICALLY) ? (size)%columns:(size)%Math.floor(((size)/rows));
		var r:Int = (order==LatticeOrder.ORDER_VERTICALLY) ? Math.floor((size)/columns):(size)%rows;
		var node:GridNode = new GridNode(object, c,r);
		
		this.storeNode(node);
		this.adjustLattice();
		this.update();
		
		if(object!=null&&moveToCoordinates) this.render();
		
		if (order == LatticeOrder.ORDER_HORIZONTALLY ) this.columns = Math.ceil(this.size / rows);
		else if(order==LatticeOrder.ORDER_HORIZONTALLY ) this.rows = Math.ceil(this.size/columns);
		
		dispatchEvent(new CoordyNodeEvent(CoordyNodeEvent.ADD, node));
		
		return node;
	}
	
	
	/**
	 * Removes specified cell and its link from layout organizer and adjusts layout appropriately
	 *
	 * @param  cell  cell object to remove
	 */
	override public function removeNode(node:INode):Void
	{
		super.removeNode(node);
		this.adjustLattice();
		this.updateFunction();
	}
	
	/**
	 * Updates the nodes' virtual coordinates. <strong>Note</strong> - this method does not update
	 * the actual objects linked to the layout.
	 *
	 */
	override public function update():Void
	{
		var node:GridNode;
		for(i in 0...size)
		{
			node = this.nodes[i];
			if(node==null) break;
						
			node.x = (node.column*(columnWidth+paddingX))+x+(node.jitterX*this.jitterX);
			node.y = (node.row*(rowHeight+paddingY))+y+(node.jitterY*this.jitterY);
			
			if(latticeType == LatticeType.DIAGONAL &&alternate == LatticeAlternationPattern.ALTERNATE_VERTICALLY&& node.row%2!=0 ) node.x+=columnWidth/2;
			else if(latticeType == LatticeType.DIAGONAL&&alternate == LatticeAlternationPattern.ALTERNATE_HORIZONTALLY&& node.column%2!=0 ) node.y+=rowHeight/2;
		}
		
	}
	
	/**
	* Clones the current object's properties (does not include links to DisplayObjects)
	*
	* @return SquareLatticeOrganizer clone of object
	*/
	override public function clone():ILayout2d
	{
		return new Lattice(width, height, columns, rows, allowOverflow, order, paddingX, paddingY, x, y, jitterX, jitterY);
	}
	
	/**
	 *
	 * @private
	 *
	 */
	private function adjustLattice():Void
	{
		var c:Int;
		var r:Int;
		var node:GridNode;
		var i:Int;
		
		if(order==LatticeOrder.ORDER_HORIZONTALLY)
		{
			for(i in 0...size)
			{
				node = this.nodes[i];
				if(node==null) break;
				
				c = i%columns;
				r = Math.floor(i/columns);
								
				node.column=c;
				node.row=r;
			}
		} else
		{
			for(i in 0...size)
			{
				node = this.nodes[i];
				if(node==null) break;
				
				c = Math.floor(i/rows);
				r = i%rows;
								
				node.column=c;
				node.row=r;
			}
		}
		
		if(order==LatticeOrder.ORDER_VERTICALLY) this.columns = Math.ceil(size/rows);
		else if(order==LatticeOrder.ORDER_HORIZONTALLY) this.rows = Math.ceil(size/columns);
	}
}
