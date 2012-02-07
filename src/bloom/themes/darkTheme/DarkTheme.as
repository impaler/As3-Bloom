package bloom.themes.darkTheme {

import bloom.core.ComponentReg;
import bloom.core.ITheme;
import bloom.core.ThemeBase;

public class DarkTheme implements ITheme {

	public function initialize (themBase:ThemeBase):void {
		themBase.Button_Model = new DarkButtonModel ();
		themBase.Container_Model = new DarkContainerModel ();
		themBase.Label_Model = new DarkLabelModel ();
		themBase.Window_Model = new DarkWindowModel ();
	}

}
}
