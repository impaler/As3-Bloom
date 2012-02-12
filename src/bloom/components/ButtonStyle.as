/**
 * Date: 12/02/12
 * Time: 9:29 PM
 */
package bloom.components {

import bloom.core.ButtonBaseStyle;
import bloom.core.IComponent;

public class ButtonStyle extends ButtonBaseStyle {
	public function ButtonStyle () {
		super ();
	}

	override public function initialize ( comp:IComponent ):void {
		super.initialize ( comp );
		var btn:Button = comp as Button;

	}

}
}
