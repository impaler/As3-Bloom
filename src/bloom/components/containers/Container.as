package bloom.components.containers {

import bloom.core.Component;
import bloom.core.IComponent;
import bloom.core.OmniCore;
import bloom.style.components.containers.ContainerStyle;

import flash.display.BitmapData;
import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.Sprite;
import flash.events.Event;
import flash.geom.Rectangle;

/**
 * Container
 *
 * @description A Layout Container to arrange items intended to be extended with layout logic
 *
 */
public class Container extends Component {

	protected var background:BitmapData;
	protected var _content:Sprite;
	private var _hasContent:Boolean ;
	protected var _contentPadding:Number;
	protected var _maskContent:Boolean = false;
	protected var _autoWidth:Boolean = true;
	protected var _autoHeight:Boolean = true;
	private var _bgEnabled:Boolean = true;
	protected var _bg:Sprite;
	protected var _objects:Array;

	public function Container (p:DisplayObjectContainer = null) {
		super (p);
	}

	override protected function initDefaultStyle ():void {
		_contentPadding = containerStyle.contentPadding;
		hasContent = false;
		super.initDefaultStyle ();
	}

	override protected function createAssets ():void {
		_objects = new Array ();

		super.createAssets ();

		_bg = new Sprite ();

		addChild (_bg);
		_content = new Sprite ();

		addChild (_content);
	}

	override protected function onStyleChanged ():void {
		_style = OmniCore.defaultTheme.containerStyle;
		super.onStyleChanged ();
	}

	public function addContent (value:IComponent):IComponent {
		if (value is IComponent) {
			_objects.push (value);

			hasContent = true;
			value.drawDirectly ();
			_content.addChild (DisplayObject (value));

			drawDirectly ();

			return value;
		} else {
			return null;
		}

	}

	public function removeContent (value:IComponent):IComponent {
		if (value is IComponent) {
			var index:int = _objects.indexOf (value,0);
			if (index != - 1) {
				return removeContentAt (index);
			} else {
				return null;
			}
		} else {
			return null;
		}
	}

	public function removeContentAt (index:int):IComponent {
		var result:IComponent = _objects[index] as IComponent;
		if (result) {
			_content.removeChild (DisplayObject (result));
			result.dispose ();

			_objects[index] = null;

			drawDirectly ();
			onResized.dispatch ();
		}
		return result;
	}

	override protected function draw (e:Event = null):void {
		if (! _changed) return;
		_changed = false;

		layoutContent ();
		applyMask ();

		containerStyle.update (this);
	}

	private function applyMask ():void {
		_maskContent ? _content.scrollRect = new Rectangle (0,0,_width,_height) : _content.scrollRect = null;
	}

	public function layoutContent ():void {
	}

	///////////////////////////////////
	// getter/setters
	///////////////////////////////////

	public function get containerStyle ():ContainerStyle {
		return _style as ContainerStyle;
	}

	public function get autoHeight ():Boolean {
		return _autoHeight;
	}

	public function set autoHeight (value:Boolean):void {
		if (value != _autoHeight) {
			_autoHeight = value;
			drawDirectly ();
		}
	}

	public function get autoWidth ():Boolean {
		return _autoWidth;
	}

	public function set autoWidth (value:Boolean):void {
		if (value != _autoWidth) {
			_autoWidth = value;
			drawDirectly ();
		}
	}

	public function get maskContent ():Boolean {
		return _maskContent;
	}

	public function set maskContent (value:Boolean):void {
		if (value != _maskContent) {
			_maskContent = value;
			applyMask ();
		}
	}

	public function get content ():Sprite {
		return _content;
	}

	public function set bgEnabled (bg:Boolean):void {_bgEnabled = bg;}

	public function get bgEnabled ():Boolean {
		return _bgEnabled;
	}

	override public function get width ():Number {
		if (! _autoWidth) {
			return super.width;
		} else {
			var wValue:Number = (_content.width + (containerStyle.contentPadding * 2));
			return wValue;
		}
	}

	override public function get height ():Number {
		if (! _autoHeight) {
			return super.height;
		} else {
			var hValue:Number = (_content.height + (containerStyle.contentPadding * 2));
			return hValue;
		}
	}

	public function get contentPadding ():Number {
		return _contentPadding;
	}

	public function set contentPadding (value:Number):void {
		if (_contentPadding != value) {
			_contentPadding = value;

			_changed = true;
			invalidate ();
		}
	}

	public function get bg ():Sprite {
		return _bg;
	}

	public function get hasContent ():Boolean {
		return _hasContent;
	}

	public function set hasContent (value:Boolean):void {
		_hasContent = value;
	}

///////////////////////////////////
	// Dispose
	///////////////////////////////////

	override public function dispose (gc:Boolean = false):void {
		super.dispose (gc);

		if (background) background.dispose ();
		background = null;
		removeChild (_content);
		_content = null;
		_objects = null;
	}

	///////////////////////////////////
	// toString
	///////////////////////////////////

	public override function toString ():String {
		return "[bloom.components.Container]";
	}
}

}
