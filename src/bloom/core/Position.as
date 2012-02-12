/**
 * Date: 12/02/12
 * Time: 10:06 PM
 */
package bloom.core {

import flash.display.InteractiveObject;

public class Position {

	public static function alignHPosition ( target:InteractiveObject , context:InteractiveObject , method:int ):void {
		switch ( method ) {
			case BloomConstants.LEFT:
				target.x = 0;
				break;
			case BloomConstants.CENTRE:
				target.x = Math.round ( (context.width * .5) - (target.width * .5) );
				break;
			case BloomConstants.RIGHT:
				target.x = Math.round ( context.width - target.width );
				break;
		}

	}

	public static function alignVPosition ( target:InteractiveObject , context:InteractiveObject , method:int ):void {
		switch ( method ) {
			case BloomConstants.TOP:
				target.y = 0;
				break;
			case BloomConstants.CENTRE:
				target.y = Math.round ( (context.height * .5) - (target.height * .5) );
				break;
			case BloomConstants.BOTTOM:
				target.y = Math.round ( context.height - target.height );
				break;
		}

	}

}
}
