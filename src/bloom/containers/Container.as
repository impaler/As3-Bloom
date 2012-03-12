package bloom.containers {

import bloom.core.Component;
import bloom.core.IComponent;
import bloom.core.OmniCore;
import bloom.style.containers.ContainerStyle;

import flash.display.BitmapData;
import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.Sprite;
import flash.events.Event;
import flash.geom.Rectangle;

/**
 * Container
 */
public class Container extends Component {

	protected var background:BitmapData;
	protected var _content:Sprite;
	protected var _maskContent:Boolean;
	protected var _bgEnabled:Boolean = true;

	public function Container (p:DisplayObjectContainer = null) {
		super (p);
	}

	override protected function createAssets ():void {
		super.createAssets ();

		_content = new Sprite ();
		addChild (_content);
	}

	override protected function onThemeChanged ():void {
		_style = OmniCore.defaultTheme.containerStyle;
		super.onThemeChanged ();
	}

	override public function initDefaultStyle ():void {
		super.initDefaultStyle ();
		_maskContent = containerStyle.maskContent;
	}

	public function addContent (value:IComponent):void {
		if (value is IComponent) {
			_content.addChild (DisplayObject (value));
			value.drawDirectly ();
			drawDirectly ();
		}
	}

	override protected function draw (e:Event = null):void {
		if (! _changed) return;
		_changed = false;

		layoutContent ();
		applyMask ();

		if (_bgEnabled) {
			if (_maskContent) {
				containerStyle.background.update (_state,this,getDimensionObject);
			} else {
				var dimensions:Object = new Object ();
				dimensions.x = _content.x;
				dimensions.y = _content.y;
				dimensions.width = _content.width;
				dimensions.height = _content.height;
				containerStyle.background.update (_state,_content,dimensions);
			}
		}

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

	///////////////////////////////////
	// Dispose
	///////////////////////////////////

	override public function dispose (gc:Boolean = false):void {
		super.dispose (gc);
		if (background) background.dispose ();
		background = null;
		removeChild (_content);
		_content = null;
	}

	///////////////////////////////////
	// toString
	///////////////////////////////////

	public override function toString ():String {
		return "[bloom.components.Container]";
	}
}

}
