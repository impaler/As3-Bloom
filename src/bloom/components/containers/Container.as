package bloom.components.containers {

import bloom.core.Component;
import bloom.core.IComponent;
import bloom.core.ObjectBase;
import bloom.core.OmniCore;
import bloom.components.style.components.containers.ContainerStyle;

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
	protected var _hasContent:Boolean = false;

	protected var _maskContent:Boolean = false;
	protected var _bgEnabled:Boolean = true;

	public function Container (p:DisplayObjectContainer = null) {
		super (p);
	}

	override protected function createAssets ():void {
		super.createAssets ();

		_content = new Sprite ();
		addChild (_content);
	}

	override protected function onStyleChanged ():void {
		_style = OmniCore.defaultTheme.containerStyle;
		super.onStyleChanged ();
	}

	public function addContent (value:IComponent):void {
		if (value is IComponent) {
			_hasContent = true;
			value.drawDirectly ();
			_content.addChild (DisplayObject (value));
			drawDirectly ();
		}
	}

	override protected function draw (e:Event = null):void {
		if (! _changed) return;
		_changed = false;

		layoutContent ();
		applyMask ();

		if (_bgEnabled) {
			containerStyle.background.update (_state,this,getDimensionObject);
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

	override public function get width ():Number {
		if ( !_hasContent ) {
			return super.width;
		} else {
			return content.width + (containerStyle.contentPadding *2);
		}
	}

	override public function get height ():Number {
		if ( !_hasContent ) {
			return super.height;
		} else {
			return content.height + (containerStyle.contentPadding *2);
		}
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
	}

	///////////////////////////////////
	// toString
	///////////////////////////////////

	public override function toString ():String {
		return "[bloom.components.Container]";
	}
}

}
