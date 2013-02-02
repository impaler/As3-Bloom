package com.somerandomdude.coordy.layouts;

import com.somerandomdude.coordy.nodes.INode;
import haxe.Json;

#if js
	import com.somerandomdude.coordy.events.helpers.EventDispatcher;
#else
	import flash.events.EventDispatcher;
#end

import Xml;

	@:expose("Coordinates.layouts.Layout")
	class Layout extends EventDispatcher
	{
		
		public var nodes(default,null):Array<Dynamic>;
		public var size(default,null):Int;
		
		
		/**
		 * The most base-level class for all layouts. Cannot be instantiated as is.
		 *
		 */
		function new()
		{
			super();
			size=0;
		}
		
		public override function toString():String { return ""; }
		
		/**
		 * Serializes the layout data of each node as a JSON string. Includes the 'type', 'size' and 'nodes' properties.
		 *
		 * @return JSON representation of the layout's composition
		*/
		public function toJSON():String
		{
			var _nodes:Array<Dynamic> = new Array();
			var layout:Dynamic = cast { };
			
			for (i in 0...size) {
				var _node = nodes[i];
				_nodes.push(Std.string(_node));
			}
			layout.type=toString();
			layout.size=size;
			layout.nodes=nodes;
			//
			return layout;
		}
		
		public function addToLayout(object:Dynamic, moveToCoordinates:Bool=true):INode
		{
			throw 'Method must be overriden by child class';
			return null;
		}
		
		// @TODO fixer le constructeur pour jeash
		public function addNode(object:Dynamic=null,moveToCoordinates:Bool=true):INode
		{
			throw 'Method must be overriden by child class';
			return null;
		}
		
		/**
		 * Adds a specified number of empty nodes to the layout
		 *
		 * @param count The number of nodes to add to the layout
		*/
		public function addNodes(count:Int)
		{
			for(i in 0...count) addNode();
		}
		
		///**
		 //* Adds a specified number of empty nodes to the layout
		 //*
		 //* @param count The number of nodes to add to the layout
		//*/
		//public function addNodes(count:Int):Void
		//{
			//for(var i:Int=0; i<count; i++) addNode();
		//}
		
		/**
		 * Generates XML for the layout's properties.
		 * TODO completer la fonction
		 * @return XML representation of the layout's composition
		*/
		public function toXML():Xml
		{
			var xml:Xml = Xml.parse('<layout></layout>');
			xml.set('type',toString());
			xml.set('size', cast(size,String));
			for(i in 0...size)
			{
				//var node:Xml = Xml.parse('<node />');
				//var obj:Dynamic=nodes[i].toDynamic();
				//for(var j:String in obj)
				//{
					//node[String('@'+j)] = obj[j];
				//}
    			//xml.appendChild(node);
			}
			
			return xml;
		}
		
		/**
		 * Returns node object by specified display object
		 *
		 * @param  link  an absolute URL giving the base location of the image
		 * @return      the node object which the display object is linked to
		 * @see         INode
		 */
		public function getNodeByLink(link:Dynamic):INode
		{
			for( i in 0...nodes.length)
			{
				if(nodes[i].link==link) return this.nodes[i];
			}
			return null;
		}
		
		/**
		 * Returns specified node object's index in the collection
		 *
		 * @param  node  Node object from layout organizer
		 * @return      Index of node object in the collection of nodes
		 * @see         INode
		 */
		public function getNodeIndex(node:INode):Int
		{
			for( i in 0...nodes.length)
			{
				if(this.nodes[i]==node) return i;
			}
			return -1;
		}
		
		/**
		 * Returns node object at specified index of collection
		 *
		 * @param  index  Index of item in the collection of nodes
		 * @return      Node object at the specified location in the collection
		 * @see         Node
		 */
		public function getNodeAt(index:Int):INode
		{
			return nodes[index];
		}
		
		/**
		 * Returns true if a link (DisplayObject owned by a layout's node) exists in the layout
		 *
		 * @param  link  DisplayDynamic in question
		 * @return      True if link exists in layout, false if not.
		 * @see         Node
		 */
		public function linkExists(link:Dynamic):Bool
		{
			for(i in 0...size) if(link==nodes[i].link) return true;
			return false;
		}
		
		/**
		 * Swaps links of two node objects
		 *
		 * @param  nodeTo
		 * @param  nodeFrom
		 */
		public function swapNodeLinks(nodeTo:INode, nodeFrom:INode):Void
		{
			var tmpLink:Dynamic = nodeTo.link;
			nodeTo.link = nodeFrom.link;
			nodeFrom.link = tmpLink;
		}
		
		/**
		 * Removes all links between nodes and display objects
		 *
		 */
		public function removeLinks()
		{
			for(i in 0...nodes.length) nodes[i].link=null;
		}
		
		/**
		 * Removed the link between the node and display object at the specified index
		 *
		 * @param  index  index in collection of item to be removed
		 */
		public function removeLinkAt(index:Int)
		{
			nodes[index].link=null;
		}
		
		/**
		 * Removes specified node object from layout organizer
		 *
		 * @param  node	specified Node object to remove
		 */
		public function removeNode(node:INode):Void
		{
			nodes.splice(getNodeIndex(node), 1);
			this.size--;
		}
		
		/**
		 * Removes all nodes from the layout
		 */
		public function removeAllNodes():Void
		{
			this.clearNodes();
			this.size=0;
		}
		
		/**
		 * Removes the node that is linked to the specified object
		 *
		 * @param link
		 */
		public function removeNodeByLink(link:Dynamic):Void
		{
			for( i in 0...size )
			{
				if(nodes[i].link==link) removeNode(nodes[i]);
			}
		}
		
		/**
		 * Adds a link between the specified display object to the node object at the specified index
		 *
		 * @param  object	item to add to collection
		 * @param  index		position where to add the item
		 */
		public function addLinkAt(object:Dynamic, index:Int):Void
		{
			nodes[index].link=object;
		}
		
		/**
		 * @private
		 */
		private function storeNode(node:INode):Int
		{
			if (nodes == null) this.nodes = new Array<INode>();
			this.nodes.push(node);
			this.size++;
			
			return size;
		}
		

		private function storeNodeAt(node:INode, index:Int):Int
		{
			if(this.nodes==null) this.nodes=new Array<INode>();
			if (index >= 0 && index < this.size) this.nodes.insert(index, node);
			else this.nodes.push(node);
			this.size++;
			
			return size;
		}
		

		private function getNextAvailableNode():INode
		{
			for(i in 0...nodes.length)
			{
				if(nodes[i].link!=null)
				{
					return nodes[i];
				}
			}
			return null;
		}
		
		private function clearNodes():Void
		{
			if (nodes == null) return;
			if(nodes.length>0)
			{
				for( i in 0...nodes.length )
				{
					nodes[i]=null;
					nodes.remove(nodes[i]);
				}
			}
			nodes = new Array<INode>();
		}

	}