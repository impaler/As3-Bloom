package bloom.themes.darkTheme {

import bloom.core.Bloom;
import bloom.core.ITheme;

public class DarkTheme implements ITheme {

	public function initialize ():void {
		Bloom.core ().theme.Button_Model = new DarkButtonModel ();
		Bloom.core ().theme.Container_Model = new DarkContainerModel ();
		Bloom.core ().theme.Label_Model = new DarkLabelModel ();
		Bloom.core ().theme.Window_Model = new DarkWindowModel ();
	}

}
}
