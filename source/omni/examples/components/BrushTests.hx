package omni.examples.components;

import omni.components.utils.ComponentUtils;
import omni.components.core.interfaces.IOComponent;
import omni.components.core.OCore;
import omni.components.core.OComponent;
import omni.components.core.signals.OSignal;
import omni.components.utils.ColorUtils;

import omni.components.theme.orange.Orange;
import omni.components.style.brush.BrushColorFill;
import omni.components.style.brush.BrushCustomFill;
import omni.components.style.brush.BrushBitmapFillRepeat;
import omni.components.style.brush.BrushBitmapScale3Fill;
import omni.components.style.brush.BrushBitmapScale9Fill;
import omni.components.style.OBaseStyle;

import nme.Lib;
import nme.geom.Matrix;
import nme.Assets;
import nme.display.StageScaleMode;
import nme.display.StageAlign;
import nme.text.TextField;
import nme.display.MovieClip;
import nme.display.Graphics;
import nme.display.BitmapData;
import nme.geom.Rectangle;

class BrushTests
{

	public function new()
	{
		nme.Lib.trace("boo");


//		for(i in 0...500)
//		{
//			var testComp = new OComponent ();
//			var styleTest = new ComponentStyle();
//			var brush = new BrushColorFill();
//			brush.setColorState(OBaseStyle.STATE_ACTIVE, ColorUtils.randomColor());
//			styleTest.setBackgroundBrush(brush);
//			testComp.style = styleTest;
//			testComp.move(Math.random() * nme.Lib.current.stage.stageWidth, Math.random() * nme.Lib.current.stage.stageHeight);
//			OCore.addChild(testComp);
//		}

/*			var perlinData;
			  #if neko
			  var color = {rgb: 0xFF0000, a: 0xFF};
			  perlinData = new BitmapData(100,100, true, color);
			  #else
			  perlinData = new BitmapData(100,100, true, 0x00FFFFFF);
			  #end
			  
			  var seed = Math.floor(Math.random() * 10000);
			  var channels = 7;
			  var numOctaves =3;
			  perlinData.perlinNoise(100, 100, numOctaves, seed, false, false, channels, true, null);		
					  
			  for(i in 0...1000)
			  {
				  var testComp = new OComponent ();
				  var styleTest = new ComponentStyle();
				  styleTest.minWidth = 100;
				  styleTest.minHeight = 100;
				  var brush = new BrushBitmapScale9Fill();
				  brush.setBitmapDataState(OBaseStyle.STATE_ACTIVE, perlinData);
				  brush.scaleRect = [10,90,10,90];
				  styleTest.setBackgroundBrush(brush);
				  testComp.style = styleTest;
				  testComp.size(Math.random() * nme.Lib.current.stage.stageWidth, Math.random() * nme.Lib.current.stage.stageHeight);
				  testComp.move(Math.random() * nme.Lib.current.stage.stageWidth, Math.random() * nme.Lib.current.stage.stageHeight);
				  OCore.addChild(testComp);
			  }*/

//				var perlinData = new BitmapData(100,100, true, 0x00FFFFFF);
//				var seed = Math.floor(Math.random() * 10000);
//				var channels = 7;
//				var numOctaves =3;
//				perlinData.perlinNoise(100, 100, numOctaves, seed, false, false, channels, true, null);		
//						
//				for(i in 0...1000)
//				{
//					var testComp = new OComponent ();
//					var styleTest = new ComponentStyle();
//					styleTest.minWidth = 100;
//					var brush = new BrushBitmapScale3Fill();
//					brush.setBitmapDataState(OBaseStyle.STATE_ACTIVE, perlinData);
//					brush.scaleRect = [49,51,100];
//		//			brush.smooth = true;
//					styleTest.setBackgroundBrush(brush);
//					testComp.style = styleTest;
//					testComp.size(Math.random() * nme.Lib.current.stage.stageWidth, Math.random() * nme.Lib.current.stage.stageHeight);
//					testComp.move(Math.random() * nme.Lib.current.stage.stageWidth, Math.random() * nme.Lib.current.stage.stageHeight);
//					OCore.addChild(testComp);
//				}
				
				var bitmapTest = Assets.getBitmapData("assets/tests/test.jpg");	
				var targetWidth = Math.random() * nme.Lib.current.stage.stageWidth;
				var targetHeight = Math.random() * nme.Lib.current.stage.stageHeight;
				
				bitmapTest = ComponentUtils.scaleBitmapData(bitmapTest, 20,20);		
		
				for(i in 0...1000)
				{
					var testComp = new OComponent ();
					var styleTest = new ComponentStyle();
					styleTest.minWidth = 100;
					var brush = new BrushBitmapFillRepeat();
					brush.setBitmapDataState(OBaseStyle.STATE_ACTIVE, bitmapTest);
		//			brush.smooth = true;
					styleTest.setBackgroundBrush(brush);
					testComp.style = styleTest;
					testComp.size(targetWidth, targetHeight);
					testComp.move(Math.random() * nme.Lib.current.stage.stageWidth, Math.random() * nme.Lib.current.stage.stageHeight);
					OCore.addChild(testComp);
				}

//				for(i in 0...1000)
//				{
//					var testComp = new OComponent ();
//					var styleTest = new ComponentStyle();
//					var brush = new BrushCustomFill();
//					brush.setDrawFunctionState(OBaseStyle.STATE_ACTIVE, 
//		               function(drawTarget:IOComponent):Void {
//			                var graphics:Graphics = drawTarget.sprite.graphics;
//			                graphics.clear();
//			                graphics.beginFill(ColorUtils.randomColor());
//			                graphics.drawRect(0, 0, drawTarget.width, drawTarget.height);
//			                graphics.endFill();
//		               }
//					);
//					styleTest.setBackgroundBrush(brush);
//					testComp.style = styleTest;
//					testComp.size(Math.random() * nme.Lib.current.stage.stageWidth, Math.random() * nme.Lib.current.stage.stageHeight);
//					testComp.move(Math.random() * nme.Lib.current.stage.stageWidth, Math.random() * nme.Lib.current.stage.stageHeight);
//					OCore.addChild(testComp);
//				}

		//		var path = "assets/themes/flashpunk/defaultSkin.png";
		//		var normal = [0, 96, 8, 8];
		//		var hover = new NineSlice(this.width, this.height, new Rectangle(24, 96, 8, 8));
		//		var down = new NineSlice(this.width, this.height, new Rectangle(48, 96, 8, 8));
		//		var inactive = new NineSlice(this.width, this.height, new Rectangle(96, 96, 8, 8));

	}

}
