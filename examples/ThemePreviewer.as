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
import bloom.brushes.TextBrush;
import bloom.containers.*;
import bloom.core.Margin;
import bloom.themes.*;

import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;

/**
 * BMPExample
 *
 * @author sindney, impaler
 */
[SWF(backgroundColor=0xffffff , frameRate=40 , width=500 , height=500)]
public class ThemePreviewer extends Sprite {

    [Embed(source="background.jpg")]
    private var background:Class;

    public function ThemePreviewer () {
        stage.align = StageAlign.TOP_LEFT;
        stage.scaleMode = StageScaleMode.NO_SCALE;
        stage.showDefaultContextMenu = false;

        addChild ( new background () );

        ThemeBase.setTheme ( new BMPTheme () );

        // TabBox
        var tabBox:TabBox = new TabBox ( this );
        tabBox.size ( 300 , 200 );
        tabBox.move ( 40 , 40 );

        // Tab Content margins
        var margin:Margin = new Margin ( 4 , 4 , 0 , 0 );

        // Buttons Tab
        var flowContainer:FlowContainer = new FlowContainer ();
        flowContainer.direction = FlowContainer.VERTICALLY;

        var but:Button = new Button ( null , "Active Button" );
        but.size ( 120 , 40 );
        flowContainer.addChild ( but );

        var but:Button = new Button ( null , "Disabled Button" );
        but.size ( 120 , 40 );
        but.enabled = false;
        flowContainer.addChild ( but );

        var but:Button = new Button ( null , ":)" );
        but.size ( 40 , 120 );
        flowContainer.addChild ( but );

        var but:Button = new Button ( null , "Button" );
        but.size ( 120 , 120 );
        flowContainer.addChild ( but );

        tabBox.addContent ( "Buttons" , flowContainer , margin );

        // Labels Tab
        flowContainer = new FlowContainer ();
        flowContainer.direction = FlowContainer.VERTICALLY;

        var label:Label = new Label ( null , "I am a Label" );
        flowContainer.addChild ( label );

        label = new Label ( null , "Large Text" );
        label.brush = new TextBrush ( "Verdana" , 30 , 0x000000 , false , false , false );
        flowContainer.addChild ( label );

        tabBox.addContent ( "Labels" , flowContainer , margin );

        // Sliders Tab
        var scrollContainer = new FlowContainer ();
        scrollContainer.direction = FlowContainer.VERTICALLY;

        var slide:Slider = new Slider ( scrollContainer );
        slide.size ( 30 , 100 );

        var slide:Slider = new Slider ( scrollContainer );
        slide.size ( 30 , 100 );
        slide.enabled = false;

        slide = new Slider ( scrollContainer , 1 , 50 );
        slide.size ( 100 , 30 );

        slide = new Slider ( scrollContainer , 1 , 50 );
        slide.size ( 100 , 30 );
        slide.enabled = false;

        var slide:Slider = new Slider ( scrollContainer , Slider.VERTICALLY , 30 );
        slide.size ( 30 , 200 );

        var slide:Slider = new Slider ( scrollContainer , Slider.HORIZONTALLY , 30 );
        slide.size ( 200 , 30 );

        tabBox.addContent ( "Sliders" , scrollContainer , margin );

        // Numeric Stepper Tab
        flowContainer = new FlowContainer ();
        flowContainer.direction = FlowContainer.VERTICALLY;

        var stepper:NumericStepper = new NumericStepper ( flowContainer );

        var stepper:NumericStepper = new NumericStepper ( flowContainer );
        stepper.enabled = false;

        var stepper:NumericStepper = new NumericStepper ( flowContainer );
        stepper.textBase.brush = new TextBrush ( "Verdana" , 30 , 0x000000 , false , false , false );
        stepper.size ( 120 , 40 );

        tabBox.addContent ( "Steppers" , flowContainer , margin );

        // CheckBox
        flowContainer = new FlowContainer ();
        flowContainer.direction = FlowContainer.VERTICALLY;

        var checkBox:CheckBox = new CheckBox ( flowContainer , "CheckBox" );

        var checkBox:CheckBox = new CheckBox ( flowContainer , "CheckBox" );
        checkBox.enabled = false;

        // with checkboxgroup, you can easily link a group of checkbox object(and he who extends checkbox).
        // set checkBoxGroup.index = -1 means there's no checkbox object currently.
        var checkBoxGroup:CheckBoxGroup = new CheckBoxGroup ( - 1 );

        checkBox = new CheckBox ( flowContainer , "CheckBox Group Item 0" );
        checkBoxGroup.addChild ( checkBox );

        checkBox = new CheckBox ( flowContainer , "CheckBox Group Item 1" );
        checkBoxGroup.addChild ( checkBox );

        checkBox = new CheckBox ( flowContainer , "CheckBox Group Item 2" );
        checkBoxGroup.addChild ( checkBox );

        // set target checkbox
        checkBoxGroup.index = 1;
//			checkBoxGroup.addEventListener(Event.CHANGE, onCheckBoxGroupChanged);

        tabBox.addContent ( "CheckBoxes" , flowContainer , margin );

        // Text Tab
        flowContainer = new FlowContainer ();
        flowContainer.direction = FlowContainer.VERTICALLY;

        var textbox:TextBox = new TextBox ( flowContainer , "I am a textbox" );

        textbox = new TextBox ( flowContainer , "disabled :(" );
        textbox.enabled = false;

        textbox = new TextBox ( flowContainer , "Large Text ^_^" );
        textbox.textBase.brush = new TextBrush ( "Verdana" , 30 , 0x000000 , false , false , false );
        textbox.size ( 230 , 160 );

        var text:TextInput = new TextInput ( flowContainer , "Text Input" );

        text = new TextInput ( flowContainer , "disabled :(" );
        text.enabled = false;

        text = new TextInput ( flowContainer , "Wide o_O" );
        text.size ( 300 , 20 );

        tabBox.addContent ( "Text" , flowContainer , margin );

        // List Tab
        flowContainer = new FlowContainer ();
        flowContainer.direction = FlowContainer.VERTICALLY;

        var i:int;
        var data:Array = [];
        for ( i = 0 ; i < 10000 ; i ++ ) {
            data[i] = ["NO." + i.toString ()];
        }
        var list:List = new List ( flowContainer , data );

        var list:List = new List ( flowContainer , data );
        list.enabled = false;

        var list:List = new List ( flowContainer , data );
        list.size ( 200 , 100 );

        tabBox.addContent ( "List" , flowContainer , margin );

        // Toggle Tab
        flowContainer = new FlowContainer ();
        flowContainer.direction = FlowContainer.VERTICALLY;

        var toggleButton:ToggleButton = new ToggleButton ( flowContainer , "ToggleButton" );

        toggleButton = new ToggleButton ( flowContainer , "ToggleButton" );
        toggleButton.enabled = false;

        var toggleSwitcher:ToggleSwitcher = new ToggleSwitcher ( flowContainer , true );
        toggleSwitcher.width = 200;

        toggleSwitcher = new ToggleSwitcher ( flowContainer , true );
        toggleSwitcher.enabled = false;

        tabBox.addContent ( "Toggle" , flowContainer , margin );

        // Progress Tab
        flowContainer = new FlowContainer ();
        flowContainer.direction = FlowContainer.VERTICALLY;

        progressBar = new ProgressBar ( flowContainer , 0 );
        progressBar.addEventListener ( Event.ENTER_FRAME , onLoop );

        progressBar = new ProgressBar ( flowContainer , 0 );
        progressBar.enabled = false;

        progressBar = new ProgressBar ( flowContainer , 0 );
        progressBar.size ( 60 , 60 );
        progressBar.addEventListener ( Event.ENTER_FRAME , onLoop );

        progressBar = new ProgressBar ( flowContainer , 0 );
        progressBar.size ( 200 , 40 );
        progressBar.addEventListener ( Event.ENTER_FRAME , onLoop );

        tabBox.addContent ( "Progress" , flowContainer , margin );

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
