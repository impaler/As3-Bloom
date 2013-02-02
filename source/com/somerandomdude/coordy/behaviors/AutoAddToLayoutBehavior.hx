/**
 * @author P.J. Onori
 * ported to Haxe by M.Paraiso
 * mparaiso@online.fr
 * @version 0.1
 *
 * @url http://somerandomdude.com/
 * @url https://github.com/Mparaiso/coordy.hx
 */

package com.somerandomdude.coordy.behaviors;
import com.somerandomdude.coordy.layouts.ILayout;
import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.events.Event;

class AutoAddToLayoutBehavior
{

	var target(default, default):DisplayObjectContainer;
	var layout(default, default):ILayout;
	
	/**
	 * Allows for DisplayObjects to be automatically added/removed
	 * from a layout when they are added/removed
	 * from a DisplayObjectContainer's display list.
	 */
	
	public function new(target:DisplayObjectContainer, layout:ILayout) {
		this.target = target;
		this.layout = layout;
		this.target.addEventListener(Event.ADDED, addedHandler);
		this.target.addEventListener(Event.REMOVED, removeHandler);
	}
	
	private function addedHandler(e:Event):Void
	{
		if (cast(e.target,DisplayObject).parent != target) return;
		for (i in 0...layout.size) if (e.target == layout.nodes[i].link) return;
		layout.addNode(e.target, false);
		layout.executeUpdateMethod();
		trace(layout.size);

	}
	
	private function removeHandler(e:Event):Void
	{
		if (cast(e.target,DisplayObject).parent != target) return;
		layout.removeNodeByLink(e.target);
		layout.executeUpdateMethod();
	}
}