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
import bloom.containers.*;
import bloom.themes.*;

import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.events.MouseEvent;

/**
 * HelloWorld
 *
 * @author sindney
 */
[SWF(backgroundColor=0x000000 , frameRate=40 , width=200 , height=620)]
public class HelloWorld extends Sprite {

	public function HelloWorld () {
		super ();
		stage.align = StageAlign.TOP_LEFT;
		stage.scaleMode = StageScaleMode.NO_SCALE;
		stage.showDefaultContextMenu = false;

		// setup theme first, we use colorTheme for example.
		ThemeBase.setTheme ( new ColorTheme () );

		// flow container object.
		var flowContainer:FlowContainer = new FlowContainer ( this );
		flowContainer.direction = FlowContainer.VERTICALLY;
		flowContainer.move ( 10 , 10 );
		flowContainer.size ( 150 , 600 );

		var label:Label = new Label ( flowContainer , "I'm a Label" );
		// use component.margin to place object.
		label.margin.reset ( 5 , 5 , 0 , 5 );

		var button:Button = new Button ( flowContainer , "I'm a Button" , onButtonClick );

		var checkBox:CheckBox = new CheckBox ( flowContainer , "I'm a CheckBox" , true );
		checkBox.addEventListener ( Event.CHANGE , onCheckBoxChanged );

		// with checkboxgroup, you can easily link a group of checkbox object(and he who extends checkbox).
		// set checkBoxGroup.index = -1 means there's no checkbox object currently.
		var checkBoxGroup:CheckBoxGroup = new CheckBoxGroup ( - 1 );

		checkBox = new CheckBox ( flowContainer , "CheckBox 0" );
		checkBoxGroup.addChild ( checkBox );

		checkBox = new CheckBox ( flowContainer , "CheckBox 1" );
		checkBoxGroup.addChild ( checkBox );

		checkBox = new CheckBox ( flowContainer , "CheckBox 2" );
		checkBoxGroup.addChild ( checkBox );

		// set target checkbox
		checkBoxGroup.index = 0;
		checkBoxGroup.addEventListener ( Event.CHANGE , onCheckBoxGroupChanged );

		var numericStepper:NumericStepper = new NumericStepper ( flowContainer , 50 , 100 , - 100 , 10 );
		numericStepper.addEventListener ( Event.CHANGE , onNumericStepperChanged );

		var slider:Slider = new Slider ( flowContainer , Slider.HORIZONTALLY );
		slider = new Slider ( flowContainer , Slider.VERTICALLY );

		var textInput:TextInput = new TextInput ( flowContainer );
		var textBox:TextBox = new TextBox ( flowContainer );

		var toggleButton:ToggleButton = new ToggleButton ( flowContainer , "I'm a toggleButton" );
		toggleButton.size ( 140 , 20 );

		var toggleSwitcher:ToggleSwitcher = new ToggleSwitcher ( flowContainer , true );

		var progressBar:ProgressBar = new ProgressBar ( flowContainer , 50 );
	}

	private function onNumericStepperChanged ( e:Event ):void {
		trace ( "NumericStepper changed!" );
	}

	private function onCheckBoxGroupChanged ( e:Event ):void {
		trace ( "CheckBoxGroup changed!" );
	}

	private function onCheckBoxChanged ( e:Event ):void {
		trace ( "CheckBox changed!" );
	}

	private function onButtonClick ( e:MouseEvent ):void {
		trace ( "Button clicked!" );
	}

}

}
