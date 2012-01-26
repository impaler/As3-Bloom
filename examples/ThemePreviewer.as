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
package {

import bloom.*;
import bloom.brushes.ColorBrush;
import bloom.brushes.TextBrush;
import bloom.containers.*;
import bloom.core.Margin;
import bloom.themes.*;
import bloom.themes.bmptheme.BMPTheme;

import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;

/**
 * BMPExample
 *
 * @author sindney, impaler
 */
[SWF(backgroundColor=0xffffff , frameRate=40 , width=700 , height=500)]
public class ThemePreviewer extends Sprite {

	[Embed(source="background.jpg")]
	private var background:Class;

	[Embed(source="logo_simple.png")]
	private var logo:Class;

	public function ThemePreviewer () {
		stage.align = StageAlign.TOP_LEFT;
		stage.scaleMode = StageScaleMode.NO_SCALE;
		stage.showDefaultContextMenu = false;

		addChild ( new background () );
		addChild ( new logo () );

		ThemeBase.setTheme ( new BMPTheme () );

		var scrollContainer:ScrollContainer = new ScrollContainer ();
		scrollContainer.margin.reset ( 2 , 10 , 2 , 10 );

		var window:Window = new Window ( this , scrollContainer );
		window.size ( 600 , 300 );
		window.move ( 20 , 150 );
		window.maxWidth = 720;
		window.maxHeight = 565;
		window.minWidth = 200;
		window.minHeight = 200;
		window.liveResize = true;

		var title:Label = new Label ( window.header , "ThemePreviewer" );
		title.brush = title.brush.clone () as TextBrush;
		title.brush.textFormat.bold = true;
		title.brush.textFormat.color = 0xffff00;
		title.brush.update ();

		// TabBox
		var tabBox:TabBox = new TabBox ( scrollContainer.content );
		tabBox.margin.reset ( 0 , 0 , 0 , 0 );
		tabBox.size ( 680 , 480 );

		scrollContainer.calculateContentSize ();

		// Tab Content margins
		var margin:Margin = new Margin ( 4 , 4 , 0 , 0 );

		var color:Vector.<uint> = new Vector.<uint> ( 1 , true );
		color[0] = 0xE9E9E9;
		var brush:ColorBrush = new ColorBrush ( color );

		var tabContainer:FlowContainer = new FlowContainer ();

		tabContainer.direction = ScrollContainer.VERTICALLY;
		tabContainer.brush = brush;

		// Buttons Tab
		var but:Button = new Button ( tabContainer , "Active Button" );
		but.size ( 120 , 40 );

		but = new Button ( tabContainer , "Disabled Button" );
		but.size ( 120 , 40 );
		but.enabled = false;

		but = new Button ( tabContainer , ":)" );
		but.size ( 40 , 120 );

		but = new Button ( tabContainer , "Button" );
		but.size ( 120 , 120 );

		tabBox.addContent ( "Buttons" , tabContainer , margin );
//		scrollContainer.calculateContentSize ();



		// Labels Tab
		tabContainer = new FlowContainer ();
		tabContainer.direction = FlowContainer.VERTICALLY;
		tabContainer.brush = brush;

		var label:Label = new Label ( tabContainer , "I am a Label" );

		label = new Label ( tabContainer , "Large Text" );
		label.brush = new TextBrush ( "Verdana" , 30 , 0x000000 , false , false , false );

		tabBox.addContent ( "Labels" , tabContainer , margin );


		// Sliders Tab
		tabContainer = new FlowContainer ();
		tabContainer.direction = FlowContainer.VERTICALLY;
		tabContainer.brush = brush;

		var slide:Slider = new Slider ( tabContainer );
		slide.size ( 30 , 100 );

		slide = new Slider ( tabContainer );
		slide.size ( 30 , 100 );
		slide.enabled = false;

		slide = new Slider ( tabContainer , 1 , 50 );
		slide.size ( 100 , 30 );

		slide = new Slider ( tabContainer , 1 , 50 );
		slide.size ( 100 , 30 );
		slide.enabled = false;

		slide = new Slider ( tabContainer , Slider.VERTICALLY , 30 );
		slide.size ( 30 , 200 );

		slide = new Slider ( tabContainer , Slider.HORIZONTALLY , 30 );
		slide.size ( 200 , 30 );

		tabBox.addContent ( "Sliders" , tabContainer , margin );


		// Numeric Stepper Tab
		tabContainer = new FlowContainer ();
		tabContainer.direction = FlowContainer.VERTICALLY;
		tabContainer.brush = brush;

		var stepper:NumericStepper = new NumericStepper ( tabContainer );

		stepper = new NumericStepper ( tabContainer );
		stepper.enabled = false;

		stepper = new NumericStepper ( tabContainer );
		stepper.textBase.brush = new TextBrush ( "Verdana" , 30 , 0x000000 , false , false , false );
		stepper.size ( 120 , 40 );

		tabBox.addContent ( "Steppers" , tabContainer , margin );


		// CheckBox
		tabContainer = new FlowContainer ();
		tabContainer.direction = FlowContainer.VERTICALLY;
		tabContainer.brush = brush;

		var checkBox:CheckBox = new CheckBox ( tabContainer , "CheckBox" );

		checkBox = new CheckBox ( tabContainer , "CheckBox" );
		checkBox.enabled = false;

		// with checkboxgroup, you can easily link a group of checkbox object(and he who extends checkbox).
		// set checkBoxGroup.index = -1 means there's no checkbox object currently.
		var checkBoxGroup:CheckBoxGroup = new CheckBoxGroup ( - 1 );

		checkBox = new CheckBox ( tabContainer , "CheckBox Group Item 0" );
		checkBoxGroup.addChild ( checkBox );

		checkBox = new CheckBox ( tabContainer , "CheckBox Group Item 1" );
		checkBoxGroup.addChild ( checkBox );

		checkBox = new CheckBox ( tabContainer , "CheckBox Group Item 2" );
		checkBoxGroup.addChild ( checkBox );

		// set target checkbox
		checkBoxGroup.index = 0;

		tabBox.addContent ( "CheckBoxes" , tabContainer , margin );


		// Text Tab
		tabContainer = new FlowContainer ();
		tabContainer.direction = FlowContainer.VERTICALLY;
		tabContainer.brush = brush;

		var textbox:TextBox = new TextBox ( tabContainer , "I am a textbox" );

		textbox = new TextBox ( tabContainer , "disabled :(" );
		textbox.enabled = false;

		textbox = new TextBox ( tabContainer , "Large Text ^_^" );
		textbox.textBase.brush = new TextBrush ( "Verdana" , 30 , 0xffffff , false , false , true );
		textbox.size ( 230 , 160 );

		var text:TextInput = new TextInput ( tabContainer , "Text Input" );

		text = new TextInput ( tabContainer , "disabled :(" );
		text.enabled = false;

		text = new TextInput ( tabContainer , "Wide o_O" );
		text.size ( 300 , 20 );

		tabBox.addContent ( "Text" , tabContainer , margin );


		// List Tab
		tabContainer = new FlowContainer ();
		tabContainer.direction = FlowContainer.VERTICALLY;
		tabContainer.brush = brush;

		var i:int;
		var data:Array = [];
		for ( i = 0 ; i < 10000 ; i ++ ) {
			data[i] = ["NO." + i.toString ()];
		}
		var list:List = new List ( tabContainer , data );

		list = new List ( tabContainer , data );
		list.enabled = false;

		list = new List ( tabContainer , data );
		list.size ( 200 , 100 );

		tabBox.addContent ( "List" , tabContainer , margin );


		// Toggle Tab
		tabContainer = new FlowContainer ();
		tabContainer.direction = FlowContainer.VERTICALLY;
		tabContainer.brush = brush;

		var toggleButton:ToggleButton = new ToggleButton ( tabContainer , "ToggleButton" );

		toggleButton = new ToggleButton ( tabContainer , "ToggleButton" );
		toggleButton.enabled = false;

		var toggleSwitcher:ToggleSwitcher = new ToggleSwitcher ( tabContainer , true );
		toggleSwitcher.width = 200;

		toggleSwitcher = new ToggleSwitcher ( tabContainer , true );
		toggleSwitcher.enabled = false;

		tabBox.addContent ( "Toggle" , tabContainer , margin );


		// Progress Tab
		tabContainer = new FlowContainer ();
		tabContainer.direction = FlowContainer.VERTICALLY;
		tabContainer.brush = brush;

		progressBar = new ProgressBar ( tabContainer , 0 );
		progressBar.addEventListener ( Event.ENTER_FRAME , onLoop );

		progressBar = new ProgressBar ( tabContainer , 0 );
		progressBar.enabled = false;

		progressBar = new ProgressBar ( tabContainer , 0 );
		progressBar.size ( 60 , 60 );
		progressBar.addEventListener ( Event.ENTER_FRAME , onLoop );

		progressBar = new ProgressBar ( tabContainer , 0 );
		progressBar.size ( 200 , 40 );
		progressBar.addEventListener ( Event.ENTER_FRAME , onLoop );

		tabBox.addContent ( "Progress" , tabContainer , margin );


		tabBox.toggleTab ( "Buttons" );

	}

	private var decrease:Boolean = false;
	private var progressBar:ProgressBar;

	private function onLoop ( e:Event ):void {
		var bar:ProgressBar = e.target as ProgressBar;
		if ( bar.value == 100 ) decrease = true;
		if ( bar.value == 0 ) decrease = false;
		bar.value += decrease ? - 1 : 1;
	}

}

}
