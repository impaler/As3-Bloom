package {

import bloom.Button;
import bloom.NumericStepper;
import bloom.containers.FlowContainer;
import bloom.core.IChild;
import bloom.themes.ColorTheme;
import bloom.themes.ThemeBase;

import flash.display.DisplayObjectContainer;

import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.events.MouseEvent;

[SWF(backgroundColor = 0x000000, frameRate = 40, width = 700, height = 300)]
public class LayoutsTest extends Sprite {

	private var _marginLeft:NumericStepper ;
	private var _gridtest:FlowContainer;
	private var _width:NumericStepper;

	public function LayoutsTest () {
		stage.align = StageAlign.TOP_LEFT;
		stage.scaleMode = StageScaleMode.NO_SCALE;
		stage.showDefaultContextMenu = false;
		ThemeBase.setTheme(new ColorTheme());

		_marginLeft = new NumericStepper(this, 0,100);
		_marginLeft.addEventListener(Event.CHANGE, onNumericStepperChanged);

		var cont:FlowContainer = new FlowContainer(this);
		cont.height = 0;
		cont.direction = FlowContainer.HORIZONTALLY;
		cont.x = 200;

		var horizbutton:Button = new Button(cont, "Horizontal");
		horizbutton.addEventListener(MouseEvent.MOUSE_DOWN , onHoriz );

		var verticalbutton:Button = new Button(cont, "Vertical");
		verticalbutton.addEventListener(MouseEvent.MOUSE_DOWN , onVert );

		var gridbutton:Button = new Button(cont, "Grid");
		gridbutton.addEventListener(MouseEvent.MOUSE_DOWN , onGrid );

		_width = new NumericStepper ( cont , 500 , 1000 );
		_width.addEventListener(Event.CHANGE, onWidth );

		_gridtest = new FlowContainer(this);
		_gridtest.width = 500;
		_gridtest.height = 900;
		_gridtest.y = 50;
		_gridtest.direction = FlowContainer.GRID;

		var i:int;
		var j:int = 20;
		for ( i = 0 ; i < j ; i ++ ) {
			_gridtest.addChild(new Button(null, "test"));
		}

		onNumericStepperChanged(null);
	}

	private function onWidth ( event:Event ):void {
		_gridtest.width = _width.value;
	}

	private function onHoriz ( event:MouseEvent ):void {
		_gridtest.direction = FlowContainer.HORIZONTALLY;
	}

	private function onVert ( event:MouseEvent ):void {
		_gridtest.direction = FlowContainer.VERTICALLY;
	}

	private function onGrid ( event:MouseEvent ):void {
		_gridtest.direction = FlowContainer.GRID;
	}

	private function onNumericStepperChanged ( event:Event ):void {
		var _target:DisplayObjectContainer = _gridtest as DisplayObjectContainer;
		var i:int, j:int = _target.numChildren;
		for ( i = 0 ; i < j ; i ++ ) {
			if ( _target.getChildAt ( i ) is IChild ){
				var object:Button = _target.getChildAt ( i ) as Button;
					object.margin.reset( _marginLeft.value, _marginLeft.value,
					                     _marginLeft.value, _marginLeft.value );
			}
		}
		_gridtest.update();
	}



}
}
