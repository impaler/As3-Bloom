package bloom.core {

import bloom.style.ComponentBaseStyle;

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
	protected var _customStyle:Boolean = false;
	protected var _customStyleAuto:Boolean = true;

	protected var _state:int;
	protected var _width:Number = 0;
	protected var _height:Number = 0;

	protected var _style:ComponentBaseStyle;
	protected var _onResized:Signal;
	protected var _padding:Padding;

	public function Component (p:DisplayObjectContainer = null) {
		super ();

		visible = false;

		var temp:NativeSignal = new NativeSignal (this,Event.ADDED_TO_STAGE,Event);
		temp.addOnce (onAddedToStage);

		if (p) p.addChild (this);

		createAssets ();
		onThemeChanged ();
		initDefaultStyle ();
		enableSignals ();

		if (OmniCore.monitorThemeChange)
			OmniCore.onDefaultThemeChanged.add (onThemeChanged);
	}

	protected function createAssets ():void {

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
		if (_style) {
			_changed = true;
			invalidate ();
		}
	}

	public function initDefaultStyle ():void {
		_state = ComponentConstants.ACTIVE;
		size (_style.defaultWidth,_style.defaultHeight);
	}

	protected function draw (e:Event = null):void {

	}

	/**
	 * This invalidates the stage with ThemeBase.onStageDraw being called to draw the component
	 */
	protected static function invalidate ():void {
		if (OmniCore.stage) OmniCore.stage.invalidate ();
	}

	public function onAddedToStage (e:Event):void {
		OmniCore.onStageDraw.add (draw);
		invalidate ();
		visible = true;
	}

	public function onMarginChanged ():void {
		if (_padding) {
			_changed = true;
			invalidate ();
		}
	}

	public function enableSignals ():void {
	}

	public function disableSignals ():void {
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

			if (_enabled) {
				_state = ComponentConstants.ACTIVE;
				enableSignals ();
			} else {
				_state = ComponentConstants.DISABLED;
				disableSignals ();
			}
			_changed = true;
			invalidate ();
		}
	}

	public function get enabled ():Boolean {
		return _enabled;
	}

	public function get style ():ComponentBaseStyle {
		return _style;
	}

	public function set style (value:ComponentBaseStyle):void {
		if (_style != value) {
			_style = value;
			_changed = true;
			invalidate ();
			if (_customStyleAuto) _customStyle = true;
			if (OmniCore.monitorThemeChange)
				OmniCore.onDefaultThemeChanged.remove (onThemeChanged);
		}
	}

	public function set styleInternal (value:ComponentBaseStyle):void {
		if (_style != value) {
			_style = value;
			invalidate ();
		}
	}

	public function get padding ():Padding {
		if (_padding == null) {
			_padding = new Padding ();
			_padding.onResized.add (onMarginChanged);
		}
		return _padding;
	}

	public function set padding (value:Padding):void {
		if (value != _padding) {
			_padding = value;
			onMarginChanged ();
		}
	}

	public function get getDimensionObject ():Object {
		var dimensions:Object = new Object ();
		dimensions.x = this.x;
		dimensions.y = this.y;
		dimensions.width = this.width;
		dimensions.height = this.height;
		return dimensions;
	}

	public function get customStyle ():Boolean {
		return _customStyle;
	}

	public function set customStyle (value:Boolean):void {
		_customStyle = value;
	}

	public function get customStyleAuto ():Boolean {
		return _customStyleAuto;
	}

	public function set customStyleAuto (value:Boolean):void {
		_customStyleAuto = value;
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
		trace ("dispose");

		if (parent) parent.removeChild (this);

		if (_onResized != null)_onResized.removeAll ();
		_onResized = null;
		if (OmniCore.monitorThemeChange)
			OmniCore.onDefaultThemeChanged.remove (onThemeChanged);

		OmniCore.onStageDraw.remove (draw);

		if (_padding != null) _padding.dispose ();
		_padding = null;

		if (gc) System.gc ();
	}

}

}
