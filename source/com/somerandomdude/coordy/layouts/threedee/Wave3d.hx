package com.somerandomdude.coordy.layouts.threedee;

import com.somerandomdude.coordy.constants.LayoutType;
import com.somerandomdude.coordy.constants.PathAlignType;
import com.somerandomdude.coordy.constants.WaveFunction;
import com.somerandomdude.coordy.events.CoordyNodeEvent;
import com.somerandomdude.coordy.nodes.INode;
import com.somerandomdude.coordy.nodes.threedee.INode3d;
import com.somerandomdude.coordy.nodes.threedee.Node3d;

@:expose("Coordinates.layouts.threedee.Wave3d")
class Wave3d extends Layout3d ,implements ILayout3d
{
	public var  frequency(get_frequency,set_frequency):Float;
	public var  waveFunctionY(get_waveFunctionY,set_waveFunctionY):String;
	public var  waveFunctionZ(get_waveFunctionZ,set_waveFunctionZ):String;
	public var  functionY(default, default):Float->Float;
	public var  functionZ(default, default):Float->Float;

	public var  heightMultiplier(get_heightMultiplier, set_heightMultiplier):Float;
	public var  depthMultiplier(get_depthMultiplier, set_depthMultiplier):Float;

	public static inline var PI:Float = Math.PI;
	public static inline var PI_180:Float = PI/180;

	public var  alignType(get_alignType,set_alignType):String;
	public var  alignAngleOffset(get_alignAngleOffset,set_alignAngleOffset):Float;
	
	/**
	 * The additional angle offset_of each node from it's original path-aligned angle (in degrees)
	 * @return Angle in degrees
	 *
	 */
	public function get_alignAngleOffset():Float { return this.alignAngleOffset; }
	public function set_alignAngleOffset(value:Float):Float
	{
		this.alignAngleOffset=value;
		this.updateFunction();
		return alignAngleOffset;
	}
	
	/**
	 * The type of path alignment each node executes (parallel or perpendicular)
	 *
	 * @see com.somerandomdude.coordy.layouts.PathAlignType
	 *
	 * @return String value of the path alignment type
	 *
	 */
	public function get_alignType():String { return this.alignType; }
	public function set_alignType(value:String):String
	{
		this.alignType=value;
		this.updateFunction();
		return alignType;
	}

	/**
	 * Mutator/accessor for waveFunctionY property
	 *
	 * @return	Wave function for the Y-axis
	 */
	public function get_waveFunctionY():String { return  waveFunctionY; }
	public function set_waveFunctionY(value:String):String
	{
		switch(value)
		{
			case WaveFunction.SINE:
				 waveFunctionY=value;
				 functionY=Math.sin;
				
			case WaveFunction.COSINE:
				 waveFunctionY=value;
				 functionY=Math.cos;
				
			case WaveFunction.TAN:
				 waveFunctionY=value;
				 functionY=Math.tan;
				
			case WaveFunction.ARCSINE:
				 waveFunctionY=value;
				 functionY=Math.asin;
				
			case WaveFunction.ARCCOSINE:
				 waveFunctionY=value;
				 functionY=Math.acos;
				
			case WaveFunction.ARCTAN:
				 waveFunctionY=value;
				 functionY=Math.atan;
				
			default:
				 waveFunctionY=WaveFunction.SINE;
				 functionY=Math.sin;
		}
		this.updateFunction();
		return waveFunctionY;
	}
	
	/**
	 * Mutator/accessor for waveFunctionZ property
	 *
	 * @return	Wave function for the Z-axis
	 */
	public function get_waveFunctionZ():String { return  waveFunctionZ; }
	public function set_waveFunctionZ(value:String):String
	{
		switch(value)
		{
			case WaveFunction.SINE:
				 waveFunctionZ=value;
				 functionZ=Math.sin;
				
			case WaveFunction.COSINE:
				 waveFunctionZ=value;
				 functionZ=Math.cos;
				
			case WaveFunction.TAN:
				 waveFunctionZ=value;
				 functionZ=Math.tan;
				
			case WaveFunction.ARCSINE:
				 waveFunctionZ=value;
				 functionZ=Math.asin;
				
			case WaveFunction.ARCCOSINE:
				 waveFunctionZ=value;
				 functionZ=Math.acos;
				
			case WaveFunction.ARCTAN:
				 waveFunctionZ=value;
				 functionZ=Math.atan;
				
			default:
				 waveFunctionZ=WaveFunction.SINE;
				 functionZ=Math.sin;
		}
		this.updateFunction();
		return waveFunctionZ;
	}

	/**
	 * Accessor for frequency property
	 *
	 * @return	Frequency of wave
	 */
	public function get_frequency():Float { return  frequency; }
	public function set_frequency(value:Float):Float
	{
		this.frequency=value;
		this.updateFunction();
		return frequency;
	}
	
	/**
	 * Accessor for heightMultiplier property
	 *
	 * @return	HeightMultipler of wave
	 */
	function get_heightMultiplier():Float { return  heightMultiplier; }
	function set_heightMultiplier(value:Float):Float
	{
		this.heightMultiplier=value;
		this.updateFunction();
		return heightMultiplier;
	}
	
	/**
	 * Accessor for depthMultiplier property
	 *
	 * @return	DepthMultipler of wave
	 */
	function get_depthMultiplier():Float { return  depthMultiplier; }
	function set_depthMultiplier(value:Float):Float
	{
		this.depthMultiplier=value;
		this.updateFunction();
		return depthMultiplier;
	}
	
