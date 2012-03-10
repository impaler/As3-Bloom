package bloom.containers {

import bloom.core.Component;

import flash.display.BitmapData;
import flash.display.DisplayObjectContainer;
import flash.events.Event;

/**
 * Container
 */
public class Container extends Component {

	protected var background:BitmapData;

	public function Container (p:DisplayObjectContainer = null) {
		super (p);
//			_style = ThemeBase.theme.container;
		size (100,100);
	}

	override public function dispose (gc:Boolean = false):void {
		super.dispose (gc);
		if (background) background.dispose ();
		background = null;
	}

	override protected function onThemeChanged ():void {
//			style = ThemeBase.theme.container;
	}

	override protected function draw (e:Event = null):void {
		if (! _changed) return;
		_changed = false;

		containerStyle.background.update (_state,this,getDimensionObject);

	}


	///////////////////////////////////
	// getter/setters
	///////////////////////////////////

	public function get containerStyle ():ContainerStyle {
		return _style as ContainerStyle;
	}

	///////////////////////////////////
	// toString
	///////////////////////////////////

	public override function toString ():String {
		return "[bloom.components.Container]";
	}
}

}
