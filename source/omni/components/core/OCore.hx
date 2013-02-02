package omni.components.core;

import omni.components.core.signals.OCoreEvent;
import omni.components.core.signals.OSignalMouse;
import nme.system.System;
import omni.components.core.interfaces.IOComponent;
import omni.components.core.signals.OSignal;
//import omni.components.core.signals.OSignal;

import nme.Lib;
import nme.display.Sprite;
import nme.display.Stage;

/**
* Components Core
* @description The Base class for all components created, only one instance can be created
*
**/
class OCore
{

	private function new():Void
	{
		//todo cpp bug paramaters ? 
		#if flash
		haxe.Log.trace = trace;
		#end
	}

	public static var instance(getInstance, null):OCore;

	private static function getInstance():OCore
	{
		if(instance == null)
		{
			instance = new OCore();
		}
		return instance;
	}

	public var stage(get_stage, null):Stage;

	//todo managers
	//	public var timer:TimerManager;
	//	public var inputs:InputManager;
	//	public var enterframe:FlashSignal;
	//	public var onStageDraw:FlashSignal<Event>;
	//	public var onStageResize:FlashSignal<Event>;
	//	public var onStageMouseDown:FlashSignal<MouseEvent>;
	public var onStageMouseMove:OSignalMouse;
	public var onStageMouseLeave:OCoreEvent;
	public var onStageMouseUp:OSignalMouse;

	public var trackTheme:Bool;

	public var onThemeChange:OSignal<Void -> Void>;

	public var defaultTheme:OTheme;

	public function init(theme:Class<OTheme>, trackTheme:Bool = true):Void
	{
		defaultTheme = Type.createInstance(theme, []);
		this.trackTheme = trackTheme;

		onThemeChange = new OSignal();
		onStageMouseMove = new OSignalMouse(OSignalMouse.MOVE, stage);
		onStageMouseUp = new OSignalMouse(OSignalMouse.UP, stage);
		onStageMouseLeave = new OCoreEvent(OCoreEvent.MOUSE_LEAVE, stage);
	}

	public function changeTheme(theme:Class<OTheme>):Void
	{
		defaultTheme.destroy();
		defaultTheme = null;
		defaultTheme = Type.createInstance(theme, []);
		onThemeChange.dispatch();
		System.gc();
	}

	public static function addChild(component:Dynamic):Void
	{
		Lib.current.stage.addChild(component.sprite);
	}

	public function get_stage():Stage
	{
		return Lib.current.stage;
	}

	public static function log(arg:Dynamic, ?info:haxe.PosInfos):Void
	{
		nme.Lib.trace("Log : " + arg);
		nme.Lib.trace("  at " + info.fileName + ":" + info.lineNumber + " in method " + info.methodName);
	}

	public static function error(arg:Dynamic, ?info:haxe.PosInfos):Void
	{
		nme.Lib.trace("[Error : " + arg + "]");
		nme.Lib.trace("  at " + info.fileName + ":" + info.lineNumber + " in method " + info.methodName);
	}

	private static function trace(v : Dynamic, ?infos : haxe.PosInfos)
	{
		nme.Lib.trace(v + infos);
	}

}
