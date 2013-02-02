package com.somerandomdude.coordy.proxyupdaters;

import com.somerandomdude.coordy.helpers.SimpleZSorter;
import com.somerandomdude.coordy.layouts.threedee.ILayout3d;

import flash.display.DisplayObjectContainer;
import flash.events.Event;

class InvalidationZSortProxyUpdater implements IProxyUpdater
{
	public static inline var NAME:String = 'invalidationZSortUpdaterProxy';
	public var name(get_name, null):String;
	function get_name() { return NAME; }
	
	private var _target:DisplayObjectContainer;
	private var _layout:ILayout3d;
	
	/**
	 * Performs a potentially more efficent method of rendering items on a stage by using
	 * <em>stage.invalidate()</em> when the specified layout is modified. In addition, elements
	 * are z-sorted after render.
	 *
	 * @param target 		DisplayObjectContainer with reference to the stage
	 * @param layout 		The layout to apply changes to
	 *
	 */
	public function new(target:DisplayObjectContainer, layout:ILayout3d){
		_target=target;
		_target.addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
		_layout=layout;
	}
	
	
	public function update(){
		if(_target.stage==null)
		{
			_layout.update();
			return;
		}
		_target.stage.addEventListener(Event.RENDER, renderHandler);
		_target.stage.invalidate();
	}
	
	private function renderHandler(event:Event):Void{
		_target.stage.removeEventListener(Event.RENDER, renderHandler);
		_layout.updateAndRender();
		SimpleZSorter.sortLayout(_target, _layout);
	}
	
	/**
	 * @private
	 */
	private function addedToStageHandler(event:Event):Void
	{
		update();
	}

}