/**
 * Date: 12/02/12
 * Time: 9:26 PM
 */
package bloom.components {

import bloom.core.Bloom;
import bloom.core.BloomConstants;
import bloom.core.ButtonBase;
import bloom.core.ComponentStyle;
import bloom.core.Position;

import flash.display.DisplayObjectContainer;
import flash.events.Event;

public class Button extends ButtonBase {

	private var _title:Label;

	public function Button ( p:DisplayObjectContainer = null , text:String = "" , down:Function = null ) {
		if ( down != null ) onDown.addOnce ( down );

		super ( p );
		
		style = Bloom.core ().styleRegistry.getObject ( Bloom.core ().currentTheme.BUTTONBASE_STYLE ) as ComponentStyle;
		_title = new Label ( this , text );

	}

	public function get getButtonStyle ():ButtonStyle {
		return Bloom.core ().styleRegistry.getObject ( Bloom.core ().currentTheme.BUTTONBASE_STYLE ) as ButtonStyle;
	}

	override protected function draw ( e:Event ):void {
		super.draw ( e );

		Position.alignHPosition ( _title , this , BloomConstants.CENTRE );
		Position.alignVPosition ( _title , this , BloomConstants.CENTRE );
	}

///////////////////////////////////
// toString
///////////////////////////////////

	public override function toString ():String {
		return "[bloom.core.Button]";
	}

	override public function destroy ():void {
		super.destroy ();

		_title.destroy ();
	}

}
}
