package bloom.themes 
{
	import bloom.styles.*;
	
	/**
	 * ITheme
	 */
	public interface ITheme {
		
		function get alpha():Number;
		
		function get buttonBase():ButtonBaseStyle;
		
		function get label():TextStyle;
		
	}
	
}