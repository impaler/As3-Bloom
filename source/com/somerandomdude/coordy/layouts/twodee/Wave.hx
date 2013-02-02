package com.somerandomdude.coordy.layouts.twodee ;

import com.somerandomdude.coordy.constants.LayoutType;
import com.somerandomdude.coordy.constants.PathAlignType;
import com.somerandomdude.coordy.constants.WaveFunction;
import com.somerandomdude.coordy.events.CoordyNodeEvent;
import com.somerandomdude.coordy.nodes.INode;
import com.somerandomdude.coordy.nodes.twodee.Node2d;
#if (js && jeash)
import flash.display.DisplayObject;
#end

@:expose("Coordinates.layouts.twodee.Wave")
class Wave extends Layout2d ,implements ILayout2d
{
	private static inline var PI:Float=Math.PI;
	
	public var frequency(get_frequency, set_frequency):Float;
	function get_frequency():Float { return frequency; }
	function set_frequency(value:Float):Float { frequency = value; updateFunction(); return frequency; }
	
	public var waveFunction(get_waveFunction, set_waveFunction):String;
	function get_waveFunction():String { return waveFunction; }
	function set_waveFunction(value:String):String
	{
		switch(value)
		{
			case WaveFunction.SINE:
				waveFunction=value;
				_function=Math.sin;
			case WaveFunction.COSINE:
				waveFunction=value;
				_function=Math.cos;
			case WaveFunction.TAN:
				waveFunction=value;
				_function=Math.tan;
			case WaveFunction.ARCSINE:
				waveFunction=value;
				_function=Math.asin;
			case WaveFunction.ARCCOSINE:
				waveFunction=value;
				_function=Math.acos;
			case WaveFunction.ARCTAN:
				waveFunction=value;
				_function=Math.atan;
			default:
				waveFunction=WaveFunction.SINE;
				_function=Math.sin;
		}
		this.updateFunction();
		return waveFunction;
	}
	
	public var _function:Dynamic;
	
	public var heightMultiplier(get_heightMultiplier, set_heightMultiplier):Float;
	function get_heightMultiplier():Float { return heightMultiplier; }
	function set_heightMultiplier(value:Float):Float { heightMultiplier = value; updateFunction(); return heightMultiplier; }
	
	/** The additional angle offset of each node from it's original path-aligned angle (in degrees) **/
	public var thetaOffset(get_thetaOffset, set_thetaOffset):Float;
	function get_thetaOffset():Float { return thetaOffset; }
	function set_thetaOffset(value:Float):Float { thetaOffset = value; updateFunction(); return thetaOffset; }
	
	/** The type of path alignment each node executes (parallel or perpendicular) **/
	public var alignType(get_alignType,set_alignType):String;
	function get_alignType():String { return alignType; }
	function set_alignType(value:String):String { alignType = value; updateFunction(); return alignType; }
	
	/** The additional angle offset of each node from it's original path-aligned angle (in degrees) **/
	public var alignAngleOffset(get_alignAngleOffset,set_alignAngleOffset):Float;
	function get_alignAngleOffset():Float { return alignAngleOffset; }
	function set_alignAngleOffset(value:Float):Float { alignAngleOffset = value; updateFunction(); return alignAngleOffset; }

	/**
	 * Distributes nodes in a wave.
	 *
	 * @param width				Width (i.e. length) of the wave
	 * @param height			Height of the wave
	 * @param x					x position of the wave
	 * @param y					y position of the wave
	 * @param frequency			Frequency of the wave
	 * @param waveFunction		Wave type (sin,cos,tan,etc.)
	 * @param jitterX			Jitter multiplier for the layout's nodes on the x axis
	 * @param jitterY			Jitter multiplier for the layout's nodes on the y axis
	 * @param alignType			Method in which nodes align to the path of the wave
	 * @param alignOffset		The additional offset angle of each node's path alignment
	 *
	 */
	public function new(width:Float,
						height:Float,
						x:Float=0,
						y:Float=0,
						frequency:Float=1,
						waveFunction:String=WaveFunction.SINE,
						jitterX:Float=0,
						jitterY:Float=0,
						alignType:String=PathAlignType.ALIGN_PERPENDICULAR,
						alignOffset:Float=0)
	{
		super();
		this.width=width;
		this.height=height;
		this.x=x;
		this.y=y;
		this.jitterX=jitterX;
		this.jitterY=jitterY;
		this.frequency=frequency;
		this.waveFunction=waveFunction;
		this.alignType=alignType;
		this.alignAngleOffset = alignOffset;
		
		heightMultiplier = 0;
		thetaOffset = 0;
	}
	
	/**
	 * Returns the type of layout in a string format
	 *
	 * @see com.somerandomdude.coordy.layouts.LayoutType
	 * @return Layout's type
	 *
	 */
	override public function toString():String { return LayoutType.WAVE; }
	
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
		var node:Node2d = new Node2d(object,0,0,((Math.random()>.5)?-1:1)*Math.random(),((Math.random()>.5)?-1:1)*Math.random());
		this.storeNode(node);
		
		this.update();
		
		if(object&&moveToCoordinates) this.render();
		
		dispatchEvent(new CoordyNodeEvent(CoordyNodeEvent.ADD, node));
		
		return node;
	}

	
	/**
	* Clones the current object's properties (does not include links to DisplayObjects)
	*
	* @return Wave clone of object
	*/
	override public function clone():ILayout2d
	{
		return new Wave(width, height, x, y, frequency, waveFunction, jitterX, jitterY, alignType, alignAngleOffset);
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
			c=this.nodes[i];
			if (!c.link) continue;
			#if (js && jeash)
				var link:DisplayObject = cast(c.link, DisplayObject);
				link.x=c.x;
				link.y=c.y;
				link.rotation = (this.alignType == PathAlignType.NONE)?0:c.rotation;
			#end
				c.link.x=c.x;
				c.link.y=c.y;
				c.link.rotation = (this.alignType == PathAlignType.NONE)?0:c.rotation;
		}
	}
	
	/**
	 * Updates the nodes' virtual coordinates. <strong>Note</strong> - this method does not update
	 * the actual objects linked to the layout.
	 *
	 */
	override public function update():Void
	{
		
		var len:Int = this.size;
		var c:Node2d;
		for(i in 0...len)
		{
			c = this.nodes[i];
			c.x = (i*(this.width/len))+x+(c.jitterX*this.jitterX);
			c.y = (_function(PI*(i+1)/(len/2)*frequency-(thetaOffset*PI/180))*((this.height+(heightMultiplier*i))/2))+y+(c.jitterY*this.jitterY);
			
			//in future, add option to align wave to center or top by adding height/2 to all nodes' y property
			
			if(_function==Math.sin) c.rotation = Math.cos(PI*(i+1)/(len/2)*frequency)*180/PI;
			else if(_function==Math.cos) c.rotation = Math.sin(PI*(i+1)/(len/2)*frequency)*180/PI;
			else c.rotation = 0;
			
			if(this.alignType==PathAlignType.ALIGN_PERPENDICULAR) c.rotation+=90;
			c.rotation+=this.alignAngleOffset;
		}
	}
	
}