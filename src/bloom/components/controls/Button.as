package bloom.components.controls {

import bloom.core.OmniCore;
import bloom.components.style.components.controls.ButtonStyle;
import bloom.components.text.Label;

import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.events.Event;

/**
 * Button
 *
 * @description A Generic Button Component that has Text Label and Icon support
 *
 */
public class Button extends ButtonBase {

	protected var _titleText:String;
	protected var _title:Label;
	protected var _icon:DisplayObject;
	protected var _iconPadding:Number;

	public function Button (p:DisplayObjectContainer = null,title:String = "") {
		_titleText = title;
		super (p);
	}

	override protected function initDefaultStyle ():void {
		super.initDefaultStyle ();
		_iconPadding = 12;
	}

	override protected function onStyleChanged ():void {
		_style = OmniCore.defaultTheme.buttonStyle as ButtonStyle;
		if (_style) {
			_changed = true;
			invalidate ();
		}
	}

	override public function enableSignals ():void {
		_title.onTextChanged.add (positionTitleandIcon);
		super.enableSignals ();
	}

	override public function disableSignals ():void {
		_title.onTextChanged.remove (positionTitleandIcon);
		super.disableSignals ();
	}

	override protected function createAssets ():void {
		_title = new Label (this,_titleText);
		super.createAssets ();
	}

	override protected function draw (e:Event = null):void {
		if (! _changed) return;
		_changed = false;

		buttonStyle.update (this);

		positionTitleandIcon ();

//		drawIcon();
	}

	protected function positionTitleandIcon (e:Event = null):void {
		if (_icon) {
			if (_icon.height > _height)
				_icon.height = _height - 6;

			_icon.x = _iconPadding;
			_icon.y = (_height - _icon.height) * 0.5;
			if (_titleText != "") {
				_title.x = _icon.x + _icon.width + _iconPadding + _title.padding.left;
			} else {
				_icon.x = _width * .5 - _icon.width * .5;
			}

		} else {
			_title.x = (_width - _title.width) * 0.5;
		}
		_title.y = (_height - _title.height) * 0.5;
	}

	///////////////////////////////////
	// getter/setters
	///////////////////////////////////

	public function get buttonStyle ():ButtonStyle {
		return _style as ButtonStyle;
	}

	public function get icon ():DisplayObject {
		return _icon;
	}

	public function set icon (value:DisplayObject):void {
		if (_icon != value) {
			if (_icon) removeChild (_icon);
			_icon = value;
			if (_icon) {
				addChild (_icon);
				positionTitleandIcon (null);
			}
		}
	}

	public function get title ():Label {
		return _title;
	}

	///////////////////////////////////
	// Dispose
	///////////////////////////////////

	override public function dispose (gc:Boolean = false):void {
		super.dispose (gc);
		removeChild (_title);
		_title.dispose (false);
		_title = null;
		if (_icon) removeChild (_icon);
		_icon = null;
	}

	///////////////////////////////////
	// toString
	///////////////////////////////////

	public override function toString ():String {
		return "[bloom.components.Button]";
	}

}

}
