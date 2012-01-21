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

import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;

/**
 * BMPExample
 *
 * @author sindney, impaler
 */
[SWF(backgroundColor = 0xffffff , frameRate = 40 , width = 700 , height = 500)]
public class ThemePreviewer extends Sprite {
	
    [Embed(source="background.jpg")]
    private var background:Class;
	
    public function ThemePreviewer () {
        stage.align = StageAlign.TOP_LEFT;
        stage.scaleMode = StageScaleMode.NO_SCALE;
        stage.showDefaultContextMenu = false;
		
        addChild ( new background () );
		
        ThemeBase.setTheme ( new BMPTheme () );
		//ThemeBase.setTheme ( new ColorTheme () );
		
        // TabBox
        var tabBox:TabBox = new TabBox ( this );
        tabBox.size ( 680 , 480 );
        tabBox.move ( 10 , 10 );
		
        // Tab Content margins
        var margin:Margin = new Margin ( 4 , 4 , 0 , 0 );
		
		var color:Vector.<uint> = new Vector.<uint>(1, true);
		color[0] = 0xE9E9E9;
		var brush:ColorBrush = new ColorBrush(color);
		
		var scrollContainer:ScrollContainer = new ScrollContainer();
		scrollContainer.direction = ScrollContainer.VERTICALLY;
		scrollContainer.brush = brush;
		
        // Buttons Tab
        var but:Button = new Button ( scrollContainer.content , "Active Button" );
        but.size ( 120 , 40 );
		
        but = new Button ( scrollContainer.content , "Disabled Button" );
        but.size ( 120 , 40 );
        but.enabled = false;
		
        but = new Button ( scrollContainer.content , ":)" );
        but.size ( 40 , 120 );
		
        but = new Button ( scrollContainer.content , "Button" );
        but.size ( 120 , 120 );
		
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