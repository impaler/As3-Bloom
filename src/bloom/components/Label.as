/**
 * Date: 12/02/12
 * Time: 9:28 PM
 */
package bloom.components {

import bloom.brushes.TextBrush;
import bloom.core.Bloom;
import bloom.core.ComponentStyle;
import bloom.core.IComponent;

import flash.display.DisplayObjectContainer;
import flash.text.TextField;
import flash.utils.getDefinitionByName;
import flash.utils.getQualifiedClassName;

public class Label extends TextField implements IComponent {

	private var _style:ComponentStyle;
	private var _changed:Boolean;
	private var _enabled:Boolean;

	public function Label ( p:DisplayObjectContainer = null , _text:String = "" ) {
		selectable = mouseEnabled = tabEnabled = false;
		type = "dynamic";
		autoSize = "left";
		text = _text;
//		_textfield.border = true;

		super ();
		style = Bloom.core ().styleRegistry.getObject ( Bloom.core ().currentTheme.LABEL_STYLE );

		if ( p != null ) p.addChild ( this );
	}

	public function getLabelStyle ():LabelStyle {
		return _style as LabelStyle;
	}

	public function setTextBrush ( brush:TextBrush ):void {
		if ( defaultTextFormat != getLabelStyle ().textFormatBrush.textFormat ) {
			defaultTextFormat = getLabelStyle ().textFormatBrush.textFormat;
			setTextFormat ( defaultTextFormat );
		}
	}

	public function set style ( style:ComponentStyle ):void {
		if ( style != null ) {
			var newStyle:Class = getDefinitionByName ( getQualifiedClassName ( style ) ) as Class;
			if ( _style != null ) {
				var current:Class = getDefinitionByName ( getQualifiedClassName ( _style ) ) as Class;
				if ( newStyle == current ) return;
			}
			_style = Bloom.core ().styleRegistry.getObject ( newStyle ) as ComponentStyle;
			style.initialize ( this );
			_changed = true;
			invalidate ();
		}
	}

	protected function invalidate ():void {
		if ( Bloom.core ().stage ) Bloom.core ().stage.invalidate ();
	}

	override public function get width ():Number {
		return getBounds ( this ).width + 2;
	}

	override public function get height ():Number {
		return getBounds ( this ).height + 2;
	}

	public function move ( x:Number , y:Number ):void {
		this.x = x;
		this.y = y;
	}

	public function size ( w:Number , h:Number ):void {
		width = w;
		height = h;
	}

	public function destroy ():void {
	}

	public function set enabled ( value:Boolean ):void {
		if ( _enabled != value ) {
			_enabled = mouseEnabled = value;
			alpha = _enabled ? 1 : .4;
		}
	}

	public function get enabled ():Boolean {
		return false;
	}
}
}
