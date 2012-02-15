package bloom.control
{
	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	/**
	 * ObjectPool
	 * <p>Reference: Richard Lord's uk.co.bigroom.utils</p>
	 */
	public class ObjectPool {
		
		public static var pools:Dictionary = new Dictionary();
		
		public static function getObject(c:Class):* {
			var tmp:Array = c in pools ? pools[c] : pools[c] = new Array();
			return tmp.length > 0 ? tmp.pop() : new c();
		}
		
		public static function returnObject(object:*, c:Class = null):void {
			if (!c) c = getClassName(object);
			var tmp:Array = c in pools ? pools[c] : pools[c] = new Array();
			tmp.push(object);
		}
		
		public static function getClassName(object:*):Class {
			return getDefinitionByName(getQualifiedClassName(object)) as Class;
		}
		
	}

}
