package bloom.core {

import flash.display.DisplayObjectContainer;
import flash.events.MouseEvent;

import org.osflash.signals.natives.NativeSignal;

/**
 * InteractiveComponent
 */
public class InteractiveComponent extends Component {

	private var _mouseDown:NativeSignal;
	private var _mouseOver:NativeSignal;
	private var _mouseOut:NativeSignal;
	private var _mouseClick:NativeSignal;
	protected var _state:int = 0;

	public function InteractiveComponent (p:DisplayObjectContainer = null) {
		super (p);
	}

	override public function dispose (gc:Boolean = false):void {
		if (_mouseOver != null) _mouseOver.removeAll ();
		_mouseOver = null;

		if (_mouseDown != null) _mouseDown.removeAll ();
		_mouseDown = null;

		if (_mouseOut != null) _mouseOut.removeAll ();
		_mouseOut = null;

		if (_mouseClick != null) _mouseClick.removeAll ();
		_mouseClick = null;
	}

	///////////////////////////////////
	// getter/setters
	///////////////////////////////////

	public function get mouseDown ():NativeSignal {
		if (_mouseDown == null) _mouseDown = new NativeSignal (this,MouseEvent.MOUSE_DOWN,MouseEvent);
		return _mouseDown;
	}

	public function get mouseOver ():NativeSignal {
		if (_mouseOver == null) _mouseOver = new NativeSignal (this,MouseEvent.MOUSE_OVER,MouseEvent);
		return _mouseOver;
	}

	public function get mouseOut ():NativeSignal {
		if (_mouseOut == null) _mouseOut = new NativeSignal (this,MouseEvent.MOUSE_OUT,MouseEvent);
		return _mouseOut;
	}

	public function get mouseClick ():NativeSignal {
		if (_mouseClick == null) _mouseClick = new NativeSignal (this,MouseEvent.CLICK,MouseEvent);
		return _mouseClick;
	}

	public function set mouseDown (value:NativeSignal):void {
		_mouseDown = value;
	}

	public function set mouseOver (value:NativeSignal):void {
		_mouseOver = value;
	}

	public function set mouseOut (value:NativeSignal):void {
		_mouseOut = value;
	}

	public function set mouseClick (value:NativeSignal):void {
		_mouseClick = value;
	}

	///////////////////////////////////
	// toString
	///////////////////////////////////

	override public function toString ():String {
		return "[bloom.core.InteractiveComponent]";
	}

}

}
