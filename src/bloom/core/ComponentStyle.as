/**
 * Date: 12/02/12
 * Time: 3:38 PM
 */
package bloom.core {

public class ComponentStyle {

	public var defaultWidth:int;
	public var defaultHeight:int;

	public function initialize ( comp:IComponent ):void {
		var _comp:Component = comp as Component;

		_comp.width = defaultWidth;
		_comp.height = defaultHeight;
	}

}
}
