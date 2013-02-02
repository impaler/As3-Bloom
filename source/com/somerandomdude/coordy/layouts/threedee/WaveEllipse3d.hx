package com.somerandomdude.coordy.layouts.threedee ;
	import com.somerandomdude.coordy.constants.LayoutType;
	import com.somerandomdude.coordy.events.CoordyNodeEvent;
	import com.somerandomdude.coordy.nodes.INode;
	import com.somerandomdude.coordy.nodes.threedee.EllipseNode3d;
	import com.somerandomdude.coordy.nodes.threedee.INode3d;

	@:expose("Coordinates.layouts.threedee.WaveEllipse3d")
	class WaveEllipse3d extends Layout3d , implements ILayout3d
	{
		
		public static inline var PI:Float=Math.PI;
		public static inline var PI180:Float=Math.PI/180;
		
		public var rotationY(get_rotationY,set_rotationY):Float;
		public var rotationZ(get_rotationZ,set_rotationZ):Float;
		
		public var frequencyX(get_frequencyX,set_frequencyX):Float;
		public var frequencyY(get_frequencyY,set_frequencyY):Float;
		public var frequencyZ(get_frequencyZ,set_frequencyZ):Float;
		
		/**
		 * Accessor for eccentricity property
		 *
		 * @return	eccentricity  Eccentricity of ellipse
		 */
		function get_eccentricity():Float
		{
			var a:Float = (width>height) ? width/2:height/2;
			var b:Float = (width>height) ? height/2:width/2;
			var e:Float = Math.sqrt(1-(Math.pow(b,2)/Math.pow(a,2)));
			
			return e;
		}
		
		/**
		 * Mutator for frequency X property
		 *
		 * @param	value
		 */
		function set_frequencyX(value:Float):Float
		{
			this.frequencyX=value;
			this.updateFunction();
			return frequencyX;
		}
		
		function get_frequencyX():Float { return this.frequencyX; }
		
		/**
		 * Mutator for frequency X property
		 *
		 * @param	value
		 */
		function set_frequencyY(value:Float):Float
		{
			this.frequencyY=value;
			this.updateFunction();
			return frequencyY;
		}
		
		function get_frequencyY():Float { return this.frequencyY; }
		
		/**
		 * Mutator for frequency X property
		 *
		 * @param	value
		 */
		function set_frequencyZ(value:Float):Float
		{
			this.frequencyZ=value;
			this.updateFunction();
			return frequencyZ;
		}
		
		function get_frequencyZ():Float { return this.frequencyZ; }
		
		///**
		 //* Mutator for rotation property
		 //*
		 //* @param	value	Global rotation position of layout organizer
		//*/
		//function set_rotation(value:Float):Float
		//{
			//this.rotation=value;
			//this.updateFunction();
			//return rotation;
		//}
		//
		//function get_rotation():Float { return this.rotation; }
		
		/**
		 * Mutator for rotation property
		 *
		 * @param	value	Global rotation position of layout organizer
		 */
		function set_rotationY(value:Float):Float
		{
			this.rotationY=value;
			this.updateFunction();
			return rotationY;
		}
		
		function get_rotationY():Float { return this.rotationY; }
		
		/**
		 * Mutator for rotation property
		 *
		 * @param	value	Global rotation position of layout organizer
		 */
		function set_rotationZ(value:Float):Float
		{
			this.rotationZ=value;
			this.updateFunction();
			return rotationZ;
		}
		
		function get_rotationZ():Float { return this.rotationZ; }
		
		/**
		 * Distributes nodes in a 3d wave-ellipse.
		 *
		 * @param width				Width of the wave-ellipse
		 * @param height			Height of the wave-ellipse
		 * @param depth				Depth of the wave-ellipse
		 * @param x					x position of the wave-ellipse
		 * @param y					y position of the wave-ellipse
		 * @param z					z position of the wave-ellipse
		 * @param rotation			Rotation of the wave-ellipse along the x-axis
		 * @param rotationY			Rotation of the wave-ellipse along the y-axis
		 * @param rotationZ			Rotation of the wave-ellipse along the z-axis
		 * @param jitterX			Jitter multiplier for the layout's nodes on the x axis
		 * @param jitterY			Jitter multiplier for the layout's nodes on the y axis
		 * @param jitterZ			Jitter multiplier for the layout's nodes on the z axis
		 *
		 */
		public function new(width:Float,
									height:Float,
									depth:Float,
									frequencyX:Float=1,
									frequencyY:Float=1,
									frequencyZ:Float=5,
									x:Float=0,
									y:Float=0,
									z:Float=0,
									rotation:Float=0,
									rotationY:Float=90,
									rotationZ:Float=90,
									jitterX:Float=0,
									jitterY:Float=0,
									jitterZ:Float=0):Void
		{
			super();
			this.frequencyX = frequencyX;
			this.frequencyY = frequencyY;
			this.frequencyZ = frequencyZ;
			this.nodes = [];
			this.width=width;
			this.height=height;
			this.depth=depth;
			this.x=x;
			this.y=y;
			this.z=z;
			this.jitterX=jitterX;
			this.jitterY=jitterY;
			this.jitterZ=jitterZ;
			this.rotation=rotation;
			this.rotationY=rotationY;
			this.rotationZ=rotationZ;
		}
		
		/**
		 * Returns the type of layout in a string format
		 *
		 * @see com.somerandomdude.coordy.layouts.LayoutType
		 * @return Layout's type
		 *
		 */
		override public function toString():String { return LayoutType.WAVE_ELLIPSE_3D; }
		
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
			if(object!=null&&linkExists(object)) return null;
			var node:EllipseNode3d = new EllipseNode3d(object,0,0,0,0,Math.random()*((Math.random()>.5?1:-1)), Math.random()*((Math.random()>.5?1:-1)), Math.random()*((Math.random()>.5?1:-1)));
			this.storeNode(node);
			
			this.update();
			
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
			return this.addNode(object, moveToCoordinates);
		}
		
		/**
		 * Returns angle of position of specified cell in degrees
		 *
		 * @param  cell  cell object
		 */
		public function getCellAngle(cell:INode3d):Float
		{
			var xR:Float = cell.link.x-(x+width/2);
			var yR:Float = cell.link.y-(y+height/2);
			
			var rads:Float = Math.atan2(yR*(width/height), xR);
			var a:Float = rads*(180/PI)+90;
			
			return a;
		}
		
		/**
		 * Sets angle of position of specified cell in degrees
		 *
		 * @param  cell  cell object
		 * @param  angle angle of cell in degrees
		 */
		public function setCellAngle(cell:INode3d, angle:Float):Void
		{
			var nAngle:Float = getCellAngle(cell);
			this.rotation=this.rotation-angle-nAngle;
		}
		
		/**
		* Clones the current object's properties (does not include links to DisplayObjects)
		*
		* @return WaveEllipse3d clone of object
		*/
		override public function clone():ILayout3d
		{
			var we3d:WaveEllipse3d = new WaveEllipse3d(width, height, depth, x, y, z,frequencyX,frequencyY,frequencyZ, rotation, rotationY, rotationZ, jitterX, jitterY, jitterZ);
			return we3d;
		}
		
		/**
		 * Updates the nodes' virtual coordinates. <strong>Note</strong> - this method does not update
		 * the actual objects linked to the layout.
		 *
		 */
		override public function update():Void
		{
			var w:Float = this.width/2;
			var h:Float = this.height / 2;
			var d:Float = this.depth/ 2;
			var rOffset:Float = rotation*(PI180);
			var rad:Float;
			var c:EllipseNode3d;
			
			//depth=0;
			
			var rY:Float = this.rotationY*(PI/180);
			var rZ:Float = this.rotationZ*(PI/180);
			
			for(i in 0...size)
			{
				
				c = this.nodes[i];
				rad = ((PI*(i))/(this.size/2))+rOffset;
				
				c.x = (Math.sin(rZ)*(w*Math.cos(rad*this.frequencyX)))+(x)+(c.jitterX*this.jitterX);
				//c.y= (Math.cos(rY)*(h*Math.sin(rad*this.frequencyY)))-(Math.cos(rZ)*(h*Math.cos(rad)))+(this.y)+(c.jitterY*this.jitterY);
			  c.y= ((Math.sin(rY)*(d*Math.sin(rad*this.frequencyY))+(y))+(c.jitterY*this.jitterY));
			//c.y = Math.random() * 100;
				c.z=  (Math.sin(rY)*(h*Math.sin(rad*this.frequencyZ))+(z))+(c.jitterZ*this.jitterZ);
				
			}
		}
			
		/**
		 * Moves all elements along the eliptical path so that the specified cell is at the top of the ellipse
		 *
		 * @private
		 * @param  cell  cell object to move
		 */
		public function rotateCellToTop(cell:INode3d):Float
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