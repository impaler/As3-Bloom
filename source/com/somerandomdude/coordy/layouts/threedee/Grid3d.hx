package com.somerandomdude.coordy.layouts.threedee;

	import com.somerandomdude.coordy.constants.LayoutType;
	import com.somerandomdude.coordy.events.CoordyNodeEvent;
	import com.somerandomdude.coordy.nodes.INode;
	import com.somerandomdude.coordy.nodes.threedee.GridNode3d;
	import com.somerandomdude.coordy.nodes.threedee.Node3d;

@:expose("Coordinates.layouts.threedee.Grid3d")
class Grid3d extends Layout3d , implements ILayout3d {
	
	#if (!fields || fields)
	public var rows(default, set_rows):Int;
	function set_rows(value:Int) { rows = value; updateFunction(); return rows; }
	public var columns(default, set_columns):Int;
	function set_columns(value:Int) { columns = value; updateFunction(); return columns; }
	public var layers(default, set_layers):Int;
	function set_layers(value:Int) { layers = value;  updateFunction(); return layers; }
	public var paddingX(default, set_paddingX):Int;
	function set_paddingX(value:Int) { paddingX = value; updateFunction(); return paddingX; }
	public var paddingY(default, set_paddingY):Int;
	function set_paddingY(value:Int) { paddingY = value; updateFunction(); return paddingY; }
	public var paddingZ(default, set_paddingZ):Int;
	function set_paddingZ(value:Int) { paddingZ = value; updateFunction(); return paddingZ; }
	public var maxNodes(default, set_maxNodes):Int;
	function set_maxNodes(value:Int) { maxNodes = value;  updateFunction(); return maxNodes; }
	#end
	
	public var cellWidth(get_cellWidth, never):Float;
	function get_cellWidth():Float {
		return nodes[0].width;
	}
	
	public var cellHeight(get_cellHeight, never):Float;
	function get_cellHeight():Float {
		return nodes[0].height;
	}
	
	public function new(width:Float, height:Float, depth:Float, columns:Int=1, rows:Int=1, layers:Int=1, paddingX:Int = 0, paddingY:Int = 0, paddingZ:Int = 0, x:Float = 0, y:Float = 0, z:Float = 0, jitterX:Float = 0, jitterY:Float = 0, jitterZ:Float = 0) {
		super();
		this.width = width;
		this.height = height;
		this.depth = depth;
		this.columns = columns;
		this.rows = rows;
		this.layers = layers;
		this.paddingX = paddingX;
		this.paddingY = paddingY;
		this.paddingZ = paddingZ;
		this.x = x;
		this.y = y;
		this.z = z;
		this.jitterX = jitterX;
		this.jitterY = jitterY;
		this.jitterZ = jitterZ;
		this.maxNodes = rows * columns * layers;
	}
	
	override public function toString() { return LayoutType.GRID_3D ; }
	
	/** Get node objects by column index **/
	public function getColumn(column:Int):Array<Node3d> {
		var c:Array<Node3d> = [];
		for (i in 0...rows) {
			c.push(nodes[(i * columns) + column]);
		}
		return c;
	}
	
	/** Get node objects by row index **/
	public function getRow(row:Int):Array<Node3d> {
		var c:Array<Node3d> = [];
		for(i in (row*columns)...(row*columns+columns)){
				c.push(nodes[i]);
		}
		return c;
	}
	
	/** * Get node objects by layer index **/
	public function getLayer(layer:Int):Dynamic{
		return [];
	}
	
	/** Removes node link of DisplayObject at specified grid coordinates **/
	public function removeItemAt(column:Int,row:Int):Void{
		this.getNodeFromCoordinates(column, row).link = null;
	}
	
	/** Returns node at specified grid coordinates **/
	public function getNodeFromCoordinates(column:Int,row:Int):GridNode3d{
		return this.nodes[(row * columns) + column];
	}
	
	
		/**
	 * Adds object to layout in next available position.
	 *
	 * @param  object  Object to add to layout
	 * @param  moveToCoordinates  automatically move DisplayObject to corresponding nodes's coordinates
	 *
	 * @return newly created node object containing a link to the object
	 */
	override public function addNode(object:Dynamic=null, moveToCoordinates:Bool=true):INode{
		if (object != null && !validateObject(object)) throw 'Object does not implement at least one of the following properties: "x", "y", "z", "rotationX", "rotationY", "rotationZ"';
		if(object!=null && linkExists(object)||size>=maxNodes) return null;

		var w:Float=(width-((columns-1)*paddingX))/columns;
		var h:Float=(height-((rows-1)*paddingY))/rows;
		var d:Float=(depth-((layers-1)*paddingZ))/layers;
		
		var c:Int = size%columns;
		var r:Int = Math.floor(size/(rows))%rows;
		var l:Int = Math.floor(size/(rows*columns));
			
		var node:GridNode3d = new GridNode3d(object,c,r,l,((w*c)+(c*paddingX)+x),((h*r)+(r*paddingY)+y),((d*l)+(l*paddingZ)+z));
		storeNode(node);
		
		update();
		
		if (object != null && moveToCoordinates) render();
	
		dispatchEvent(new CoordyNodeEvent(CoordyNodeEvent.ADD, node));
		
		return node;
	}
	
	
	/** Clones the current object's properties (does not include links to DisplayObjects) **/
	override public function clone():ILayout3d
	{
		return new Grid3d(width, height, depth, columns, rows, layers, paddingX, paddingY, paddingZ, x, y, z, jitterX, jitterY, jitterZ);
	}
	
	/** Updates the nodes' virtual coordinates. <strong>Note</strong> - this method does not update the actual objects linked to the layout. **/
	override public function update():Void{
		var total:Int = columns*rows*layers;
		
		var w:Float=(width-((columns-1)*paddingX))/columns;
		var h:Float=(height-((rows-1)*paddingY))/rows;
		var d:Float=(depth-((layers-1)*paddingZ))/layers;
		
		var c:Int;
		var r:Int;
		var l:Int;
		var node:GridNode3d;
		for(i in 0...size)
		{
			node = this.nodes[i];
			
			c = i % columns;
		  r = Std.int(i/(rows))  % rows;
		 	l = Std.int( i / ((rows * columns)) ) ;
							
			node.x = ((w*c)+(c*paddingX)+x)+(node.jitterX*this.jitterX);
			node.y = ((h*r)+(r*paddingY)+y)+(node.jitterY*this.jitterY);
			node.z = ((d*l)+(l*paddingZ)+z)+(node.jitterZ*this.jitterZ);
			
		}
	}
}