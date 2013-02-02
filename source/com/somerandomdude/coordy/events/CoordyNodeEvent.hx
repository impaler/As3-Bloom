package com.somerandomdude.coordy.events;

#if js
	import com.somerandomdude.coordy.events.helpers.Event;
#else
	import flash.events.Event;
#end


import com.somerandomdude.coordy.nodes.INode;

class CoordyNodeEvent extends Event
{

	public static inline var ADD:String='coordyNodeAdd';
	public static inline var REMOVE:String = 'coordyNodeRemove';
	
	public var node(default,null):INode;
	
	public function new(type:String,node:INode,bubbles:Bool=false,cancelable:Bool=false)
	{
		this.node = node;
		super(type, bubbles, cancelable);
	}
	
	override public function clone():Event {
		return new CoordyNodeEvent(type, node, bubbles, cancelable);
	}
	
}