	/**
	 * Distributes nodes in a 3d wave.
	 *
	 * @param width				Width of the wave
	 * @param height			Height of the wave
	 * @param depth				Depth of the wave
	 * @param x					x position of the wave
	 * @param y					y position of the wave
	 * @param z					z position of the wave
	 * @param frequency			Frequency of the wave
	 * @param waveFunctionY		Wave function (sin,cos,tan,etc.) applied along the y-axis
	 * @param waveFunctionZ		Wave function (sin,cos,tan,etc.) applied along the z-axis
	 * @param jitterX			Jitter multiplier for the layout's nodes on the x axis
	 * @param jitterY			Jitter multiplier for the layout's nodes on the y axis
	 * @param jitterZ			Jitter multiplier for the layout's nodes on the z axis
	 *
	 */
	public function new(width:Float,
						height:Float,
						depth:Float,
						x:Float=0,
						y:Float=0,
						z:Float=0,
						frequency:Float=1,
						waveFunctionY:String=WaveFunction.SINE,
						waveFunctionZ:String=WaveFunction.COSINE,
						jitterX:Float=0,
						jitterY:Float=0,
						jitterZ:Float=0,
						alignType:String=PathAlignType.ALIGN_PERPENDICULAR,
						alignOffset:Float=0):Void
	{
		super();
		heightMultiplier = 0;
		depthMultiplier = 0;
		functionY = Math.sin;
		functionZ = Math.cos;
		this.width=width;
		this.height=height;
		this.depth=depth;
		this.x=x;
		this.y=y;
		this.z=z;
		this.jitterX=jitterX;
		this.jitterY=jitterY;
		this.jitterZ=jitterZ;
		this.frequency=frequency;
		this.waveFunctionY=waveFunctionY;
		this.waveFunctionZ=waveFunctionZ;
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
	override public function toString():String { return LayoutType.WAVE_3D; }
	
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
		if (object != null && !validateObject(object)) throw 'Object does not implement at least one of the following properties: "x", "y", "z", "rotationX", "rotationY", "rotationZ"';
		if(object!=null &&linkExists(object)) return null;
		var node:Node3d = new Node3d(object,0,0,0,((Math.random()>.5)?-1:1)*Math.random(),((Math.random()>.5)?-1:1)*Math.random(),((Math.random()>.5)?-1:1)*Math.random());
		this.storeNode(cast(node, INode3d));
		this.update();
		
		if(object!=null &&moveToCoordinates) this.render();
		
		dispatchEvent(new CoordyNodeEvent(CoordyNodeEvent.ADD, node));
		
		return node;
	}
	
	
	///**
	 //* Adds object to layout in next available position <strong>This method is depreceated.</strong>
	 //*
	 //* @param  object  Object to add to layout
	 //* @param  moveToCoordinates  automatically move DisplayObject to corresponding node's coordinates
	 //*
	 //* @return newly created node object containing a link to the object
	 //*/
	//override public function addToLayout(object:Object,  moveToCoordinates:Bool=true):INode
	//{
		//if(!validateObject(object)) throw new Error('Object does not implement at least one of the following properties: "x", "y", "z", "rotationX", "rotationY", "rotationZ"');
		//if(linkExists(object)) return null;
		//
		//var node:Node3d = new Node3d(object,0,0,0,((Math.random()>.5)?-1:1)*Math.random(),((Math.random()>.5)?-1:1)*Math.random(),((Math.random()>.5)?-1:1)*Math.random());
		//this.storeNode(node as INode3d);
		//this.update();
		//
		//if(moveToCoordinates) this.render();
		//
		//dispatchEvent(new CoordyNodeEvent(CoordyNodeEvent.ADD, node));
		//
		//return node;
	//}
	
	/**
	* Clones the current object's properties (does not include links to DisplayObjects)
	*
	* @return Wave3d clone of object
	*/
	override public function clone():ILayout3d
	{
		return new Wave3d( width,  height,  depth,  x,  y,  z,  frequency,  waveFunctionY,  waveFunctionZ,  jitterX,  jitterY,  jitterZ);
	}
	
	/**
	 * Updates the nodes' virtual coordinates.<strong>Note</strong> - this method does not update
	 * the actual objects linked to the layout.
	 *
	 */
	override public function update():Void
	{
		var c:Node3d;
		var r:Float = this.rotation*PI_180;
		
		for(i in 0...size)
		{
			c = this.nodes[i];
			c.x = (i*(this.width/this.size))+ x+(c.jitterX*this.jitterX);
			c.y = (( functionY((Math.PI*(i+1)/(this.size/2)+r)* frequency)*((this.height+( heightMultiplier*i))/2)))+ y+(c.jitterY*this.jitterY);
			
			//in future, add option to align wave to center or top by adding height/2 to all nodes' y property
			
			c.z = (( functionZ((Math.PI*(i+1)/(this.size/2)+r)* frequency)*((this.depth+( depthMultiplier*i))/2)))+ z+(c.jitterZ*this.jitterZ);
			
			if( functionY==Math.sin) c.rotationZ = Math.cos(PI*(i+1)/( size/2)* frequency)*180/PI;
			else if( functionY==Math.cos) c.rotationZ = Math.sin(PI*(i+1)/( size/2)* frequency)*180/PI;
			else c.rotationZ = 0;
			
			if(this.alignType==PathAlignType.ALIGN_PERPENDICULAR) c.rotationZ+=90;
			c.rotationZ+=this.alignAngleOffset;
		}
	}
	
	/**
	 * Applies all layout property values to all cells/display objects in the collection
	 *
	 */
	override dynamic public function render():Void
	{
		var c:Node3d;
		for(i in 0...size)
		{
			c=this.nodes[i];
			if(c.link==null) continue;
			c.link.x=c.x;
			c.link.y=c.y;
			c.link.z=c.z;
			
			if(this.alignType==PathAlignType.NONE) continue;
			
			c.link.rotationZ=c.rotationZ;
		}
	}

}