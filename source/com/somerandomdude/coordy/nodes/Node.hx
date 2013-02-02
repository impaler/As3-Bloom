package com.somerandomdude.coordy.nodes;

class Node implements INode {
	
	public function new(link:Dynamic) {
		this.link = link;
	}
	
	public var link(get_link, set_link):Dynamic;
	function get_link():Dynamic { return link;}
	function set_link(value:Dynamic):Dynamic{return link=value;}
	/**
	 * Packages the node as a generic object - mainly used for exporting layout data.
	 *
	 * @return Generic object containing all the node's layout properties
	*/
	public function toObject():Dynamic
	{
		throw ('Method must be called in Node descendant');
		return null;
	}
}