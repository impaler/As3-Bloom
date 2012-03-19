package bloom.components.text {

import bloom.core.TextBase;

import flash.display.DisplayObjectContainer;
import flash.geom.Rectangle;
import flash.text.TextFieldAutoSize;
import flash.text.TextFieldType;

/**
 * Label
 */
public class Label extends TextBase {

	private var _maskContent:Boolean;
	private var _width:Number;
	private var _height:Number;

	public function Label (p:DisplayObjectContainer = null,text:String = "") {
		super (p);

		type = TextFieldType.DYNAMIC;
		autoSize = TextFieldAutoSize.LEFT;

		selectable = mouseEnabled = tabEnabled = false;

		_maskContent = false;

		this.text = text;
	}

	private function applyMask ():void {
		_maskContent ? this.scrollRect = new Rectangle (0,0,_width,_height) : this.scrollRect = null;
	}

	override public function set width (value:Number):void {
		_width = value;
		applyMask();
		super.width = value;
	}

	override public function set height (value:Number):void {
		_height = value;
		applyMask();
		super.height = value;
	}

	public function get maskContent ():Boolean {
		return _maskContent;
	}

	public function set maskContent (value:Boolean):void {
		_maskContent = value;
		applyMask();
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

	override public function toString ():String {
		return "[bloom.components.Label]";
	}

}

}
