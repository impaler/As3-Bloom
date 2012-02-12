package bloom.containers {

import bloom.brushes.Brush;
import bloom.brushes.TextBrush;
import bloom.core.ComponentModel;

public class WindowModel extends ComponentModel {

	public var maxWidth:int;
	public var minWidth:int;
	public var maxHeight:int;
	public var minHeight:int;

	public var Window_Header:Brush;
	public var Window_Footer:Brush;
	public var liveResize:Boolean;
	public var headerHeight:Number;
	public var footerHeight:Number;
	public var moveable:Boolean;
	public var resizeable:Boolean;
	
	public var title:TextBrush;

}
}
