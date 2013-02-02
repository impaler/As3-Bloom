package omni.components.core;

import omni.components.core.interfaces.IStyle;
import omni.components.core.signals.OSignalMouse;
import omni.components.core.signals.OCoreEvent;
import omni.components.style.OBaseStyle;
import omni.components.core.OCore;

import nme.events.Event;
import nme.events.MouseEvent;

/**
* OButtonBase
* 
* @description A Generic Button Component intended to be extended upon
*
*/
class OButtonBase extends OComponent
{
	public var mouseOut:OSignalMouse;
	public var mouseDown:OSignalMouse;
	public var mouseOver:OSignalMouse;
	public var mouseUp:OSignalMouse;

	public var mouseLeave:OCoreEvent;

	private var _isOver:Bool = false;
	private var _isDown:Bool = false;
	private var _listening:Bool = false;

	override public function createMembers():Void
	{
		buttonMode = true;

		mouseOut = new OSignalMouse(OSignalMouse.OUT, this.sprite);
		mouseOver = new OSignalMouse(OSignalMouse.OVER, this.sprite);
		mouseDown = new OSignalMouse(OSignalMouse.DOWN, this.sprite);
		mouseUp = OCore.instance.onStageMouseUp;
		mouseLeave = OCore.instance.onStageMouseLeave;
	}

	override public function enableSignals():Void
	{
		if(! _listening)
		{
			mouseOut.add(onMouseOut);
			mouseOver.add(onMouseOver);
			mouseDown.add(onMouseDown);
			mouseUp.add(onMouseUp);

			_listening = true;
		}
	}

	override public function disableSignals():Void
	{
		if(_listening)
		{
			mouseOut.remove(onMouseOut);
			mouseOver.remove(onMouseOver);
			mouseDown.remove(onMouseDown);
			mouseUp.remove(onMouseUp);

			mouseLeave.remove(onLeftStage);

			_listening = false;
		}
	}

	public function onMouseOver(?e:Dynamic):Void
	{
		_isOver = true;
		_isDown ? state = OBaseStyle.STATE_ACTIVE : state = OButtonBaseStyle.STATE_OVER;
	}

	public function onMouseDown(?e:Dynamic):Void
	{
		_isDown = true;
		state = OButtonBaseStyle.STATE_DOWN;

		mouseLeave.add(onLeftStage);

		mouseOver.remove(onMouseOver);
		mouseDown.remove(onMouseDown);
	}

	public function onMouseUp(?e:Dynamic):Void
	{
		mouseOver.add(onMouseOver);
		mouseDown.add(onMouseDown);

		_isDown = false;
		_isOver ? state = OButtonBaseStyle.STATE_OVER : state = OBaseStyle.STATE_ACTIVE;
	}

	public function onMouseOut(?e:Dynamic):Void
	{
		_isOver = false;

		if(_isDown == false)
			state = OBaseStyle.STATE_ACTIVE;
	}

	public function onLeftStage(e:OCoreEvent):Void
	{
		_isDown = false;
		state = OBaseStyle.STATE_ACTIVE;
	}

	override public function destroy():Void
	{
		mouseOut.destroy();
		mouseOver.destroy();
		mouseDown.destroy();

		mouseUp.remove(onMouseUp);
		super.destroy();
	}

	override public function getStyleId():String
	{
		return OButtonBaseStyle.styleString;
	}
}

import omni.components.style.OBackgroundStyle;

/**
* OButtonBaseStyle
*/
class OButtonBaseStyle extends OBackgroundStyle
{
	public static var styleString:String = "OButtonBaseStyle";

	public static var STATE_OVER:String = "STATE_OVER";
	public static var STATE_DOWN:String = "STATE_DOWN";

	public function new()
	{
		super();
		styleID = styleString;
	}
}