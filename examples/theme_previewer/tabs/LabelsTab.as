/**
 * Created by IntelliJ IDEA.
 * User: omni
 * Date: 23/01/12
 * Time: 9:17 AM
 * To change this template use File | Settings | File Templates.
 */
package theme_previewer.tabs {

import bloom.Label;
import bloom.brushes.TextBrush;
import bloom.containers.ScrollContainer;

public class LabelsTab extends ScrollContainer {

	public function LabelsTab () {
		this.direction = ScrollContainer.VERTICALLY;
		this.brush = brush;
		this.margin.reset ( 4 , 4 , 0 , 0 );

		var label:Label = new Label ( content , "I am a Label" );

		label = new Label ( content , "Larger Text 0_0" );
		label.brush = new TextBrush ( "Verdana" , 70 , 0x000000 , false , false , false );

		var label:Label = new Label ( content , "check out my color!" );
		label.brush = new TextBrush ( "Arial" , 30 , 0xdd4400 , false , false , false );

	}

}
}
