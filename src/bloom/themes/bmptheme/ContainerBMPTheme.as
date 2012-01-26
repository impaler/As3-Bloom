package bloom.themes.bmptheme {

import bloom.brushes.ColorBrush;
import bloom.themes.ITheme;
import bloom.themes.ThemeBase;

public class ContainerBMPTheme implements ITheme {

	public function initialize ():void {

		var uint_data:Vector.<uint>;

		var BGCOLOR:int = 0;

		uint_data = new Vector.<uint> ( 1 , true );
		uint_data[BGCOLOR] = 0xE9E9E9;
		ThemeBase.Container = new ColorBrush ( uint_data );

	}
}
}
