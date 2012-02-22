package bloom.themes 
{
	import bloom.styles.*;
	
	/**
	 * ITheme
	 */
	public interface ITheme {
		
		function get alpha():Number;
		
		function get buttonBase():ButtonBaseStyle;
		
		function get button():ButtonStyle;
		
		function get label():TextStyle;
		
	}
	
}