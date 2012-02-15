package bloom.core 
{
	
	/**
	 * IChild
	 */
	public interface IChild {
		
		function set x(value:Number):void;
		function get x():Number;
		
		function set y(value:Number):void;
		function get y():Number;
		
		function set width(value:Number):void;
		function get width():Number;
		
		function set height(value:Number):void;
		function get height():Number;
		
		function get margin():Margin;
		
	}
	
}