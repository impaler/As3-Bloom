package com.somerandomdude.coordy.nodes.twodee;

/**
 * ...
 * @author marc paraiso
 */

class GridNode extends Node2d,implements INode2d
{


		public var row(default,default):Int;
		public var column(default,default):Int;
		
		/**
		 * Node used for Grid layout
		 *
		 * @see com.somerandomdude.coordy.layouts.twodee.Grid
		 *
		 * @param link 			The node's target object
		 * @param column 		Column in the grid in which the node resides
		 * @param row			Row in the grid in which the node resides
		 * @param x 			Node's x position
		 * @param y 			Node's y position
		 * @param jitterX 		Node's x-jitter value
		 * @param jitterY 		Node's y-jitter value
		 *
		 */
		public function new(link:Dynamic=null, column:Int=-1, row:Int=-1, x:Float=0, y:Float=0, jitterX:Float=0, jitterY:Float=0)
		{
			super(link, x, y, jitterX, jitterY);
			this.row=row;
			this.column=column;
		}
		
		/**
		 * Creates an exact copy of node with link and position properties carried over
		 *
		 * @return Cloned node
		 *
		 */
		override public function clone():INode2d {
			return new GridNode(link, column, row, x, y, jitterX, jitterY);
		}
	
		/**
		 * Packages the node as a generic object - mainly used for exporting layout data.
		 *
		 * @return Generic object containing all the node's layout properties
		*/
		override public function toObject():Dynamic
		{
			return {row:row, column:column, x:x, y:y, rotation:rotation};
		}
}