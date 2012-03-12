package bloom.core {

public class ObjectBase implements IObjectBase {

	private var _x:Number;
	private var _y:Number;
	private var _width:Number;
	private var _height:Number;
	private var _padding:Padding;

	public function set x (value:Number):void {
		_x = value;
	}

	public function set y (value:Number):void {
		_y = value;
	}

	public function set width (value:Number):void {
		_width = value;
	}

	public function set height (value:Number):void {
		_height = value;
	}

	public function set padding (value:Padding):void {
		_padding = value;
	}

	public function get x ():Number {
		return _x;
	}

	public function get y ():Number {
		return _y;
	}

	public function get width ():Number {
		return _width;
	}

	public function get height ():Number {
		return _height;
	}

	public function get padding ():Padding {
		return _padding;
	}

}
}
