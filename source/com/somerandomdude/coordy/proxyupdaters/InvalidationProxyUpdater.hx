package com.somerandomdude.coordy.proxyupdaters

import com.somerandomdude.coordy.layouts.ILayout;

import flash.display.DisplayObjectContainer;
import flash.events.Event;

public class InvalidationProxyUpdater implements IProxyUpdater
{
	public static inline var NAME='invalidationUpdaterProxy';
	var _target:DisplayObjectContainer;
	var _layout:ILayout;
	public var name(get_name, null):String;
	function get_name() { return NAME;}
	
	/**
	 * Performs a potentially more efficent method of rendering items on a stage by using
	 * <em>stage.invalidate()</em> when the specified layout is modified.
	 *
	 * @param target 		DisplayObjectContainer with reference to the stage
	 * @param layout 		The layout to apply changes to
	 *
	 */
	public function new(target:DisplayObjectContainer, layout:ILayout)
	{
		_target=target;
		_target.addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
		_layout=layout;
		
		_layout.proxyUpdater=this;
	}
	
	
	public function update()
	{
		if(_target.stage==null)
		{
			_layout.update();
			return;
		}
		_target.stage.addEventListener(Event.RENDER, renderHandler);
		_target.stage.invalidate();
	}
	
  function renderHandler(event:Event)
	{
		_target.stage.removeEventListener(Event.RENDER, renderHandler);
		_layout.updateAndRender();
	}
	
  function addedToStageHandler(event:Event)
	{
		update();
	}

}