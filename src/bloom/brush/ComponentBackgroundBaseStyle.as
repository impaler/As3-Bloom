package bloom.brush {

/**
 * ComponentBaseStyle
 */
public class ComponentBackgroundBaseStyle extends ComponentBaseStyle {

	public var background:Brush;

	///////////////////////////////////
	// Dispose
	///////////////////////////////////

	override public function dispose (gc:Boolean = false):void {
		background.dispose();
		background = null;
	}


	///////////////////////////////////
	// toString
	///////////////////////////////////

	override public function toString ():String {
		return "[bloom.styles.ComponentBaseStyle]";
	}

}
}
