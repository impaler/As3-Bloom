package com.somerandomdude.coordy.layouts.twodee;
import com.somerandomdude.coordy.constants.LayoutType;
import com.somerandomdude.coordy.constants.PathAlignType;
import com.somerandomdude.coordy.events.CoordyNodeEvent;
import com.somerandomdude.coordy.layouts.twodee.ILayout2d;
import com.somerandomdude.coordy.nodes.INode;
import com.somerandomdude.coordy.nodes.twodee.EllipseNode;
import com.somerandomdude.coordy.nodes.twodee.INode2d;
#if (js && jeash)
import flash.display.DisplayObject;
#end

@:expose("Coordinates.layouts.twodee.Ellipse")
class Ellipse extends Layout2d, implements ILayout2d {
	private static inline var PI:Float = Math.PI;
	
	/** The type of path alignment each node executes (parallel or perpendicular) **/
	public var alignType(get_alignType, set_alignType):String;
	function get_alignType() { return alignType; }
	function set_alignType(value:String) { alignType = value; updateFunction(); return alignType; }
	
	/** The additional angle offset of each node from it's original path-aligned angle (in degrees) **/
	public var alignAngleOffset(get_alignAngleOffset, set_alignAngleOffset):Float;
	function get_alignAngleOffset():Float { return alignAngleOffset; }
	function set_alignAngleOffset(value:Float) { alignAngleOffset = value; updateFunction(); return alignAngleOffset; }
	
	
	public var eccentricity(get_eccentricity, null):Float;
	function get_eccentricity():Float{
		var a =  width > height ?width / 2:height / 2;
		var b = width > height? height / 2:width / 2;
		var e = Math.sqrt(1 - (Math.pow(b, 2) / Math.pow(a, 2)));
		return e;
	}
	
	/** Distributes nodes in an ellipse. **/
	public function new(width:Float, height:Float, x:Float = 0, y:Float = 0, rotation:Float = 0, jitterX:Float = 0, jitterY:Float = 0, alignType:String = PathAlignType.NONE, alighOffset:Float = 0) {
		super();
		this.width = width;
		this.height = height;
		this.x = x;
		this.y = y;
		this.jitterX = jitterX;
		this.jitterY = jitterY;
		this.rotation = rotation;
		this.alignType = alignType;
		this.alignAngleOffset = alignAngleOffset;
	}
	
	override public function toString():String
	{
		return LayoutType.ELLIPSE;
	}
	
	/** Adds object to layout in next available position. **/
	override public function addNode(object:Dynamic=null, moveToCoordinates:Bool=true):INode
	{
			if (object !=null && !validateObject(object)) throw 'Object does not implement at least one of the following properties: "x", "y", "z", "rotationX", "rotationY", "rotationZ"';
			if(object !=null &&linkExists(object)) return null;
			var node:EllipseNode = new EllipseNode(object,0,0,0,((Math.random()>.5)?-1:1)*Math.random(),((Math.random()>.5)?-1:1)*Math.random());
			this.storeNode(node);
			
			this.update();
			
			if(object!=null && moveToCoordinates ) this.render();
			
			dispatchEvent(new CoordyNodeEvent(CoordyNodeEvent.ADD, node));
			
			return node;
	}
	
	/**  Renders all layout property values of a specified node **/
	override public function renderNode(node:INode2d):Void
	{
		super.renderNode(node);
		#if (js && jeash)
		if (Std.is(node.link, DisplayObject)) {
			cast(node.link, DisplayObject).rotation = node.rotation;
		}else
		#end
		{
			node.link.rotation = node.rotation;
		}
	}
	
	override dynamic public function render():Void
	{
		var c:EllipseNode;
		for (i in 0...size) {
			c = this.nodes[i];
			if (c.link == null) continue;
			// prevent javascript getter/setter bug
			#if (js && jeash)
			if (Std.is(c.link, DisplayObject)) {
				var link:DisplayObject = cast(c.link, DisplayObject);
				link.x=c.x;
				link.y=c.y;
				link.rotation= alignType==PathAlignType.NONE ?0:c.rotation;
			}else
			#end
			{
				c.link.x=c.x;
				c.link.y=c.y;
				c.link.rotation=(alignType==PathAlignType.NONE)?0:c.rotation;
			}
		}
	}
	
	/** Returns angle of position of specified cell in degrees  **/
	public function getCellAngle(cell:INode2d):Float {
		var xR:Float;
		var yR:Float;
		#if (js && jeash)
		if (Std.is(cell.link, DisplayObject)) {
			var link:DisplayObject = cast(cell.link, DisplayObject);
			xR = link.x - (x + width / 2);
			yR = link.y - (y + height / 2);
		}else
		#end
		{
			xR = cell.link.x - (x + width / 2);
			yR = cell.link.y - (y + height / 2);
		}
		var rads:Float = Math.atan2(yR * (width / height), xR);
		var a:Float = rads * (180 / PI) + 90;
		return a;
	}
	
	/**  Sets angle of position of specified cell in degrees  **/
	public function setNodeAndle(node:INode2d, angle:Float):Void {
		var nAngle:Float = getCellAngle(node);
		this.rotation = this.rotation - nAngle-angle;
	}
	
	/** Clones the current object's properties (does not include links to DisplayObjects) **/
	override public function clone():ILayout2d
	{
		return new Ellipse(width, height, x, y, rotation, jitterX, jitterY, alignType, alignAngleOffset);
	}

	
	/**
	 * Updates the nodes' virtual coordinates. <strong>Note</strong> - this method does not update
	 * the actual objects linked to the layout.
	 *
	 */
	override public function update():Void {
		
		var w:Float = this.width/2;
		var h:Float = this.height/2;
		var rOffset:Float = rotation*(PI/180);
		var rad:Float;
		var c:EllipseNode;
		
		for(i in 0...size)
		{
			c = this.nodes[i];
			rad = ((PI*(i))/(this.size/2))+rOffset;
							
			c.x = (w*Math.cos(rad))+(w+x)+(c.jitterX*this.jitterX)-w;
			c.y = (h*Math.sin(rad))+(h+y)+(c.jitterY*this.jitterY)-h;
			c.rotation = Math.atan2((y)-c.y, (x)-c.x)*(180/PI);
			if(this.alignType==PathAlignType.ALIGN_PERPENDICULAR) c.rotation+=90;
			c.rotation+=this.alignAngleOffset;
			
		}
	}
	
	

	function rotateCellToTop(cell:INode2d):Float {
		
		var xR:Float;
		var yR:Float;
		//  javascript getter/setter bug fix
		#if (js && jeash)
		if (Std.is(cell.link, DisplayObject) ){
			var link = cast(cell.link, DisplayObject);
			xR = link.x - (x + width / 2);
			yR = link.y - (y + height / 2);
		}else
		#end
		{
			xR = cell.link.x - (x + width / 2);
			yR = cell.link.y - (y + height / 2);
		}
		var rads:Float = Math.atan2(yR*(width/height), xR);
		//rotation of individual object
		var a:Float = rads*(180/PI)+90;
		this.rotation=rotation-a;
		return a;
	}
		
}