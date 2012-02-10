/**
 * Date: 10/02/12
 * Time: 8:07 PM
 */
package {

import bloom.components.Button;
import bloom.containers.FlowContainer;
import bloom.core.Bloom;
import bloom.themes.defaultTheme.DefaultTheme;

import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.MouseEvent;

public class LayoutTest extends Sprite {
	public function LayoutTest () {
		stage.align = StageAlign.TOP_LEFT;
		stage.scaleMode = StageScaleMode.NO_SCALE;
		stage.showDefaultContextMenu = false;

		Bloom.core ().init ( stage , new DefaultTheme () , true );
//		Bloom.core().registerComponents = true;
		
		var AlignRight:FlowContainer = new FlowContainer(this);
		AlignRight.hAlignment = Bloom.RIGHT;
		AlignRight.direction = Bloom.HORIZONTALLY;
		AlignRight.size(800,800);
		AlignRight.y = 50;
		AlignRight.addContent( createTestButtons() );
		AlignRight.addContent( createTestButtons() );
		AlignRight.addContent( createTestButtons() );
		
		
		
		var Buttons:FlowContainer = new FlowContainer(this);
		Buttons.hAlignment = Bloom.LEFT;
		Buttons.direction = Bloom.HORIZONTALLY;
		Buttons.size(0,0);
		
		Buttons.addContent(new Button(null,"LEFT",function(e:MouseEvent){
			AlignRight.hAlignment = Bloom.LEFT;
		}));
		
		Buttons.addContent(new Button(null,"CENTRE",function(e:MouseEvent){
			AlignRight.hAlignment = Bloom.CENTRE;
		}));
		
		Buttons.addContent(new Button(null,"RIGHT",function(e:MouseEvent){
			AlignRight.hAlignment = Bloom.RIGHT;
		}));
		
		Buttons.addContent(new Button(null,"TOP",function(e:MouseEvent){
			AlignRight.vAlignment = Bloom.TOP;
		}));
		
		Buttons.addContent(new Button(null,"CENTRE",function(e:MouseEvent){
			AlignRight.vAlignment = Bloom.CENTRE;
		}));		
		
		Buttons.addContent(new Button(null,"BOTTOM",function(e:MouseEvent){
			AlignRight.vAlignment = Bloom.BOTTOM;
		}));				
		
	}

	private function createTestButtons (text:String="Test"):Button {
		var btn:Button = new Button(null, text);
		return btn;
	}
}
}
