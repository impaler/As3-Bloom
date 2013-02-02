package omni.components.core.interfaces;

import nme.display.Sprite;

/**
*   IBrush
*   
*   @description the interface to draw a component visually
*
**/
interface IBrush implements IDestroyable
{

	function update(target:IOComponent):Void;

}

