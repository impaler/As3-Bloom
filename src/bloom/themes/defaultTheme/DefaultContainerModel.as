package bloom.themes.defaultTheme {

import bloom.brushes.ColorBrush;
import bloom.containers.Container;
import bloom.containers.ContainerModel;

public class DefaultContainerModel extends ContainerModel {
	public function DefaultContainerModel () {
		defaultWidth = 200;
		defaultHeight = 200;

		var data = new Vector.<uint> ( 1 , true );
		data[Container.BG] = 0xE9E9E9;
		brush = new ColorBrush ( data );
	}
}
}
