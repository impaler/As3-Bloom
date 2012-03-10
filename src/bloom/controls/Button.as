package bloom.controls {

import bloom.core.OmniCore;

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

	public function Button (p:DisplayObjectContainer = null,title:String = "") {
		_titleLabel = title;
		super (p);
	}

	override public function enableSignals ():void {
		super.enableSignals ();
		_title.onTextChanged.add (onTitleChanged);
	}

	override public function disableSignals ():void {
		super.enableSignals ();
		_title.onTextChanged.remove (onTitleChanged);
	}

	override protected function createAssets ():void {
		_title = new Label (this,_titleLabel);
	}

	override protected function onThemeChanged ():void {
		_style = OmniCore.defaultTheme.buttonStyle as ButtonStyle;
	}

	override public function dispose (gc:Boolean = false):void {
		super.dispose (gc);
		removeChild (_title);
		_title.dispose (false);
		_title = null;
		if (_icon) removeChild (_icon);
		_icon = null;
	}


	override protected function draw (e:Event = null):void {
		if (! _changed) return;

		_changed = false;

		buttonStyle.background.update (_state,this,getDimensionObject);
		buttonStyle.buttonText.update (_state,_title,getDimensionObject);

		onTitleChanged (null);

//		drawIcon();
	}

	protected function onTitleChanged (e:Event):void {
		if (_icon) {
			_icon.x = (_width - _icon.width - _title.padding.left - _title.width) * 0.5;
			_icon.y = (_height - _icon.height) * 0.5;
			_title.x = _icon.x + _icon.width + _title.padding.left;
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
				onTitleChanged (null);
			}
		}
	}

	public function get title ():Label {
		return _title;
	}

	///////////////////////////////////
	// toString
	///////////////////////////////////

	public override function toString ():String {
		return "[bloom.components.Button]";
	}

}

}
