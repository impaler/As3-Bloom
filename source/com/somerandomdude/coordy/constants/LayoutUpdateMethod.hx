package com.somerandomdude.coordy.constants;

@:expose
class LayoutUpdateMethod
{

	/**
	 * No update or render occurs when layout properties are changed. The layout's <em>updateAndRender()</em>
	 * must be called for updating/rendering to occur.
	 */
	public static inline var NONE:String="none";
	
	/**
	 * The layout's <em>update()</em> method is called when layout properties are changed - which only updates
	 * each node's virtual coordinates, but not the actual DisplayObjects' coordinates.
	 */
	public static inline var UPDATE_ONLY:String="updateOnly";
	
	/**
	 * The layout is updated and rendered whenever a property is changed
	 */
	public static inline var UPDATE_AND_RENDER:String="updateAndRender";
	
}