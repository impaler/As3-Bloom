package bloom.style.components.containers {

import bloom.components.containers.Window;
import bloom.core.IComponent;
import bloom.style.brush.Brush;
import bloom.style.components.ComponentBackgroundBaseStyle;
import bloom.style.components.controls.ButtonBaseStyle;

/**
 * WindowStyle
 */
public class WindowStyle extends ComponentBackgroundBaseStyle {

	public var headerSize:Number;
	public var footerSize:Number;
	public var scrollbarSize:Number;
	public var maxWidth:Number;
	public var minWidth:Number;
	public var maxHeight:Number;
	public var minHeight:Number;

	public var titleBar:TitleBarStyle;
	public var scaler:ButtonBaseStyle;

	override public function update (value:IComponent):void {
		var win:Window = value as Window;
		background.update (value.state,win.scrollContainer,value.getDimensionObject);


//		scaler.update(win.state, win.scaler, win.scaler.getDimensionObject);

	}

	///////////////////////////////////
	// toString
	///////////////////////////////////

	override public function toString ():String {
		return "[bloom.styles.WindowStyle]";
	}

}

}
