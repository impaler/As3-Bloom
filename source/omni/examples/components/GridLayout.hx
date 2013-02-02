package omni.examples.components;

import omni.components.utils.ColorUtils;
import omni.components.utils.ComponentUtils;
import omni.components.core.OButtonBase;

import nme.events.Event;
import flash.display.Sprite;

import com.somerandomdude.coordy.layouts.twodee.Flow;
import com.somerandomdude.coordy.constants.FlowAlignment;
import com.somerandomdude.coordy.layouts.twodee.Grid;

/**
 * ...
 * @author marc paraiso
 */


@:keep
class GridLayout extends Sprite
{
	
	public function new()
	{
		super();
//		var layout:Grid = new Grid(600, 500, 3, 3);
//		for (i in 0...25) {
//		var square:Square = new Square(30, ColorUtils.randomColor());
//			addChild(square);
//			layout.addNode(square);
//		}
//		layout.updateAndRender();
		
		//todo investigate Coordy errors with neko target and problems with html5
		_layout = new Flow(nme.Lib.stage.stageWidth,  nme.Lib.stage.stageHeight);
		_layout.x = 0;
		_layout.y = 0;
		_layout.alignment = FlowAlignment.MIDDLE_CENTER;
		_layout.paddingX = 10;
		_layout.paddingY = 10;
		
//		var c:Square;
		for(i in 0...100)
		{
			var c = new OButtonBase();
//			c=new Square(3+(Math.random()*35*2),Square.getRandomColor());
			c.drawNow();
			_layout.addNode(c.sprite);
			addChild(c.sprite);
		}
		
		
		nme.Lib.stage.addChild(this);
		nme.Lib.stage.addEventListener(Event.RESIZE, onResize);
	}

	public var _layout:Flow;
	
	public function onResize(e:Event):Void
	{
		_layout.width = nme.Lib.stage.stageWidth;
		_layout.height = nme.Lib.stage.stageHeight;
	}
	
}