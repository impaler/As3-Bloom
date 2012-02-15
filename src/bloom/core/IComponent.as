package bloom.core 
{
	
	/**
	 * IComponent
	 */
	public interface IComponent extends IChild {
		
		function move(x:Number, y:Number):void;
		
		function size(w:Number, h:Number):void;
		
		function set enabled(value:Boolean):void;
		function get enabled():Boolean;
		
		function toString():String;
		
	}
	
}