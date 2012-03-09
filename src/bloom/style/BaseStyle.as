package bloom.style {

import bloom.core.IStyle;

import flash.system.System;
import flash.utils.Dictionary;

/**
 * BaseStyle
 */
public class BaseStyle implements IStyle {

	private var _stateCollection:Dictionary;

	public function BaseStyle () {
		_stateCollection = new Dictionary (true);
	}

	public function drawStyle (state:int,target:*,args:*):void {

	}

	public function dispose (gc:Boolean = false):void {
		_stateCollection = null;
		if (gc) System.gc ();
	}

	public function get stateCollection ():Dictionary {
		return _stateCollection;
	}

	///////////////////////////////////
	// toString
	///////////////////////////////////
	
	public function toString ():String {
		return "[bloom.styles.BaseStyle]";
	}

}
}
