package bloom.core {

import flash.display.DisplayObjectContainer;
import flash.display.Sprite;
import flash.events.Event;
import flash.system.System;

import org.osflash.signals.Signal;
import org.osflash.signals.natives.NativeSignal;

/**
 * Component
 */
public class Component extends Sprite implements IComponent {

	protected var _enabled:Boolean = true;
	protected var _changed:Boolean = false;

	private var _onResized:Signal;

	protected var _width:Number = 0;
	protected var _height:Number = 0;

	protected var _style:IStyle;

	protected var _margin:Margin;

	public function Component (p:DisplayObjectContainer = null) {
		super ();
		alpha = 0;

		var temp:NativeSignal = new NativeSignal (this,Event.ADDED_TO_STAGE,Event);
		temp.addOnce (onAddedToStage);

		_margin = new Margin ();
		if (p) p.addChild (this);

		OmniCore.onThemeChanged.add (onThemeChanged);
	}

	public function move (x:Number,y:Number):void {
		this.x = x;
		this.y = y;
	}

	public function size (width:Number,height:Number):void {
		this.width = width;
		this.height = height;
	}

	public function drawDirectly ():void {
		_changed = true;
		draw (null);
	}

	protected function onThemeChanged ():void {

	}

	protected function draw (e:Event = null):void {

	}

	/**
	 * This invalidates the stage with ThemeBase.onStageDraw being called to draw the component
	 */
	protected static function invalidate ():void {
		if (OmniCore.stage) OmniCore.stage.invalidate ();
	}

	private function onAddedToStage (e:Event):void {
		OmniCore.onStageDraw.add (draw);
		invalidate ();
		alpha = 1;
	}

	///////////////////////////////////
	// getter/setters
	///////////////////////////////////

	override public function set width (value:Number):void {
		if (_width != value) {
			_width = value;
			_changed = true;
			invalidate ();
			onResized.dispatch ();
		}
	}

	override public function get width ():Number {
		return _width;
	}

	override public function set height (value:Number):void {
		if (_height != value) {
			_height = value;
			_changed = true;
			invalidate ();
			onResized.dispatch ();
		}
	}

	override public function get height ():Number {
		return _height;
	}

	public function get onResized ():Signal {
		if (_onResized == null) _onResized = new Signal ();
		return _onResized;
	}

	public function set enabled (value:Boolean):void {
		if (_enabled != value) {
			_enabled = mouseEnabled = mouseChildren = value;
//			alpha = _enabled ? 1 : ThemeBase.theme.alpha;
		}
	}

	public function get enabled ():Boolean {
		return _enabled;
	}

	public function get style ():IStyle {
		return _style;
	}

	public function set style (value:IStyle):void {
		if (_style != value) {
			_style = value;
			if (_style) {
				_changed = true;
				invalidate ();
			}
		}
	}

	public function get margin ():Margin {
		return _margin;
	}

	public function get getDimensionObject ():Object {
		var dimensions:Object = new Object ();
		dimensions.x = this.x;
		dimensions.y = this.y;
		dimensions.width = this.width;
		dimensions.height = this.height;
		return dimensions;
	}

	///////////////////////////////////
	// toString
	///////////////////////////////////

	override public function toString ():String {
		return "[bloom.core.Component]";
	}

	///////////////////////////////////
	// Dispose
	///////////////////////////////////

	public function dispose (gc:Boolean = false):void {
		if (_onResized != null)_onResized.removeAll ();
		_onResized = null;
		OmniCore.onThemeChanged.remove (onThemeChanged);
		OmniCore.onStageDraw.remove (draw);

		if (parent) parent.removeChild (this);

		_style = null;
		_margin = null;

		if (gc) System.gc ();
	}

}

}
