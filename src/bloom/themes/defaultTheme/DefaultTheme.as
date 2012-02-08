package bloom.themes.defaultTheme {

import bloom.core.ITheme;
import bloom.core.ThemeBase;

public class DefaultTheme implements ITheme {

	public function initialize (themBase:ThemeBase):void {
		themBase.Button_Model = new DefaultButtonModel ();
		themBase.Container_Model = new DefaultContainerModel ();
		themBase.Label_Model = new DefaultLabelModel ();
		themBase.Window_Model = new DefaultWindowModel ();
		themBase.AlertWindow_Model = new DefaultAlertWindowModel();
	}

}
}
