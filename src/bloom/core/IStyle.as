package bloom.core {

import flash.utils.Dictionary;

/**
 * IStyle
 */
public interface IStyle {

	function drawStyle (state:int,target:*,args:*):void;
	
	function dispose (gc:Boolean = false):void;
	
	function toString ():String;

	function get stateCollection ():Dictionary;
	
}

}
