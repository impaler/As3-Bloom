package bloom.components.containers {

import bloom.core.IComponent;

import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;

import org.as3commons.ui.layout.HLayout;
import org.as3commons.ui.layout.constants.Align;

/**
 * FlowBox
 *
 * @description A Layout Container to arrange items in advanced grid layouts
 *
 * @info advanced Grid Layout provided by kakenbok
 *
 * @see https://github.com/AS3Commons/as3commons-ui
 * @see http://www.apache.org/licenses/LICENSE-2.0 for use of HLayout
 *
 */
public class FlowBox extends Container {

	protected var _LayoutComponent:HLayout;

	private var _hGap = 5;
	private var _vGap = 5;
	private var _hAlign = Align.CENTER;
	private var _vAlign = Align.TOP;

	public function FlowBox (p:DisplayObjectContainer = null) {
		super (p);
	}

	override protected function createAssets ():void {
		super.createAssets ();

		_LayoutComponent = new HLayout ();
		_LayoutComponent.marginX = 0;
		_LayoutComponent.marginY = 0;
		_LayoutComponent.offsetX = 0;
		_LayoutComponent.offsetY = contentPadding;
		_LayoutComponent.maxItemsPerRow = 0;
		_LayoutComponent.hGap = _hGap;
		_LayoutComponent.vGap = _vGap;
		_LayoutComponent.hAlign = _hAlign;
		_LayoutComponent.vAlign = _vAlign;
	}

	override public function addContent (value:IComponent):IComponent {
		if (value is IComponent) {
			_objects.push (value);

			value.drawDirectly ();
			_LayoutComponent.add (value);
			content.addChild (DisplayObject (value));
			return value;
		} else {
			return null;
		}
	}

	override public function removeContent (value:IComponent):IComponent {
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

	override public function removeContentAt (index:int):IComponent {
		var result:IComponent = _objects[index] as IComponent;
		if (result) {
			_content.removeChild (DisplayObject (result));
			_LayoutComponent.remove (result);

			_objects[index] = null;
			result.dispose ();

			drawDirectly ();
		}
		return result;
	}

	override public function layoutContent ():void {
		_LayoutComponent.minWidth = _width;
		_LayoutComponent.minHeight = _height - contentPadding;
		_LayoutComponent.maxContentWidth = _width - contentPadding;

		_LayoutComponent.layout (content);

		content.y = contentPadding;

	}

	///////////////////////////////////
	// getter/setters
	///////////////////////////////////

	public function set hGap (value):void {
		_LayoutComponent.hGap = value;
	}

	public function set vGap (value):void {
		_LayoutComponent.vGap = value;
	}

	public function set hAlign (value):void {
		_LayoutComponent.hAlign = value;
	}

	public function set vAlign (value):void {
		_LayoutComponent.vAlign = value;
	}

	///////////////////////////////////
	// Dispose
	///////////////////////////////////

	override public function dispose (gc:Boolean = false):void {
		super.dispose (gc);
		_LayoutComponent = null;
	}

	///////////////////////////////////
	// toString
	///////////////////////////////////

	public override function toString ():String {
		return "[bloom.components.FlowBox]";
	}

}

}
