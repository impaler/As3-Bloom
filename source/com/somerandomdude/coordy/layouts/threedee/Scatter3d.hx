package com.somerandomdude.coordy.layouts.threedee ;
	import com.somerandomdude.coordy.constants.LayoutType;
	import com.somerandomdude.coordy.events.CoordyNodeEvent;
	import com.somerandomdude.coordy.nodes.INode;
	import com.somerandomdude.coordy.nodes.threedee.ScatterNode3d;

@:expose("Coordinates.layouts.threedee.Scatter3d")
class Scatter3d extends Layout3d ,implements ILayout3d
{
	
	public var jitter(get_jitter,set_jitter):Float;
	public var jitterRotation(get_jitterRotation,set_jitterRotation):Bool;
	
	/**
	 * Mutator/accessor for jitter property
	 *
	 * @return	Global jitter value of scatter layout
	 */
	function get_jitter():Float { return this.jitter; }
	function set_jitter(value:Float):Float
	{
		this.jitter=value;
		this.updateFunction();
		return jitter;
	}
	
	/**
	 * Mutator/accessor for property determining whether the layout's nodes' rotation is randomly jittered
	 *
	 * @return Bool value of jitter rotation state
	 */
	function get_jitterRotation():Bool { return this.jitterRotation; }
	function set_jitterRotation(value:Bool):Bool
	{
		this.jitterRotation=value;
		this.updateFunction();
		return jitterRotation;
	}
	
	/**
	 * Distributes nodes in a scattered fashion in all 3 dimensions.
	 *
	 * @param width 			Width of the scatter
	 * @param height 			Height of the scatter
	 * @param depth 			Depth of the scatter
	 * @param jitter 			Jitter multiplier of scatter
	 * @param x 				x position of the scatter
	 * @param y 				y position of the scatter
	 * @param z 				z position of the scatter
	 * @param jitterRotation	Bool determining if nodes are randomly rotated
	 *
	 */
	public function new(width:Float,
							height:Float,
							depth:Float,
							jitter:Float=1,
							x:Float=0,
							y:Float=0,
							z:Float=0,
							jitterRotation:Bool=false):Void
	{
		super();
		this.width = width;
		this.height = height;
		this.depth=depth;
		this.x = x;
		this.y = y;
		this.z = z;
		this.jitter=jitter;
		this.jitterRotation=jitterRotation;
		this.nodes = new Array();
	}
	
	/**
	 * Returns the type of layout in a string format
	 *
	 * @see com.somerandomdude.coordy.layouts.LayoutType
	 * @return Layout's type
	 *
	 */
	override public function toString():String { return LayoutType.SCATTER_3D; }
	
	/**
	 * Adds object to layout in next available position.
	 *
	 * @param  object  Object to add to layout
	 * @param  moveToCoordinates  automatically move DisplayObject to corresponding nodes's coordinates
	 *
	 * @return newly created node object containing a link to the object
	 */
	override public function addNode(object:Dynamic=null, moveToCoordinates:Bool=true):INode
	{
		if(object!=null && !validateObject(object)) throw 'Object does not implement at least one of the following properties: "x", "y", "z", "rotationX", "rotationY", "rotationZ"';
		if(object!=null && linkExists(object)) return null;
		var p:Int = (Math.round(Math.random()))!=0 ? -1:1;
		var xPos:Float = (((Math.random()* width* jitter))*p)+ x;
		p = (Math.round(Math.random()))!=0 ? -1:1;
		var yPos:Float = (((Math.random()* height* jitter))*p)+ y;
		p = (Math.round(Math.random())) !=0? -1:1;
		var zPos:Float = (((Math.random()* depth* jitter))*p)+ z;
		var node:ScatterNode3d = new ScatterNode3d(object,xPos,yPos,zPos,( jitterRotation)?(Math.random()*p*360):0, ( jitterRotation)?(Math.random()*p*360):0, ( jitterRotation)?(Math.random()*p*360):0);
		node.xRelation=(node.x-this.width/2)/this.width/2;
		node.yRelation=(node.y-this.height/2)/this.height/2;
		node.zRelation=(node.z-this.depth/2)/this.depth/2;
		
		this.storeNode(node);
		
		if (object != null && moveToCoordinates) {
			object.x = node.x;
			object.y = node.y;
			object.z = node.z;
		}
		
	//	dispatchEvent(new CoordyNodeEvent(CoordyNodeEvent.ADD, node));
		
		return node;
	}
		
	/**
	 * Adds object to layout in next available position <strong>This method is depreceated.</strong>
	 *
	 * @param  object  Object to add to organizer
	 * @param  moveToCoordinates  automatically move DisplayObject to corresponding cell's coordinates
	 *
	 * @return newly created node object containing a link to the object
	 */
	override public function addToLayout(object:Dynamic, moveToCoordinates:Bool=true):INode
	{
		return addNode(object, moveToCoordinates);
	}
	
	/**
	 * Applies all layout property values to all cells/display objects in the collection
	 *
	 * @param  tweenFunction  function with a Cell parameter for managing the motion of the cell object
	 */
	override public function render():Void
	{
		for(i in 0...size)
		{
			if(! nodes[i].link) continue;
			this.nodes[i].link.x=this.nodes[i].x;
			this.nodes[i].link.y=this.nodes[i].y;
			this.nodes[i].link.z=this.nodes[i].z;
			this.nodes[i].link.rotationX=this.nodes[i].rotationX;
			this.nodes[i].link.rotationY=this.nodes[i].rotationY;
			this.nodes[i].link.rotationZ=this.nodes[i].rotationZ;
		}
	}
	
	/**
	 * Updates the nodes' virtual coordinates. <strong>Note</strong> - this method does not update
	 * the actual objects linked to the layout.
	 *
	 */
	override public function update():Void
	{
		for(i in 0...size)
		{
			 nodes[i].x=( nodes[i].xRelation*this.width)+this.x;
			 nodes[i].y=( nodes[i].yRelation*this.height)+this.y;
			 nodes[i].z=( nodes[i].zRelation*this.depth)+this.z;
		}
	}
	
	/**
	 * Re-scatters layout and adjusts cell links appropriately
	 *
	 */
	public function scatter():Void
	{
		var p:Int;
		var xPos:Float;
		var yPos:Float;
		var zPos:Float;
		for(i in 0...size)
		{
			p = (Math.round(Math.random())) !=0 ? -1:1;
			xPos = (((Math.random()* width* jitter))*p)+ x;
			p = (Math.round(Math.random())) !=0 ? -1:1;
			yPos = (((Math.random()* height* jitter))*p)+ y;
			p = (Math.round(Math.random())) !=0 ? -1:1;
			zPos = (((Math.random()* depth* jitter))*p)+ z;
			
			this.nodes[i].x=xPos;
			this.nodes[i].y=yPos;
			this.nodes[i].z=zPos;
		}
		this.updateFunction();
	}
	
	/**
	* Clones the current object's properties (does not include links to DisplayObjects)
	*
	* @return ScatterOrganizer clone of object
	*/
	override public function clone():ILayout3d
	{
		return new Scatter3d( width, height, depth, jitter, x, y, z, jitterRotation);
	}
	
}