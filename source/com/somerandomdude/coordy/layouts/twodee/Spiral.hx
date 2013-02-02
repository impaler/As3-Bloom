package com.somerandomdude.coordy.layouts.twodee ;
import com.somerandomdude.coordy.constants.LayoutType;
import com.somerandomdude.coordy.constants.PathAlignType;
import com.somerandomdude.coordy.events.CoordyNodeEvent;
import com.somerandomdude.coordy.nodes.INode;
import com.somerandomdude.coordy.nodes.twodee.INode2d;
import com.somerandomdude.coordy.nodes.twodee.Node2d;
#if (js && jeash)
import flash.display.DisplayObject;
#end

@:expose("Coordinates.layouts.twodee.Spiral")
class Spiral extends Layout2d ,implements ILayout2d
{
	static inline var PI:Float=Math.PI;

	public var angleDelta(get_angleDelta,set_angleDelta):Float;
	function get_angleDelta():Float { return this.angleDelta; }
	function set_angleDelta(value:Float):Float
	{
		this.angleDelta=value;
		this.updateFunction();
		return angleDelta;
	}
	
	public var spiralConstant(get_spiralConstant,set_spiralConstant):Float;
	function get_spiralConstant():Float { return this.spiralConstant; }
	function set_spiralConstant(value:Float):Float
	{
		this.spiralConstant=value;
		this.updateFunction();
		return spiralConstant;
	}
	
	public var circumference(get_circumference,set_circumference):Float;
	function get_circumference():Float { return this.circumference; }
	function set_circumference(value:Float):Float
	{
		this.circumference=value;
		this.updateFunction();
		return circumference;
	}
	
	override function set_height(value:Float):Float
	{
		height=value;
		circumference=value;
		updateFunction();
		return height;
	}
	
	override function set_width(value:Float):Float
	{
		width=value;
		circumference=value;
		updateFunction();
		return width;
	}
	
	/**
	 * The additional angle offset of each node from it's original path-aligned angle (in degrees)
	 * @return Angle in degrees
	 *
	 */
	public var alignAngleOffset(get_alignAngleOffset,set_alignAngleOffset):Float;
	function get_alignAngleOffset():Float { return this.alignAngleOffset; }
	function set_alignAngleOffset(value:Float):Float
	{
		this.alignAngleOffset=value;
		this.updateFunction();
		return alignAngleOffset;
	}
	
	/**
	 * The type of path alignment each node executes (parallel or perpendicular)
	 */
	public var alignType(get_alignType,set_alignType):String;
	@:getter function get_alignType():String { return this.alignType; }
	@:setter function set_alignType(value:String):String
	{
		this.alignType=value;
		this.updateFunction();
		return alignType;
	}
	
	/**
	 * Distributes nodes in a spiral.
	 *
	 * @param target_			DisplayObjectContainer which parents all objects in the layout
	 * @param circumference		Circumference of the spiral
	 * @param x					x position of the ellipse
	 * @param y					y position of the ellipse
	 * @param rotation			Rotation of the ellipse
	 * @param jitterX			Jitter multiplier for the layout's nodes on the x axis
	 * @param jitterY			Jitter multiplier for the layout's nodes on the y axis
	 * @param alignType			Method in which nodes align to the path of the ellipse
	 * @param alignOffset		The additional offset angle of each node's path alignment
	 *
	 */
	public function new(circumference:Float,
							spiralConstant:Float=.15,
							x:Float=0,
							y:Float=0,
							angleDelta:Float=30,
							rotation:Float=0,
							jitterX:Float=0,
							jitterY:Float=0,
							alignType:String=PathAlignType.NONE,
							alignOffset:Float=0):Void
	{
		super();
		this.circumference=circumference;
		this.x=x;
		this.y=y;
		this.jitterX=jitterX;
		this.jitterY=jitterY;
		this.rotation=rotation;
		this.angleDelta=angleDelta;
		this.spiralConstant=spiralConstant;
		this.alignType=alignType;
		this.alignAngleOffset=alignOffset;
	}
	
	/**
	 * Returns the type of layout in a string format
	 *
	 * @see com.somerandomdude.coordy.layouts.LayoutType
	 * @return Layout's type
	 *
	 */
	override public function toString():String { return LayoutType.SPIRAL; }
	
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
		if(object !=null && linkExists(object)) return null;
		var node:Node2d = new Node2d(object,0,0,((Math.random()>.5)?-1:1)*Math.random(),((Math.random()>.5)?-1:1)*Math.random());
		this.storeNode(node);
		
		this.update();
		
		if(object!=null &&moveToCoordinates) this.render();
		
		dispatchEvent(new CoordyNodeEvent(CoordyNodeEvent.ADD, node));
		
		return node;
	}
	
	
	/**
	 * Renders all layout property values of a specified node
	 * @param node
	 *
	 */
	override public function renderNode(node:INode2d):Void
	{
		super.renderNode(node);
		#if (js && jeash)
		if (Std.is(node.link, DisplayObject)) {
			var link:DisplayObject = cast(node.link, DisplayObject);
			link.rotation=node.rotation;
		}else
		#end
		{
			node.link.rotation=node.rotation;
		}
	}
	
	/**
	 * Applies all layout property values to all cells/display objects in the collection
	 *
	 */
	override dynamic public function render():Void
	{
		var c:Node2d;
		for(i in 0...size)
		{
			c = this.nodes[i];
			if (c.link == null) continue;
			//prevent jeash/js getter/setter bug
			#if (js && jeash)
			if (Std.is(c.link, DisplayObject)) {
				var link:DisplayObject = cast(c.link, DisplayObject);
				link.x=c.x;
			  link.y=c.y;
			  link.rotation=(alignType==PathAlignType.NONE)?0:c.rotation;
			}else
			#end
			{
				c.link.x=c.x;
				c.link.y=c.y;
				c.link.rotation = (alignType == PathAlignType.NONE)?0:c.rotation;
			}
		}
	}
	
	/**
	* Clones the current object's properties (does not include links to DisplayObjects)
	*
	* @return Ellipse clone of object
	*/
	override public function clone():ILayout2d
	{
		return new Ellipse(width, height, x, y, rotation, jitterX, jitterY, alignType, alignAngleOffset);
	}
	
	/**
	 * Updates the nodes' virtual coordinates. <strong>Note</strong> - this method does not update
	 * the actual objects linked to the layout.
	 *
	 */
	override public function update():Void
	{
		var w:Float = this.width/2;
		var h:Float = this.height/2;
		var rOffset:Float = rotation*(PI/180);
		var rad:Float;
		var c:Node2d;
		
		var phi:Float;
		
		for(i in 0...size)
		{
			c = this.nodes[i];
			
			phi = angleDelta*i*PI/180;
			
			c.x = x +  circumference * Math.exp(spiralConstant * phi) * Math.cos(phi);
			c.y = y + circumference * Math.exp(spiralConstant * phi) * Math.sin(phi);
			
			c.rotation = Math.atan2((y)-c.y, (x)-c.x)*(180/PI);
			if(this.alignType==PathAlignType.ALIGN_PERPENDICULAR) c.rotation+=90;
			c.rotation+=this.alignAngleOffset;
			
		}
	}
	
	/**
	 *
	 * @private
	 */
	public function rotateCellToTop(cell:INode2d):Float
	{
		var xR:Float = cell.link.x-(x+width/2);
		var yR:Float = cell.link.y-(y+height/2);
		
		var rads:Float = Math.atan2(yR*(width/height), xR);
		//rotation of individual object
		var a:Float = rads*(180/PI)+90;
		
		this.rotation=rotation-a;
		return a;
	}
}