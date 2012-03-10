package bloom.core {

import flash.display.DisplayObjectContainer;
import flash.events.FocusEvent;
import flash.events.MouseEvent;

import org.osflash.signals.natives.NativeSignal;

/**
 * InteractiveComponent
 */
public class InteractiveComponent extends Component {

	protected var _mouseDown:NativeSignal;
	protected var _mouseOver:NativeSignal;
	protected var _mouseOut:NativeSignal;
	protected var _mouseClick:NativeSignal;
	protected var _onFocusedIn:NativeSignal;
	protected var _onFocusedOut:NativeSignal;

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

		super.dispose (gc);
	}

	///////////////////////////////////
	// getter/setters
	///////////////////////////////////

	public function get onFocusedIn ():NativeSignal {
		if (! _onFocusedIn)_onFocusedIn = new NativeSignal (this,FocusEvent.FOCUS_IN,FocusEvent);
		return _onFocusedIn;
	}

	public function get onFocusedOut ():NativeSignal {
		if (! _onFocusedOut)_onFocusedOut = new NativeSignal (this,FocusEvent.FOCUS_OUT,FocusEvent);
		return _onFocusedOut;
	}

	public function get mouseDown ():NativeSignal {
		if (! _mouseDown) _mouseDown = new NativeSignal (this,MouseEvent.MOUSE_DOWN,MouseEvent);
		return _mouseDown;
	}

	public function get mouseOver ():NativeSignal {
		if (! _mouseOver) _mouseOver = new NativeSignal (this,MouseEvent.MOUSE_OVER,MouseEvent);
		return _mouseOver;
	}

	public function get mouseOut ():NativeSignal {
		if (! _mouseOut) _mouseOut = new NativeSignal (this,MouseEvent.MOUSE_OUT,MouseEvent);
		return _mouseOut;
	}

	public function get mouseClick ():NativeSignal {
		if (! _mouseClick) _mouseClick = new NativeSignal (this,MouseEvent.CLICK,MouseEvent);
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

	public function get mouseUp ():NativeSignal {
		return OmniCore.onStageMouseUp;
	}

	public function get mouseLeave ():NativeSignal {
		return OmniCore.onStageMouseLeave;
	}

	///////////////////////////////////
	// toString
	///////////////////////////////////

	override public function toString ():String {
		return "[bloom.core.InteractiveComponent]";
	}

}

}
