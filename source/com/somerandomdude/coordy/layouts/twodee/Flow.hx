package com.somerandomdude.coordy.layouts.twodee;

import com.somerandomdude.coordy.constants.FlowAlignment;
import com.somerandomdude.coordy.constants.FlowDirection;
import com.somerandomdude.coordy.constants.FlowOverflowPolicy;
import com.somerandomdude.coordy.constants.LayoutType;
import com.somerandomdude.coordy.events.CoordyNodeEvent;
import com.somerandomdude.coordy.layouts.twodee.ILayout2d;
import com.somerandomdude.coordy.layouts.twodee.Layout2d;
import com.somerandomdude.coordy.nodes.INode;
import com.somerandomdude.coordy.nodes.twodee.FlowNode;


import flash.display.DisplayObject;

import com.somerandomdude.coordy.geom.Rectangle;

class Flow extends Layout2d ,implements ILayout2d
{
	
	public var horizontalAlign:String;
	
	public var verticalAlign:String;
	
	/** Method in which layout aligns nodes withing the layout's bounds  **/
	public var alignment(get_alignment,set_alignment):String;
  function get_alignment():String { return this.alignment; }
	function set_alignment(value:String):String{
    switch(value)
    {
      case FlowAlignment.TOP_LEFT:
        verticalAlign="top";
        horizontalAlign="left";
      case FlowAlignment.TOP_CENTER:
        verticalAlign="top";
        horizontalAlign="center";
      case FlowAlignment.TOP_RIGHT:
        verticalAlign="top";
        horizontalAlign="right";
      case FlowAlignment.MIDDLE_LEFT:
        verticalAlign="middle";
        horizontalAlign="left";
      case FlowAlignment.MIDDLE_CENTER:
        verticalAlign="middle";
        horizontalAlign="center";
      case FlowAlignment.MIDDLE_RIGHT:
        verticalAlign="middle";
        horizontalAlign="right";
      case FlowAlignment.BOTTOM_LEFT:
        verticalAlign="bottom";
        horizontalAlign="left";
      case FlowAlignment.BOTTOM_CENTER:
        verticalAlign="bottom";
        horizontalAlign="center";
      case FlowAlignment.BOTTOM_RIGHT:
        verticalAlign="bottom";
        horizontalAlign="right";
      default:
        verticalAlign="top";
        horizontalAlign="left";
        value=FlowAlignment.TOP_LEFT;
    }
    this.alignment=value;
    updateFunction();
		return this.alignment;
  }

  /**Direction in which the layout places nodes (horizontal or vertical)**/
  public var placementDirection(get_placementDirection,set_placementDirection):String;
  function get_placementDirection():String { if (placementDirection == null) placementDirection = FlowDirection.HORIZONTAL; return placementDirection; }
  function set_placementDirection(value:String):String{ this.placementDirection=value; updateFunction(); return placementDirection; }

  /**The method in which the layout handles nodes that do not fit within the bounds of the layout**/
  public var overflowPolicy(get_overflowPolicy,set_overflowPolicy):String;
  function get_overflowPolicy():String { if (overflowPolicy == null) overflowPolicy == FlowOverflowPolicy.ALLOW_OVERFLOW ; return overflowPolicy; }
  function set_overflowPolicy(policy:String):String{ overflowPolicy=policy; if (size > 0) updateFunction(); return overflowPolicy;}

  public var paddingX(get_paddingX, set_paddingX):Int;
  function get_paddingX():Int { return paddingX; }
  function set_paddingX(value:Int):Int { paddingX = value; updateFunction(); return paddingX; }

	public var paddingY(get_paddingY, set_paddingY):Int;
  function get_paddingY():Int { return paddingY; }
  function set_paddingY(value:Int):Int { paddingY = value; updateFunction(); return paddingY; }



