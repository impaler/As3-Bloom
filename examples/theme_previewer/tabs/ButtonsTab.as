package theme_previewer.tabs {

import bloom.Button;
import bloom.Label;
import bloom.brushes.ColorBrush;
import bloom.brushes.TextBrush;
import bloom.containers.FlowContainer;
import bloom.containers.ScrollContainer;

import flash.events.MouseEvent;

public class ButtonsTab extends ScrollContainer {

	private var _labelTitle:Label;

	private var _button_00_counter:Number;

	private var _button_01:Button;

	public function ButtonsTab () {

		this.direction = ScrollContainer.VERTICALLY;
		this.brush = brush;

		// Tab Content margins
		this.margin.reset ( 4 , 4 , 0 , 0 );

		var container:FlowContainer = new FlowContainer ( content );
		container.registerComponent = false;
		container.margin.reset ( 0 , 0 , 0 , 0 );
		container.direction = FlowContainer.HORIZONTALLY;
		container.size ( 200 , 40 );

		var button_00:Button = new Button ( container , "Button" , onButton_00_Handler );
		button_00.size ( 120 , 40 );
		_labelTitle = new Label ( container , "" );
		_button_00_counter = 1;

		var but:Button = new Button ( content , "Disabled" );
		but.size ( 120 , 40 );
		but.enabled = false;

		_button_01 = new Button ( content , ":)" , onButton_01_Handler );
		_button_01.title.brush = new TextBrush ( "Verdana" , 70 , 0x000000 , false , false , false );
		_button_01.size ( 260 , 260 );

	}

	private function onButton_00_Handler ( e:MouseEvent ):void {
		_labelTitle.text = "Clicked " + String ( _button_00_counter );
		_button_00_counter ++;
	}

	private function onButton_01_Handler ( e:MouseEvent ):void {
		_button_01.title.text == "^_^" ? _button_01.title.text = ":)" : _button_01.title.text = "^_^";

	}

}
}
