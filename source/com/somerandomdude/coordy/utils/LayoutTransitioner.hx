package com.somerandomdude.coordy.utils;

import com.somerandomdude.coordy.layouts.ICoreLayout;
import com.somerandomdude.coordy.layouts.twodee.ILayout2d;
import com.somerandomdude.coordy.nodes.INode;

@:expose("Coordinates.utils.LayoutTransitioner")
@:keep
class LayoutTransitioner implements ILayoutTransitioner
{
	public var layout(default, default):ICoreLayout;

	public function new(layout:ICoreLayout,tweenFunction:Dynamic=null) {
		this.layout = layout;
		this.tweenFunction = tweenFunction;
	}
	
	dynamic public function tweenFunction(node:INode){}
	
	/**
	 *
	 * @param	layout
	 */
	public function syncNodesTo(l:ICoreLayout=null):Void
	{
		if (l != null) layout = l;
		if (tweenFunction==null){
			layout.updateAndRender();
			return;
		}
		for (i in 0...layout.size) {
			tweenFunction(layout.nodes[i]);
		}
	}
	
	
}