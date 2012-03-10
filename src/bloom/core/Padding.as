package bloom.core {

import flash.system.System;

import org.osflash.signals.Signal;

/**
 * Margin
 */
public class Padding {

	private var _top:Number;
	private var _left:Number;
	private var _bottom:Number;
	private var _right:Number;

	private var _onResized:Signal;

	public function Padding (top:Number = 0,left:Number = 0,bottom:Number = 0,right:Number = 0) {
		this._top = top;
		this._left = left;
		this._bottom = bottom;
		this._right = right;
	}

	public function reset (top:Number,left:Number,bottom:Number,right:Number):void {
		this._top = top;
		this._left = left;
		this._bottom = bottom;
		this._right = right;
	}

	public function get onResized ():Signal {
		if (_onResized == null) _onResized = new Signal ();
		return _onResized;
	}

	public function get top ():Number {
		return _top;
	}

	public function set top (value:Number):void {
		if (value != _top) {
			_top = value;
			onResized.dispatch ();
		}
	}

	public function get left ():Number {
		return _left;
	}

	public function set left (value:Number):void {
		_left = value;
	}

	public function get bottom ():Number {
		return _bottom;
	}

	public function set bottom (value:Number):void {
		_bottom = value;
	}

	public function get right ():Number {
		return _right;
	}

	public function set right (value:Number):void {
		_right = value;
	}

	public function dispose (gc:Boolean = false):void {
		if (_onResized != null)_onResized.removeAll ();
		_onResized = null;

		if (gc) System.gc ();
	}

	///////////////////////////////////
	// toString
	///////////////////////////////////

	public static function toString ():String {
		return "[bloom.core.Margin]";
	}

}

}
