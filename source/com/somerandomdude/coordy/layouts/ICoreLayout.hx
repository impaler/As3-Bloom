package com.somerandomdude.coordy.layouts;

import com.somerandomdude.coordy.nodes.INode;

interface ICoreLayout {
	
	public var nodes(default,null):Array<Dynamic>;
	public var size(default,null):Int;
	
	function addNodes(count:Int):Void;
	function addNode(object:Dynamic=null, moveToCoordinates:Bool=true):INode;
	function addToLayout(object:Dynamic, moveToCoordinates:Bool=true):INode;
	function getNodeByLink(link:Dynamic):INode;
	function getNodeIndex(node:INode):Int;
	function getNodeAt(index:Int):INode;
	function addLinkAt(object:Dynamic, index:Int):Void;
	function removeLinks():Void;
	function removeLinkAt(index:Int):Void;
	function removeNode(node:INode):Void;
	function removeNodeByLink(object:Dynamic):Void;
	function swapNodeLinks(nodeTo:INode, nodeFrom:INode):Void;
	
	function updateAndRender():Void;
	function update():Void;
	dynamic function render():Void;
	
	function toString():String;
	function toJSON():String;
	function toXML():Xml;
}