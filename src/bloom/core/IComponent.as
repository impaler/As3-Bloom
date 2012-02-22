package bloom.core 
{
	import org.osflash.signals.Signal;
	
	/**
	 * IComponent
	 */
	public interface IComponent extends IObjectBase {
		
		function drawDirectly():void;
		
		function destroy():void;
		
		function move(x:Number, y:Number):void;
		
		function size(w:Number, h:Number):void;
		
		function set enabled(value:Boolean):void;
		function get enabled():Boolean;
		
		function toString():String;
	}
	
}