  /**
   * Distributes nodes in a flow layout.
   *
   * @param width			Width of the flow layout
   * @param height		Height of the flow layout
   * @param hPadding		Horizontal padding of all nodes in the layout
   * @param vPadding		Vertical padding of all nodes in the layout
   * @param x				x position of the flow layout
   * @param y				y position of the flow layout
   *
   */
  public function new(width:Float, height:Float, hPadding:Int = 0, vPadding:Int = 0, x:Float = 0, y:Float = 0) {
		super();
    this.width=width;
    this.height=height;
    this.paddingX=hPadding;
    this.paddingY=vPadding;
    this.x=x;
    this.y=y;
    this.nodes = new Array<Dynamic>();
  }

  /**
   * Returns the type of layout in a string format
   *
   * @see com.somerandomdude.coordy.layouts.LayoutType
   * @return Layout's type
   *
   */
  override public function toString():String { return LayoutType.FLOW; }

  /** Adds object to layout in next available position.
   * @param  object  Object to add to layout
   * @param  moveToCoordinates  automatically move DisplayObject to corresponding nodes's coordinates
   *
   * @return newly created node object containing a link to the object
   */
  override public function addNode(object:Dynamic=null, moveToCoordinates:Bool=true):INode
  {
		if (object!=null && !validateObject(object)) throw 'Object does not implement at least one of the following properties: "x", "y", "width", "height", "rotation", "getBounds()"';
		if (object !=null && linkExists(object)) return null;
		var node:FlowNode = new FlowNode();
		node.link = object;
		storeNode(node);
		update();
		if (moveToCoordinates) this.render();
		dispatchEvent(new CoordyNodeEvent(CoordyNodeEvent.ADD, node));
		return node;
  }

  /**Clones the current object's properties (does not include links to DisplayObjects)**/
  override public function clone():ILayout2d{
    return new Flow(width, height, paddingX, paddingY,x, y);
  }

  /** Updates the nodes' virtual coordinates. <strong>Note</strong> - this method does not update the actual objects linked to the layout. **/
  override public function update(){
    this.placementDirection == FlowDirection.HORIZONTAL? this.layoutChildrenHorizontally(new Rectangle(x, y, width, height)) : this.layoutChildrenVertically( new Rectangle(x, y, width, height));
		
		if (overflowPolicy == FlowOverflowPolicy.HIDE_OVERFLOW) {
			for (i in 0...size) {
				var c:FlowNode = nodes[i];
			}
		}


  }

  function layoutChildrenHorizontally(bounds:Rectangle){
    var START_X:Float = bounds.x + 0;
    var yPosition:Float = bounds.y + 0;
    var xPosition:Float = START_X;
    var maxChildHeight:Float = 0;
    var row = [];

    for(i in 0...size)
    {
      var cell:FlowNode = this.nodes[i];
      if (nodes[i].link == null) continue;
      var child:DisplayObject = this.nodes[i].link;
	  
	  var bb:nme.geom.Rectangle;
			
      bb = child.getBounds(child);
		

      bb.x*=child.width/bb.width;
      bb.y*=child.height/bb.height;

      //next column if we're over the height, but not if we're at yposition == bounds.y
      var endOfRow = xPosition + child.width + 0;
      if(endOfRow - bounds.x >= bounds.width && xPosition != START_X)
      {
        //update alignment
        this.alignRow(row, maxChildHeight, bounds);

        yPosition += maxChildHeight + this.paddingY;
        xPosition = START_X;
        maxChildHeight = 0;
        row = [];
      }

      cell.outsideBounds=(yPosition+child.height>bounds.height)?true:false;

      cell.x = xPosition-bb.x;
      cell.y = yPosition-bb.y;
      row.push(cell);
      maxChildHeight = Math.max(maxChildHeight, child.height);
      xPosition += child.width + this.paddingX;
    }
    this.alignRow(row, maxChildHeight, bounds);
  }

  override dynamic function validateObject(object:Dynamic):Bool
  {
		#if (js && jeash)
			if (!Std.is(object, DisplayObject)) return false;
		#else
			var fields = ['x', 'y', 'width', 'height', 'rotation', 'getBounds'];
			for (field in fields) {
				if (! Reflect.hasField(object, field)) return false;
			}
		#end
    return true;
  }


