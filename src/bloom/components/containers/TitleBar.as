package bloom.components.containers {

import bloom.components.controls.Button;
import bloom.components.text.Label;
import bloom.core.ComponentConstants;
import bloom.core.OmniCore;

import flash.display.Sprite;

public class TitleBar extends Container {

	private var _icon:Sprite;
	private var _title:Label;
	private var _titleText:String;

	private var _closeButton:Button;
	private var _minimizeButton:Button;
	private var _maximizeButton:Button;
	private var _buttonBox:HBox;

	private var _buttonsPadding:Number = 10;
	private var _closeable:Boolean;
	private var _maximizable:Boolean;
	private var _minimizable:Boolean;

	public function TitleBar (titleText:String = "",closeable:Boolean = true,maximizable:Boolean = true,
	                          minimizable:Boolean = true) {
		_closeable = closeable;
		_maximizable = maximizable;
		_minimizable = minimizable;
		_titleText = titleText;

		super ();
	}

	///////////////////////////////////
	// Base Component Methods
	///////////////////////////////////

	override protected function onStyleChanged ():void {
		_style = OmniCore.defaultTheme.windowStyle.titleBar;
		if (_style) {
			_changed = true;
			invalidate ();
		}
	}

	override protected function initDefaultStyle ():void {
		maskContent = false;
		this.maximizable = _maximizable;
		this.minimizable = _minimizable;
		this.titleText = _titleText;
		this.closeable = _closeable;


		_state = ComponentConstants.ACTIVE;
		size (_style.defaultWidth,_style.defaultHeight);
	}

	override protected function createAssets ():void {
		super.createAssets ();

		_buttonBox = new HBox(this);
//		_buttonBox.maskContent = false;
		_buttonBox.bgEnabled = false;
		_buttonBox.autoHeight = true;
		_buttonBox.autoWidth = true;
		_buttonBox.contentPadding = _buttonsPadding;

//		_icon = new Sprite ();
//		_maximizeButton = new Button (this);

	}

	override public function layoutContent ():void {
		if ( _title ) {
			_title.width = this.width - _buttonBox.width - _buttonsPadding;
			_title.height = height;
			_title.x = _buttonsPadding;
//			_title.y = (_height*.5)-(_title.height*.5);
		}

		_buttonBox.height = _height;
		_buttonBox.x = _width-_buttonBox.width;
		_buttonBox.y = (_height*.5)-(_buttonBox.height*.5);
	}

	///////////////////////////////////
	// getter/setters
	///////////////////////////////////

	internal function get title ():Label {
		if (!_title) {
			_title = new Label (this,_titleText);
			_title.maskContent = true;
		}
		return _title;
	}

	public function get closeButton ():Button {
		if (!_closeButton) {
			_closeButton = new Button ();
			_closeButton.size(14,14);
		}
		return _closeButton;
	}

	public function get maximizable ():Boolean {
		return _maximizable;
	}

	public function set maximizable (value:Boolean):void {
		if (value) {
			_maximizable = value;
			_buttonBox.addContent( maximizeButton );

		} else {
//				_maximizable = value;
//				_buttonBox.removeContent( maximizeButton );
		}
		layoutContent();
	}

	public function get closeable ():Boolean {
		return _closeable;
	}

	public function set closeable (value:Boolean):void {
			if (value) {
				_closeable = value;
				_buttonBox.addContent( closeButton );

			} else {
//				_closeable = value;
//				_buttonBox.removeContent( closeButton );
			}
			layoutContent();
	}

	public function get minimizable ():Boolean {
		return _minimizable;
	}

	public function set minimizable (value:Boolean):void {
		if (value) {
			_minimizable = value;
			_buttonBox.addContent( minimizeButton );

		} else {
//				_minimizable = value;
//				_buttonBox.removeContent( minimizeButton );
		}
		layoutContent();

	}

	override public function get width ():Number {
		return _width;
	}

	override public function get height ():Number {
		return _height;
	}

	public function get minimizeButton ():Button {
		if (!_minimizeButton) {
			_minimizeButton = new Button ();
			_minimizeButton.size(14,14);
		}

		return _minimizeButton;
	}

	public function get maximizeButton ():Button {
		if (!_maximizeButton) {
			_maximizeButton = new Button ();
			_maximizeButton.size(14,14);
		}
		return _maximizeButton;
	}

	private function set titleText (titleText:String):void {
		_titleText = titleText;
		title.text = _titleText;
	}

	///////////////////////////////////
	// Dispose
	///////////////////////////////////

	override public function dispose (gc:Boolean = false):void {
		super.dispose (gc);

	}

	///////////////////////////////////
	// toString
	///////////////////////////////////

	public override function toString ():String {
		return "[bloom.components.TitleBar]";
	}

}
}
