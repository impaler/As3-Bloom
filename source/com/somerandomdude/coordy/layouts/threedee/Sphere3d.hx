package com.somerandomdude.coordy.layouts.threedee ;

import com.somerandomdude.coordy.constants.LayoutType;
import com.somerandomdude.coordy.events.CoordyNodeEvent;
import com.somerandomdude.coordy.helpers.DistributeCustom;
import com.somerandomdude.coordy.helpers.Vertex;
import com.somerandomdude.coordy.nodes.INode;
import com.somerandomdude.coordy.nodes.threedee.Node3d;

@:expose
class Sphere3d extends Layout3d ,implements ILayout3d
{
	
	public static inline var PI:Float=Math.PI;
	public static inline var PI180:Float=PI/180;
	
	public var rotationY(get_rotationY,set_rotationY):Float;
	public var rotationZ(get_rotationZ,set_rotationZ):Float;
	
	public var verts:Array<Dynamic>;
	public var _radius:Float;
	public var radius(get_radius,set_radius):Float;
	
	/**
	 * Mutator/accessor for radius of spheroid. <strong>Note</strong> - Setting the radius will create uniform dimensions for width, height and depth
	 * @return Radius of the sphere
	 *
	 */
	function get_radius():Float { return this._radius; }
	function set_radius(value:Float):Float
	{
		this._radius=value;
		this.width=_radius*2;
		this.height=_radius*2;
		this.depth=_radius*2;
		this.updateFunction();
		return this._radius;
	}
	
	/**
	 * Mutator/accessor for rotation property along the x-axis
	 *
	 * @param	value	Global x-rotation of layout
	 */
	@:getter function get_rotationX():Float { return this.rotation; }
	@:setter function set_rotationX(value:Float):Float
	{
		this.rotation=value;
		this.updateFunction();
		return rotation;
	}
	
	/**
	 * Mutator/accessor for rotation property along the y-axis
	 *
	 * @param	value	Global y-rotation of layout
	 */
	function get_rotationY():Float { return this.rotationY; }
	function set_rotationY(value:Float):Float
	{
		this.rotationY=value;
		this.updateFunction();
		return rotationY;
	}
	
	/**
	 * Mutator/accessor for rotation property along the z-axis
	 *
	 * @param	value	Global z-rotation of layout
	 */
	function get_rotationZ():Float { return this.rotationZ; }
	function set_rotationZ(value:Float):Float
	{
		this.rotationZ=value;
		this.updateFunction();
		return rotationZ;
	}
	
	/**
	 * Distributes nodes in a 3d spheroid.
	 *
	 * @param width			Width of the spheroid
	 * @param height		Height of the spheroid
	 * @param depth			Depth of the spheroid
	 * @param x				x position of the spheroid
	 * @param y				y position of the spheroid
	 * @param z				z position of the spheroid
	 * @param rotation		Rotation of the spheroid along the x-axis
	 * @param rotationY		Rotation of the spheroid along the y-axis
	 * @param rotationZ		Rotation of the spheroid along the z-axis
	 * @param jitterX		Jitter multiplier for the layout's nodes on the x axis
	 * @param jitterY		Jitter multiplier for the layout's nodes on the y axis
	 * @param jitterZ		Jitter multiplier for the layout's nodes on the z axis
	 *
	 * @example
	 * <pre class="prettyprint">
	 * spheroid=new Spheroid3d(this, 150, 150, 150, 400, 400, 0);
	 *
	 * var s:Shape;
	 * for(var i:Int=0; i<100; i++)
	 * {
	 * 		s = new Shape();
	 * 		s.graphics.beginFill(0);
	 * 		s.graphics.drawCircle(0, 0, 3);
	 * 		s.graphics.endFill();
	 *
	 * 		spheroid.addToLayout(s, false);
	 * }
		
	 * spheroid.distributeNodes();
	 * spheroid.updateAndRender();
	 * </pre>
	 */
	//public function new(width:Float,
							//height:Float,
							//depth:Float,
							//x:Float=0,
							//y:Float=0,
							//z:Float=0,
							//rotation:Float=0,
							//rotationY:Float=0,
							//rotationZ:Float=0,
							//jitterX:Float=0,
							//jitterY:Float=0,
							//jitterZ:Float=0):Void
	public function new(radius:Float=0.001,
							x:Float=0,
							y:Float=0,
							z:Float=0,
							rotation:Float=0,
							rotationY:Float=0,
							rotationZ:Float=0,
							jitterX:Float=0,
							jitterY:Float=0,
							jitterZ:Float=0):Void
	{
		super();
		this.nodes = new Array();
		//this.width=width;
		//this.height=height;
		//this.depth=depth;
		this.radius = radius;
		this.x=x;
		this.y=y;
		this.z=z;
		this.jitterX=jitterX;
		this.jitterY=jitterY;
		this.jitterZ=jitterZ;
		this.rotation=rotation;
		this.rotationY=rotationY;
		this.rotationZ=rotationZ;
		//this.radius=Math.max(Math.max(this.width, this.height), this.depth);
	}
	
