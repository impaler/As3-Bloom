package bloom.themes.defaultTheme {

import bloom.core.Bloom;
import bloom.core.ITheme;

public class DefaultTheme implements ITheme {

	public function initialize ():void {
		Bloom.core ().theme.Button_Model = new DefaultButtonModel ();
		Bloom.core ().theme.Container_Model = new DefaultContainerModel ();
		Bloom.core ().theme.Label_Model = new DefaultLabelModel ();
		Bloom.core ().theme.Window_Model = new DefaultWindowModel ();
	}

}
}
