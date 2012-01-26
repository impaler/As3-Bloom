/**
 * Copyright (c) 2012 - 2100 Sindney
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */
package theme_previewer {

import bloom.*;
import bloom.brushes.ColorBrush;
import bloom.brushes.TextBrush;
import bloom.containers.*;
import bloom.core.Margin;
import bloom.themes.*;
import bloom.themes.bmptheme.BMPTheme;

import flash.display.Bitmap;
import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.filters.BlurFilter;

import theme_previewer.tabs.ButtonsTab;
import theme_previewer.tabs.LabelsTab;

/**
 * BMPExample
 *
 * @author sindney, impaler
 */
[SWF(backgroundColor=0xffffff , frameRate=40 , width=960 , height=720)]
public class ThemePreviewer extends Sprite {

	[Embed(source="./background.jpg")]
	private var background:Class;

	[Embed(source="./logo_simple.png")]
	private var logo_simple:Class;

	private var _themetoggle:Number = 1;
	private var _enableButton:Button;
	private var _enabled:Boolean = true;
	private var _slide:Slider;
	private var _window:Window;
	private var _openWindow:Button;
	private var decrease:Boolean = false;
	private var progressBar:ProgressBar;

	private var _tabs:TabBox;

	public function ThemePreviewer () {
		stage.align = StageAlign.TOP_LEFT;
		stage.scaleMode = StageScaleMode.NO_SCALE;
		stage.showDefaultContextMenu = false;

		ThemeBase.registerComponents = true;
		ThemeBase.setTheme ( new BMPTheme () );
		//ThemeBase.setTheme ( new ColorTheme () );

		//todo refactor/cleanup
		createMainInterface ();
		createTabWindow ();
		createTabs ();

		_tabs.toggleTab ( "Buttons" );
	}

	private function createTabWindow ():void {
		var container:FlowContainer = new FlowContainer ();
		var window:Window = new Window ( this , container , true , true , false );

		// TabBox
		_tabs = new TabBox ( container );

		window.liveResize = true;
		window.footerSize = 20;
		window.size ( 680 , 480 );
		window.move ( 100 , 150 );
		window.resizeable = false;
		_tabs.size ( container.width , container.height );
		new Label ( window.header , "Theme Preview" );

		//todo with tab size
		_window = window;
		_window.addEventListener ( Event.RESIZE , updateContainer );
		window.resizeable = true;

		function updateContainer ( event:Event ):void {
			_tabs.size ( container.width , container.height );
		}
	}

	private function createTabs ():void {
		// this class is too big to be edited easily needs separation into component classes
		//here is a start
		var scrollContainer:ButtonsTab = new ButtonsTab ();
		_tabs.addContent ( "Buttons" , scrollContainer , scrollContainer.margin );
		scrollContainer.calculateContentSize ();

		var labelsTab:LabelsTab = new LabelsTab ();
		_tabs.addContent ( "Labels" , labelsTab , labelsTab.margin );
		scrollContainer.calculateContentSize ();

		var color:Vector.<uint> = new Vector.<uint> ( 1 , true );
		color[0] = 0xE9E9E9;
		var brush:ColorBrush = new ColorBrush ( color );

		var margin:Margin = new Margin ( 4 , 4 , 0 , 0 );
		// Labels Tab
		var scrollContainer_0:ScrollContainer = new ScrollContainer ();
		scrollContainer_0 = new ScrollContainer ();
		scrollContainer_0.direction = ScrollContainer.VERTICALLY;
		scrollContainer_0.brush = brush;

//		var label:Label = new Label ( scrollContainer_0.content , "I am a Label" );
//
//		label = new Label ( scrollContainer_0.content , "Large Text" );
//		label.brush = new TextBrush ( "Verdana" , 30 , 0x000000 , false , false , false );

//		_tabs.addContent ( "Labels" , scrollContainer_0 , margin );
//		scrollContainer_0.calculateContentSize ();

		// Sliders Tab
		scrollContainer_0 = new ScrollContainer ();
		scrollContainer_0.direction = ScrollContainer.VERTICALLY;
		scrollContainer_0.brush = brush;

		var slide:Slider = new Slider ( scrollContainer_0.content );
		slide.size ( 30 , 100 );

		slide = new Slider ( scrollContainer_0.content );
		slide.size ( 30 , 100 );
		slide.enabled = false;

		slide = new Slider ( scrollContainer_0.content , 1 , 50 );
		slide.size ( 100 , 30 );

		slide = new Slider ( scrollContainer_0.content , 1 , 50 );
		slide.size ( 100 , 30 );
		slide.enabled = false;

		slide = new Slider ( scrollContainer_0.content , Slider.VERTICALLY , 30 );
		slide.size ( 30 , 200 );

		slide = new Slider ( scrollContainer_0.content , Slider.HORIZONTALLY , 30 );
		slide.size ( 200 , 30 );

		_tabs.addContent ( "Sliders" , scrollContainer_0 , margin );
		scrollContainer_0.calculateContentSize ();

		// Numeric Stepper Tab
		scrollContainer_0 = new ScrollContainer ();
		scrollContainer_0.direction = ScrollContainer.VERTICALLY;
		scrollContainer_0.brush = brush;

		var stepper:NumericStepper = new NumericStepper ( scrollContainer_0.content );

		stepper = new NumericStepper ( scrollContainer_0.content );
		stepper.enabled = false;

		stepper = new NumericStepper ( scrollContainer_0.content );
		stepper.textBase.brush = new TextBrush ( "Verdana" , 30 , 0x000000 , false , false , false );
		stepper.size ( 120 , 40 );

		_tabs.addContent ( "Steppers" , scrollContainer_0 , margin );
		scrollContainer_0.calculateContentSize ();

		// CheckBox
		scrollContainer_0 = new ScrollContainer ();
		scrollContainer_0.direction = ScrollContainer.VERTICALLY;
		scrollContainer_0.brush = brush;

		var checkBox:CheckBox = new CheckBox ( scrollContainer_0.content , "CheckBox" );

		checkBox = new CheckBox ( scrollContainer_0.content , "CheckBox" );
		checkBox.enabled = false;

		// with checkboxgroup, you can easily link a group of checkbox object(and he who extends checkbox).
		// set checkBoxGroup.index = -1 means there's no checkbox object currently.
		var checkBoxGroup:CheckBoxGroup = new CheckBoxGroup ( - 1 );

		checkBox = new CheckBox ( scrollContainer_0.content , "CheckBox Group Item 0" );
		checkBoxGroup.addChild ( checkBox );

		checkBox = new CheckBox ( scrollContainer_0.content , "CheckBox Group Item 1" );
		checkBoxGroup.addChild ( checkBox );

		checkBox = new CheckBox ( scrollContainer_0.content , "CheckBox Group Item 2" );
		checkBoxGroup.addChild ( checkBox );

		// set target checkbox
		checkBoxGroup.index = 0;

		_tabs.addContent ( "CheckBoxes" , scrollContainer_0 , margin );
		scrollContainer_0.calculateContentSize ();

		// Text Tab
		scrollContainer_0 = new ScrollContainer ();
		scrollContainer_0.direction = ScrollContainer.VERTICALLY;
		scrollContainer_0.brush = brush;

		var textbox:TextBox = new TextBox ( scrollContainer_0.content , "I am a textbox" );

		textbox = new TextBox ( scrollContainer_0.content , "disabled :(" );
		textbox.enabled = false;

		textbox = new TextBox ( scrollContainer_0.content , "Large Text ^_^" );
		textbox.textBase.brush = new TextBrush ( "Verdana" , 30 , 0x000000 , false , false , false );
		textbox.size ( 230 , 160 );

		var text:TextInput = new TextInput ( scrollContainer_0.content , "Text Input" );

		text = new TextInput ( scrollContainer_0.content , "disabled :(" );
		text.enabled = false;

		text = new TextInput ( scrollContainer_0.content , "Wide o_O" );
		text.size ( 300 , 20 );

		_tabs.addContent ( "Text" , scrollContainer_0 , margin );
		scrollContainer_0.calculateContentSize ();

		// List Tab
		scrollContainer_0 = new ScrollContainer ();
		scrollContainer_0.direction = ScrollContainer.VERTICALLY;
		scrollContainer_0.brush = brush;

		var i:int;
		var data:Array = [];
		for ( i = 0 ; i < 10000 ; i ++ ) {
			data[i] = ["NO." + i.toString ()];
		}
		var list:List = new List ( scrollContainer_0.content , data );

		list = new List ( scrollContainer_0.content , data );
		list.enabled = false;

		list = new List ( scrollContainer_0.content , data );
		list.size ( 200 , 100 );

		_tabs.addContent ( "List" , scrollContainer_0 , margin );
		scrollContainer_0.calculateContentSize ();

		// Toggle Tab
		scrollContainer_0 = new ScrollContainer ();
		scrollContainer_0.direction = ScrollContainer.VERTICALLY;
		scrollContainer_0.brush = brush;

		var toggleButton:ToggleButton = new ToggleButton ( scrollContainer_0.content , "ToggleButton" );

		toggleButton = new ToggleButton ( scrollContainer_0.content , "ToggleButton" );
		toggleButton.enabled = false;

		var toggleSwitcher:ToggleSwitcher = new ToggleSwitcher ( scrollContainer_0.content , true );
		toggleSwitcher.width = 120;

		toggleSwitcher = new ToggleSwitcher ( scrollContainer_0.content , true );
		toggleSwitcher.enabled = false;
		toggleSwitcher.width = 120;

		_tabs.addContent ( "Toggle" , scrollContainer_0 , margin );
		scrollContainer_0.calculateContentSize ();

		// Progress Tab
		scrollContainer_0 = new ScrollContainer ();
		scrollContainer_0.direction = ScrollContainer.VERTICALLY;
		scrollContainer_0.brush = brush;

		progressBar = new ProgressBar ( scrollContainer_0.content , 0 );
		progressBar.addEventListener ( Event.ENTER_FRAME , onLoop );

		progressBar = new ProgressBar ( scrollContainer_0.content , 0 );
		progressBar.enabled = false;

		progressBar = new ProgressBar ( scrollContainer_0.content , 0 );
		progressBar.size ( 60 , 60 );
		progressBar.addEventListener ( Event.ENTER_FRAME , onLoop );

		progressBar = new ProgressBar ( scrollContainer_0.content , 0 );
		progressBar.size ( 200 , 40 );
		progressBar.addEventListener ( Event.ENTER_FRAME , onLoop );

		_tabs.addContent ( "Progress" , scrollContainer_0 , margin );
		scrollContainer_0.calculateContentSize ();

	}

	private function createMainInterface ():Bitmap {
		//bg
		var bg:Bitmap = new background () as Bitmap;
		bg.filters = new Array ( new BlurFilter ( 4 , 4 , 1 ) );
		addChild ( bg );
		stage.addEventListener ( Event.RESIZE , bgListener );
		scaleProportional ( bg , stage.stageWidth , stage.stageHeight );
		centerStage ( bg );
		function bgListener ( e:Event ):void {
			scaleProportional ( bg , stage.stageWidth , stage.stageHeight );
			centerStage ( bg );
		}

		//a demo logo
		var logo:Bitmap = new logo_simple ();
		addChild ( logo );
		logo.y = 14;
		logo.x = 8;
		logo.smoothing = true;
		scaleProportional ( logo , 100 , 100 );

		var container:FlowContainer = new FlowContainer ( this );
		container.registerComponent = false;
		container.direction = FlowContainer.HORIZONTALLY;
		container.size ( 0 , 0 );
		container.move ( 250 , 6 );

		_openWindow = new Button ( container , "Open ThemePreviewer" );
		_openWindow.size ( 200 , 40 );
		_openWindow.registerComponent = false;
		_openWindow.addEventListener ( MouseEvent.MOUSE_DOWN , OpenThemePreviewer );

		_enableButton = new Button ( container , "Disable Previewer" );
		_enableButton.registerComponent = false;
		_enableButton.size ( 300 , 40 );
		_enableButton.addEventListener ( MouseEvent.MOUSE_DOWN , DisableComponents );

		var container:FlowContainer = new FlowContainer ( this );
		container.registerComponent = false;
		container.direction = FlowContainer.HORIZONTALLY;
		container.size ( 0 , 0 );
		container.move ( 250 , 46 );

		var but:Button = new Button ( container , "BMP" );
		but.size ( 120 , 40 );
		but.registerComponent = false;
		but.addEventListener ( MouseEvent.MOUSE_DOWN , BMPThemeChange );

		var but:Button = new Button ( container , "Color" );
		but.size ( 120 , 40 );
		but.registerComponent = false;
		but.addEventListener ( MouseEvent.MOUSE_DOWN , ColorThemeChange );
		return bg;
	}

	private function OpenThemePreviewer ( e:MouseEvent ):void {
		_window.visible ? _openWindow.title.text = " Open ThemePreviewer" : _openWindow.title.text = " Close ThemePreviewer";
		_window.visible ? _window.close () : _window.open ();
	}

	private function DisableComponents ( event:MouseEvent ):void {
		_enabled ? _enabled = false : _enabled = true;
		_enabled ? _enableButton.title.text = "Disable All Components" : _enableButton.title.text = "Enable All Components";
		ThemeBase.enableComponents ( _enabled );
	}

	private function BMPThemeChange ( event:MouseEvent ):void {
		ThemeBase.setTheme ( new BMPTheme () );
	}

	private function ColorThemeChange ( event:MouseEvent ):void {
		ThemeBase.setTheme ( new ColorTheme () );
	}

	private function onLoop ( e:Event ):void {
		var bar:ProgressBar = e.target as ProgressBar;
		if ( bar.value == 100 ) decrease = true;
		if ( bar.value == 0 ) decrease = false;
		bar.value += decrease ? - 1 : 1;
	}

	function scaleProportional ( target:DisplayObject , targetWidth:Number , targetHeight:Number ):void {
		var ratioHeight = target.height / target.width;
		var ratioWidth = target.width / target.height;

		if ( ( targetHeight / targetWidth) < ratioHeight ) {
			target.width = targetWidth;
			target.height = ratioHeight * target.width;
		} else {
			target.height = targetHeight;
			target.width = ratioWidth * target.height;
		}
		;
	}

	function centerStage ( target:DisplayObject ):void {
		target.x = stage.stageWidth / 2 - target.width / 2;
		target.y = stage.stageHeight / 2 - target.height / 2;
	}

	/*
	 stage.addEventListener(Event.ACTIVATE, flashActivate);
	 stage.addEventListener(Event.DEACTIVATE, flashDeactivate);

	 private function flashActivate (event:Event):void
	 {
	 ThemeBase.enableComponents( true );
	 }

	 private function flashDeactivate (event:Event):void
	 {
	 ThemeBase.enableComponents( false );
	 }
	 */

}

}
