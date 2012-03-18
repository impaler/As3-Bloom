package bloom.core {

import bloom.components.style.components.ComponentBaseStyle;

import flash.display.DisplayObjectContainer;
import flash.display.Sprite;
import flash.events.Event;
import flash.system.System;

import org.osflash.signals.Signal;
import org.osflash.signals.natives.NativeSignal;

/**
 * Component
 *
 * @description Provides the basic design pattern for all Components
 *
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

		if (p) p.addChild (this);

		createAssets ();
		onStyleChanged ();
		initDefaultStyle ();
		enableSignals ();

		if (OmniCore.monitorThemeChange)
			OmniCore.onDefaultThemeChanged.add (onStyleChanged);
	}

	///////////////////////////////////
	// Base Component Methods
	///////////////////////////////////

	protected function createAssets ():void {
		var temp:NativeSignal = new NativeSignal (this,Event.ADDED_TO_STAGE,Event);
		temp.addOnce (onAddedToStage);
	}

	protected function onStyleChanged ():void {
		if (_style) {
			_changed = true;
			invalidate ();
		}
	}

	protected function initDefaultStyle ():void {
		_state = ComponentConstants.ACTIVE;
		size (_style.defaultWidth,_style.defaultHeight);
	}

	///////////////////////////////////
	// Draw Methods
	///////////////////////////////////

	protected function draw (e:Event = null):void {
	}

	protected static function invalidate ():void {
		if (OmniCore.stage) OmniCore.stage.invalidate ();
	}

	public function drawDirectly ():void {
		_changed = true;
		draw (null);
	}

	///////////////////////////////////
	// Signal Methods
	///////////////////////////////////

	public function enableSignals ():void {
	}

	public function disableSignals ():void {
	}

	public function onAddedToStage (e:Event):void {
		OmniCore.onStageDraw.add (draw);
		invalidate ();
		this.visible = true;
	}

	public function onMarginChanged ():void {
		if (_padding) {
			_changed = true;
			invalidate ();
		}
	}

	///////////////////////////////////
	// getter/setters
	///////////////////////////////////

	public function move (x:Number,y:Number):void {
		this.x = x;
		this.y = y;
	}

	public function size (width:Number,height:Number):void {
		this.width = width;
		this.height = height;
	}

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
				OmniCore.onDefaultThemeChanged.remove (onStyleChanged);
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

	public function get getDimensionObject ():ObjectBase {
		var dimensions:ObjectBase = new ObjectBase ();
		dimensions.x = this.x;
		dimensions.y = this.y;
		dimensions.width = this.width;
		dimensions.height = this.height;
		dimensions.padding = this.padding;
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

	public function set state (value:int):void {
		if (value != _state) {
			_state = value;
			drawDirectly ();
		}
	}

	public function get state ():int {
		return _state;
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
			OmniCore.onDefaultThemeChanged.remove (onStyleChanged);

		OmniCore.onStageDraw.remove (draw);

		if (_padding != null) _padding.dispose ();
		_padding = null;

		if (gc) System.gc ();
	}

	///////////////////////////////////
	// toString
	///////////////////////////////////

	override public function toString ():String {
		return "[bloom.core.Component]";
	}

}

}