  function layoutChildrenVertically(bounds:Rectangle){
    var START_Y:Float = bounds.y + 0;
    var xPosition:Float = bounds.x + 0;
    var yPosition:Float = START_Y;
    var maxChildWidth:Float = 0;
    var column = [];

    for(i in 0...size)
    {
      var cell:FlowNode = this.nodes[i];
      if(nodes[i].link==null) continue;
      var child:Dynamic = this.nodes[i].link;
      var bb:Rectangle = child.getBounds(child);

      bb.x*=child.width/bb.width;
      bb.y*=child.height/bb.height;

      var endOfColumn:Int = yPosition + child.height + 0;
      if(endOfColumn - bounds.y >= bounds.height && yPosition != START_Y)
      {
        this.alignColumn(column, maxChildWidth, bounds);

        xPosition += maxChildWidth + paddingX;

        yPosition = START_Y;
        maxChildWidth = 0;
        column = [];
      }

      cell.outsideBounds=(xPosition+child.width>bounds.width)?true:false;

      cell.x = xPosition-bb.x;
      cell.y = yPosition-bb.y;
      column.push(cell);
      maxChildWidth = Math.max(maxChildWidth, child.width);
      yPosition += child.height + paddingY;
    }
    this.alignColumn(column, maxChildWidth, bounds);
  }

  function alignColumn(column:Array<Dynamic>, maxChildWidth:Float, bounds:Rectangle){
    if(column.length == 0) return;

    var lastChild:FlowNode = column[column.length - 1];
    var columnHeight:Float = (lastChild.y + lastChild.link.height) - bounds.y + /*this.paddingBottom*/0;
    var difference:Float = bounds.height - columnHeight;

    var columnCount:Int = column.length;
    for(i in 0...columnCount)
    {
      var child:FlowNode = column[i];

      this.alignItems(child, new Rectangle(child.x, child.y, maxChildWidth, child.link.height), this.horizontalAlign, null);


      switch(this.verticalAlign)
      {
        case "middle":
          child.y += difference / 2;
          break;
        case "bottom":
          child.y += difference;
          break;
      }

    }
  }

  /**
   * @private
   * @param row
   * @param maxChildHeight
   * @param bounds
   *
   */
  function alignRow(row:Array<FlowNode>, maxChildHeight:Float, bounds:Rectangle){
    if(row.length == 0) return;

    var lastChild:FlowNode = row[row.length - 1];
    var rowWidth = (lastChild.x + lastChild.link.width) - bounds.x + /*this.paddingRight*/0;
    var difference = bounds.width - rowWidth;

    var rowCount = row.length;
    for(i in 0...rowCount)
    {
      var child:FlowNode = row[i];
      this.alignItems(child, new Rectangle(child.x, child.y, child.link.width, maxChildHeight), null, this.verticalAlign);

      switch(this.horizontalAlign)
      {
        case "center":
          child.x += difference / 2;
        case "right":
          child.x += difference;
      }
    }
  }

  /**
   *
   * @param	target
   * @param	bounds
   * @param	horizontalAlign
   * @param	verticalAlign
   */
  function alignItems(target:FlowNode, bounds:Rectangle, horizontalAlign:String = null, verticalAlign:String = null){

    var horizontalDifference= bounds.width - target.link.width;
    switch(horizontalAlign) {
      case "left":
        target.x = bounds.x;
      case "center":
        target.x = bounds.x + horizontalDifference / 2;
      case "right":
        target.x = bounds.x + horizontalDifference;
    }

    var verticalDifference = bounds.height - target.link.height;
    switch(verticalAlign)
    {
      case "top":
        target.y = bounds.y;
      case "middle":
        target.y = bounds.y + (verticalDifference) / 2;
      case "bottom":
        target.y = bounds.y + verticalDifference;
    }
  }

}
