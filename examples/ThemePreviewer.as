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

import avmplus.factoryXml;

import bloom.*;
import bloom.brushes.ColorBrush;
import bloom.brushes.TextBrush;
import bloom.containers.*;
import bloom.core.Margin;
import bloom.themes.*;

import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.events.MouseEvent;

/**
 * BMPExample
 *
 * @author sindney, impaler
 */
[SWF(backgroundColor = 0xffffff , frameRate = 40 , width = 700 , height = 500)]
public class ThemePreviewer extends Sprite {

    [Embed(source="background.jpg")]
    private var background:Class;
    private var _themetoggle:Number = 1;

    private var _enableButton:Button;
    private var _enabled:Boolean = true;

    public function ThemePreviewer () {
        stage.align = StageAlign.TOP_LEFT;
        stage.scaleMode = StageScaleMode.NO_SCALE;
        stage.showDefaultContextMenu = false;

        addChild ( new background () );

        ThemeBase.registerComponents = true;
        ThemeBase.setTheme ( new BMPTheme () );
		//ThemeBase.setTheme ( new ColorTheme () );

        var container:FlowContainer = new FlowContainer(this);
        container.registerComponent = false;
        container.direction = FlowContainer.HORIZONTALLY;

        _enableButton = new Button ( container , "Disable All Components" );
        _enableButton.registerComponent = false;
        _enableButton.size ( 300 , 40 );
        _enableButton.addEventListener(MouseEvent.MOUSE_DOWN , DisableComponents );

        // Buttons Tab
        var but:Button = new Button ( container , "BMP" );
        but.size ( 120 , 40 );
        but.registerComponent = false;
        but.addEventListener(MouseEvent.MOUSE_DOWN , BMPThemeChange );

        var but:Button = new Button ( container , "Color" );
        but.size ( 120 , 40 );
        but.registerComponent = false;
        but.addEventListener(MouseEvent.MOUSE_DOWN , ColorThemeChange );


        var container:FlowContainer = new FlowContainer();

        // TabBox
        var tabBox:TabBox = new TabBox ( container );

        var window:Window = new Window(this, container);
        window.liveResize = true;
        window.footerSize = 20;
        window.size(680, 480);
        window.move(100, 150);
        window.resizeable = false;
        tabBox.size ( container.width , container.height );

        //todo with tab size
        window.addEventListener(Event.RESIZE , updateContainer );
        window.resizeable = true;

        function updateContainer ( event:Event ):void {
            tabBox.size ( container.width , container.height );
        }

        // Tab Content margins
        var margin:Margin = new Margin ( 4 , 4 , 0 , 0 );

		var color:Vector.<uint> = new Vector.<uint>(1, true);
		color[0] = 0xE9E9E9;
		var brush:ColorBrush = new ColorBrush(color);

		var scrollContainer:ScrollContainer = new ScrollContainer();
		scrollContainer.direction = ScrollContainer.VERTICALLY;
		scrollContainer.brush = brush;

//        var i:int;
//        var data:Array = [];
//        for ( i = 0 ; i < 100 ; i ++ ) {
//            but = new Button ( scrollContainer.content , "Disabled Button" );
//            but.size ( 120 , 40 );
//            but.enabled = false;
//        }

        var but:Button = new Button ( scrollContainer.content , "Disabled Button" );
        but.size ( 20 , 20 );
        but.enabled = false;

        but = new Button ( scrollContainer.content , ":)" );
        but.size ( 260 , 260 );

        tabBox.addContent ( "Buttons" , scrollContainer , margin );
		scrollContainer.calculateContentSize();

        // Labels Tab
        scrollContainer = new ScrollContainer();
		scrollContainer.direction = ScrollContainer.VERTICALLY;
		scrollContainer.brush = brush;

        var label:Label = new Label ( scrollContainer.content , "I am a Label" );

        label = new Label ( scrollContainer.content , "Large Text" );
        label.brush = new TextBrush ( "Verdana" , 30 , 0x000000 , false , false , false );

        tabBox.addContent ( "Labels" , scrollContainer , margin );
		scrollContainer.calculateContentSize();

        // Sliders Tab
        scrollContainer = new ScrollContainer();
		scrollContainer.direction = ScrollContainer.VERTICALLY;
		scrollContainer.brush = brush;

        var slide:Slider = new Slider ( scrollContainer.content );
        slide.size ( 30 , 100 );

        slide = new Slider ( scrollContainer.content );
        slide.size ( 30 , 100 );
        slide.enabled = false;

        slide = new Slider ( scrollContainer.content , 1 , 50 );
        slide.size ( 100 , 30 );

        slide = new Slider ( scrollContainer.content , 1 , 50 );
        slide.size ( 100 , 30 );
        slide.enabled = false;

        slide = new Slider ( scrollContainer.content , Slider.VERTICALLY , 30 );
        slide.size ( 30 , 200 );

        slide = new Slider ( scrollContainer.content , Slider.HORIZONTALLY , 30 );
        slide.size ( 200 , 30 );

        tabBox.addContent ( "Sliders" , scrollContainer , margin );
		scrollContainer.calculateContentSize();

        // Numeric Stepper Tab
        scrollContainer = new ScrollContainer();
		scrollContainer.direction = ScrollContainer.VERTICALLY;
		scrollContainer.brush = brush;

        var stepper:NumericStepper = new NumericStepper ( scrollContainer.content );

        stepper = new NumericStepper ( scrollContainer.content );
        stepper.enabled = false;

        stepper = new NumericStepper ( scrollContainer.content );
        stepper.textBase.brush = new TextBrush ( "Verdana" , 30 , 0x000000 , false , false , false );
        stepper.size ( 120 , 40 );

        tabBox.addContent ( "Steppers" , scrollContainer , margin );
		scrollContainer.calculateContentSize();

        // CheckBox
        scrollContainer = new ScrollContainer();
		scrollContainer.direction = ScrollContainer.VERTICALLY;
		scrollContainer.brush = brush;

        var checkBox:CheckBox = new CheckBox ( scrollContainer.content , "CheckBox" );

        checkBox = new CheckBox ( scrollContainer.content , "CheckBox" );
        checkBox.enabled = false;

        // with checkboxgroup, you can easily link a group of checkbox object(and he who extends checkbox).
        // set checkBoxGroup.index = -1 means there's no checkbox object currently.
        var checkBoxGroup:CheckBoxGroup = new CheckBoxGroup ( - 1 );

        checkBox = new CheckBox ( scrollContainer.content , "CheckBox Group Item 0" );
        checkBoxGroup.addChild ( checkBox );

        checkBox = new CheckBox ( scrollContainer.content , "CheckBox Group Item 1" );
        checkBoxGroup.addChild ( checkBox );

        checkBox = new CheckBox ( scrollContainer.content , "CheckBox Group Item 2" );
        checkBoxGroup.addChild ( checkBox );

        // set target checkbox
        checkBoxGroup.index = 0;

        tabBox.addContent ( "CheckBoxes" , scrollContainer , margin );
		scrollContainer.calculateContentSize();

        // Text Tab
        scrollContainer = new ScrollContainer ();
		scrollContainer.direction = ScrollContainer.VERTICALLY;
		scrollContainer.brush = brush;

        var textbox:TextBox = new TextBox ( scrollContainer.content , "I am a textbox" );

        textbox = new TextBox ( scrollContainer.content , "disabled :(" );
        textbox.enabled = false;

        textbox = new TextBox ( scrollContainer.content , "Large Text ^_^" );
        textbox.textBase.brush = new TextBrush ( "Verdana" , 30 , 0x000000 , false , false , false );
        textbox.size ( 230 , 160 );

        var text:TextInput = new TextInput ( scrollContainer.content , "Text Input" );

        text = new TextInput ( scrollContainer.content , "disabled :(" );
        text.enabled = false;

        text = new TextInput ( scrollContainer.content , "Wide o_O" );
        text.size ( 300 , 20 );

        tabBox.addContent ( "Text" , scrollContainer , margin );
		scrollContainer.calculateContentSize();

        // List Tab
        scrollContainer = new ScrollContainer();
		scrollContainer.direction = ScrollContainer.VERTICALLY;
		scrollContainer.brush = brush;

        var i:int;
        var data:Array = [];
        for ( i = 0 ; i < 10000 ; i ++ ) {
            data[i] = ["NO." + i.toString ()];
        }
        var list:List = new List ( scrollContainer.content , data );

        list = new List ( scrollContainer.content , data );
        list.enabled = false;

        list = new List ( scrollContainer.content , data );
        list.size ( 200 , 100 );

        tabBox.addContent ( "List" , scrollContainer , margin );
		scrollContainer.calculateContentSize();

        // Toggle Tab
        scrollContainer = new ScrollContainer();
		scrollContainer.direction = ScrollContainer.VERTICALLY;
		scrollContainer.brush = brush;

        var toggleButton:ToggleButton = new ToggleButton ( scrollContainer.content , "ToggleButton" );

        toggleButton = new ToggleButton ( scrollContainer.content , "ToggleButton" );
        toggleButton.enabled = false;

        var toggleSwitcher:ToggleSwitcher = new ToggleSwitcher ( scrollContainer.content , true );
        toggleSwitcher.width = 200;

        toggleSwitcher = new ToggleSwitcher ( scrollContainer.content , true );
        toggleSwitcher.enabled = false;

        tabBox.addContent ( "Toggle" , scrollContainer , margin );
		scrollContainer.calculateContentSize();

        // Progress Tab
        scrollContainer = new ScrollContainer();
		scrollContainer.direction = ScrollContainer.VERTICALLY;
		scrollContainer.brush = brush;

        progressBar = new ProgressBar ( scrollContainer.content , 0 );
        progressBar.addEventListener ( Event.ENTER_FRAME , onLoop );

        progressBar = new ProgressBar ( scrollContainer.content , 0 );
        progressBar.enabled = false;

        progressBar = new ProgressBar ( scrollContainer.content , 0 );
        progressBar.size ( 60 , 60 );
        progressBar.addEventListener ( Event.ENTER_FRAME , onLoop );

        progressBar = new ProgressBar ( scrollContainer.content , 0 );
        progressBar.size ( 200 , 40 );
        progressBar.addEventListener ( Event.ENTER_FRAME , onLoop );

        tabBox.addContent ( "Progress" , scrollContainer , margin );
		scrollContainer.calculateContentSize();

        tabBox.toggleTab ( "Buttons" );

    }

    //This is perfect for the focus of the application in a browser or mobile to minimize cpu when inactive
    //could implement removing listeners and then reapplying them for saving memory

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

    private function DisableComponents ( event:MouseEvent ):void {
        _enabled ? _enabled = false : _enabled = true;
        _enabled ? _enableButton.title.text = "Disable All Components" : _enableButton.title.text = "Enable All Components";
        ThemeBase.enableComponents( _enabled );
    }

    private function BMPThemeChange ( event:MouseEvent ):void {
         ThemeBase.setTheme ( new BMPTheme() );
    }

    private function ColorThemeChange ( event:MouseEvent ):void {
         ThemeBase.setTheme ( new ColorTheme () );
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
