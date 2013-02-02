package omni.components.core.interfaces;

/**
 * IStyle
 * 
 * @description the main Interface pattern for the Component style system
 *
 */
interface IStyle implements IDestroyable
{
	var defaultWidth:Float;
	var defaultHeight:Float;
	var defaultPadding:Float;
	var defaultState:String;

	var minHeight:Float;
	var maxHeight:Float;

	var minWidth:Float;
	var maxWidth:Float;

	/**
	* 	initStyle
	 * 	
	 * 	@description The post initiate method used to set objects for the components style
	* 	
	**/
	function initStyle (value:IOComponent):Void;

	/**
	* 	update
	 * 	
	 * 	@description The update method used refresh and draw the component based on state etc
	* 	
	**/
	function update (value:IOComponent):Void;

}
