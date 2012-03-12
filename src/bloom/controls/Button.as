package bloom.controls {

import bloom.core.OmniCore;
import bloom.style.controls.ButtonStyle;
import bloom.text.Label;

import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.events.Event;

/**
 * Button
 */
public class Button extends ButtonBase {

	protected var _titleLabel:String;
	protected var _title:Label;
	protected var _icon:DisplayObject;
	protected var _iconPadding:Number;

	public function Button (p:DisplayObjectContainer = null,title:String = "") {
		_titleLabel = title;
		super (p);
	}

	override public function initDefaultStyle ():void {
		super.initDefaultStyle ();
		_iconPadding = 12;
	}

	override protected function onThemeChanged ():void {
		_style = OmniCore.defaultTheme.buttonStyle as ButtonStyle;
		if (_style) {
			_changed = true;
			invalidate ();
		}
	}

	override public function enableSignals ():void {
		super.enableSignals ();
		_title.onTextChanged.add (positionTitleandIcon);
	}

	override public function disableSignals ():void {
		super.enableSignals ();
		_title.onTextChanged.remove (positionTitleandIcon);
	}

	override protected function createAssets ():void {
		_title = new Label (this,_titleLabel);
	}

	override protected function draw (e:Event = null):void {
		if (! _changed) return;

		_changed = false;

		buttonStyle.background.update (_state,this,getDimensionObject);
		buttonStyle.buttonText.update (_state,_title,getDimensionObject);

//		_title.state = _state;

		positionTitleandIcon ();

//		drawIcon();
	}

	protected function positionTitleandIcon (e:Event = null):void {
		if (_icon) {
			if (_icon.height > _height)
				_icon.height = _height - 6;

			_icon.x = _iconPadding;
			_icon.y = (_height - _icon.height) * 0.5;
			if (_titleLabel != "") {
				_title.x = _icon.x + _icon.width + _iconPadding + _title.padding.left;
			} else {
				_icon.x = _width * .5 - _icon.width * .5;
			}

		} else {
			_title.x = (_width - _title.width) * 0.5;
		}
		_title.y = (_height - _title.height) * 0.5;
	}

//	private function drawIcon ():void {
//		switch (state) {
//			case StateConstants.ACTIVE:
//				if (_iconNormal) {
//					_iconNormal.x = (_width - _iconNormal.width) * 0.5;
//					_iconNormal.y = (_height - _iconNormal.height) * 0.5;
//					addChild (_iconNormal);
//				}
//				break;
//			case StateConstants.OVER:
//				if (_iconOver) {
//					_iconOver.x = (_width - _iconOver.width) * 0.5;
//					_iconOver.y = (_height - _iconOver.height) * 0.5;
//					addChild (_iconOver);
//				}
//				break;
//			case StateConstants.ACTIVATED:
//				if (_iconDown) {
//					_iconDown.x = (_width - _iconDown.width) * 0.5;
//					_iconDown.y = (_height - _iconDown.height) * 0.5;
//					addChild (_iconDown);
//				}
//				break;
//		}
//	}

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
