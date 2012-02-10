package {

import bloom.brushes.ColorBrush;
import bloom.brushes.TextBrush;
import bloom.components.Button;
import bloom.components.ButtonModel;
import bloom.containers.FlowContainer;
import bloom.core.Bloom;
import bloom.core.ComponentReg;
import bloom.core.ThemeBase;
import bloom.themes.darkTheme.DarkTheme;
import bloom.themes.defaultTheme.DefaultTheme;

import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.MouseEvent;

public class ComponentRegModelTest extends Sprite {

	public function ComponentRegModelTest () {
		stage.align = StageAlign.TOP_LEFT;
		stage.scaleMode = StageScaleMode.NO_SCALE;
		stage.showDefaultContextMenu = false;

		Bloom.core ().init ( stage , new DefaultTheme () , true );
//		Bloom.core ().registerComponents = true;
		
		var greenButton:ButtonModel = new ButtonModel();
		greenButton.Text_Button = new TextBrush ( "Verdana" , 12 , 0x000000 , false , false , false );	
		greenButton.Text_Button_Over = new TextBrush ( "Verdana" , 13 , 0x000000 , false , false , false );	
		greenButton.Text_Button_Down = new TextBrush ( "Verdana" , 11 , 0x000000 , false , false , false );
		greenButton.defaultWidth = 200;
		greenButton.defaultHeight = 26;
		var data = new Vector.<uint> ( 3 , true );
		data[Bloom.NORM] = 0x0cff00;
		data[Bloom.OVER] = 0x0cff00;
		data[Bloom.DOWN] = 0x0cff00;
		greenButton.brush = new ColorBrush ( data );
		
		
		var blueButton:ButtonModel = new ButtonModel();
		blueButton.Text_Button = new TextBrush ( "Verdana" , 12 , 0x000000 , false , false , false );	
		blueButton.Text_Button_Over = new TextBrush ( "Verdana" , 13 , 0x000000 , false , false , false );	
		blueButton.Text_Button_Down = new TextBrush ( "Verdana" , 11 , 0x000000 , false , false , false );
		blueButton.defaultWidth = 200;
		blueButton.defaultHeight = 26;
		var data = new Vector.<uint> ( 3 , true );
		data[Bloom.NORM] = 0x72b5f4;
		data[Bloom.OVER] = 0x72b5f4;
		data[Bloom.DOWN] = 0x72b5f4;
		blueButton.brush = new ColorBrush ( data );		
		
		var greenTheme:ThemeBase = new ThemeBase();
		greenTheme.Button_Model = greenButton;
		
		var blueTheme:ThemeBase = new ThemeBase();
		blueTheme.Button_Model = blueButton;
		
		
		
		
		
		var mainCont:FlowContainer = new FlowContainer(this);
		mainCont.direction = Bloom.VERTICALLY;
		mainCont.size(0,0);		
		
		var _customComponentReg = new ComponentReg ();
		
		var themeBTNS:FlowContainer = new FlowContainer();
		themeBTNS.direction = Bloom.HORIZONTALLY;
		themeBTNS.size(300,70);
		
		var Btn:Button = new Button(null, "set DarkTheme", function(e:MouseEvent){
			_customComponentReg.setTheme(new DarkTheme());
		});
		Btn.model = greenButton;
		themeBTNS.addContent(Btn);
		
		var Btn:Button = new Button(null, "set DefaultTheme", function(e:MouseEvent){
			_customComponentReg.setTheme(  new DefaultTheme() );
		});
		Btn.model = blueButton;		
		themeBTNS.addContent(Btn);
		
		mainCont.addContent(themeBTNS);
		

		var GRID:FlowContainer = new FlowContainer();
		GRID.direction = Bloom.GRID;
		GRID.size(400,160);
		
		for ( var i:int = 0 ; i < 10 ; i ++ ) {
			var greenBTN:Button = new Button(null, "Blue");		
			GRID.addContent(greenBTN);
			_customComponentReg.registerComponent(greenBTN);
		}
		
		mainCont.addContent(GRID);
		
		
		

		var _custom2ComponentReg = new ComponentReg ();
		
		var themeBTNS:FlowContainer = new FlowContainer();
		themeBTNS.direction = Bloom.HORIZONTALLY;
		themeBTNS.size(300,70);
		
		var Btn:Button = new Button(null, "set DarkTheme", function(e:MouseEvent){
			_custom2ComponentReg.setTheme(new DarkTheme());
		});
		Btn.model = greenButton;
		themeBTNS.addContent(Btn);
		
		var Btn:Button = new Button(null, "set DefaultTheme", function(e:MouseEvent){
			_custom2ComponentReg.setTheme(  new DefaultTheme() );
		});
		Btn.model = blueButton;		
		themeBTNS.addContent(Btn);
		
		mainCont.addContent(themeBTNS);
		

		var GRID:FlowContainer = new FlowContainer();
		GRID.direction = Bloom.GRID;
		GRID.size(400,160);
		
		for ( var i:int = 0 ; i < 10 ; i ++ ) {
			var greenBTN:Button = new Button(null, "Blue");		
			GRID.addContent(greenBTN);
			_custom2ComponentReg.registerComponent(greenBTN);
		}
		
		mainCont.addContent(GRID);
		
		
		
		
		
		
	}

}
}