	/**
	 * Returns the type of layout in a string format
	 *
	 * @see com.somerandomdude.coordy.layouts.LayoutType
	 * @return Layout's type
	 *
	 */
	override public function toString():String { return LayoutType.SPHEROID_3D; }
	
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
		if (object!=null && !validateObject(object)) throw 'Dynamic does not implement at least one of the following properties: "x", "y", "z", "rotationX", "rotationY", "rotationZ"';
		if (object!=null && linkExists(object)) return null;
		var node:Node3d = new Node3d(object,0,0,0,Math.random()*((Math.random()>.5?1:-1)), Math.random()*((Math.random()>.5?1:-1)), Math.random()*((Math.random()>.5?1:-1)));
		//var node:Node3d = new Node3d(object, 0, 0, 0, 0, 0, 0);
		this.storeNode(node);
		
		if(object&&moveToCoordinates) this.render();
		
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
	override public function addToLayout(object:Dynamic,  moveToCoordinates:Bool=true):INode
	{
		return addNode(object, moveToCoordinates);
	}
	
	/**
	 * Attempted to create an even pattern of nodes across the surface of the spheroid. The higher the number of iterations, the more accurate.
	 * <strong>Note</strong> - The processing time increases exponentially the higher the iterations go.
	 *
	 * @param iterations	The number of passes to create an even distribution of nodes across the spheroid
	 *
	 */
	public function distributeNodes(iterations:Int=15):Void
	{
		var vertices:Array<Vertex> = DistributeCustom.createInitialVertices(size, radius);
		
		this.verts = DistributeCustom.DoDistribute(vertices, radius,iterations);
		//this.verts = [];
		//for(i in 0...size)
		//{
			//var v:Vertex = new Vertex( Math.random()-.5, Math.random()-.5,Math.random()-.5 );
			//this.verts.push(v);
		//}
		//
		//this.verts = Distribute.distribute(this.verts, iterations);
	}
	
	/**
	 * Updates the nodes' virtual coordinates. <strong>Note</strong> - this method does not update
	 * the actual objects linked to the layout.
	 *
	 * Much of the code in this method was scooped up at http://reflektions.com/miniml/templatepermalink.asp?id=293
	 *
	 */
	override public function update():Void
	{
		if (this.verts == null) return;
		if (this.verts.length <= 0) return;
		for (i in 0...this.verts.length) {
			var node:Node3d = nodes[i] ;
			node.x = verts[i].x + this.x + (node.jitterX * jitterX);
			node.y = verts[i].y + this.y + (node.jitterY * jitterY);
			node.z = verts[i].z + this.z + (node.jitterZ * jitterZ);
			
		}
		//this._radius=Math.max(Math.max(this.width, this.height), this.depth)/2;
		//
		//var rX:Float	= this.rotation*3.6 * PI180;
		//var rY:Float	= this.rotationY*3.6 * PI180;
		//var rZ:Float	= this.rotationZ*3.6 * PI180;
	//
	//
		//for(i in 0...size)
		//{
			//
			//var c:Node3d = this.nodes[i];
			//if(verts==null||verts[i]==null) continue;
			//c.x=(this.verts[i].x*this.width/2);
			//c.y=(this.verts[i].y*this.height/2);
			//c.z=(this.verts[i].z*this.depth/2);
					//
			//var tempX:Float = (c.x * Math.cos(rY)) - (c.z * Math.sin(rY));
			//var tempZ:Float = (c.x * Math.sin(rY)) + (c.z * Math.cos(rY));
		//
			//var dz:Float	 =  (tempZ * Math.cos(rX)) - (c.y * Math.sin(rX));
			//var tempY:Float =  (tempZ * Math.sin(rX)) + (c.y * Math.cos(rX));
	//
			//var dx:Float	=  (tempX * Math.cos(rZ)) + (tempY * Math.sin(rZ));
			//var dy:Float	=  (tempY * Math.cos(rZ)) - (tempX * Math.sin(rZ));
			//
			//c.x=(x)+dx+(c.jitterX*this.jitterX);
			//c.y=(y)+dy+(c.jitterY*this.jitterY);
			//c.z=(z)+dz+(c.jitterZ*this.jitterZ);
//
		//}
	}
	
	/**
	* Clones the current object's properties (does not include links to DisplayObjects)
	*
	* @return Spheroid3d clone of object
	*/
	override public function clone():ILayout3d
	{
		return null;
		//return new Spheroid3d(this.width, this.height, this.depth, this.x, this.y, this.z, this.rotation, this.rotationY, this.rotationZ, this.jitterX, this.jitterY, this.jitterZ);
	}

}