package com.somerandomdude.coordy.proxyupdaters

import com.somerandomdude.coordy.constants.StackOrder;
import com.somerandomdude.coordy.layouts.IOrderedLayout;
import com.somerandomdude.coordy.nodes.twodee.OrderedNode;
import com.somerandomdude.coordy.utils.Utilities;

import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;

class OrderSortProxyUpdater implements IProxyUpdater
{
	public static inline var NAME='orderSortUpdaterProxy';
	
	var _target:DisplayObjectContainer;
	var _layout:IOrderedLayout;
	
	
	/**
	 * Modifies a layout's update method to set the child index of a DisplayObjectContainer's children according
	 * to the order of nodes in the specified layout
	 *
	 * @param target 		DisplayObjectContainer containing the items to stack
	 * @param layout 		The layout containing references to the target's children
	 *
	 */
	public function new(target:DisplayObjectContainer, layout:IOrderedLayout)
	{
		_target=target;
		_layout=layout;
	}
	
	public function update()
	{
		if(_layout.size==null) return;
		_layout.nodes.sort(Utilities.sortOnOrderAscending);
		if(_layout.order==StackOrder.DESCENDING) _layout.nodes.reverse();
		var n:OrderedNode;
		for(j in 0..._layout.size){
			n=_layout.nodes[i];
			if (n.link == null || !Std.is(n.link, DisplayObject)) continue;
			var link:DisplayObject = cast(n.link, DisplayObject);
			_target.setChildIndex(link, i);
		}
	}

}
