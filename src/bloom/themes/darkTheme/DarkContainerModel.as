package bloom.themes.darkTheme {

import bloom.brushes.ColorBrush;
import bloom.containers.Container;
import bloom.containers.ContainerModel;

public class DarkContainerModel extends ContainerModel {
	public function DarkContainerModel () {
		defaultWidth  = 600;
		defaultHeight  = 200;

		var data = new Vector.<uint>(1, true);
		data[Container.BG] = 0x000000;
		brush = new ColorBrush(data);
	}
}
}
