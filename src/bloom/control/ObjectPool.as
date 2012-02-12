package bloom.control {

import flash.utils.Dictionary;
import flash.utils.getDefinitionByName;
import flash.utils.getQualifiedClassName;

/**
 * ObjectPool
 * <p>Reference: Richard Lord's uk.co.bigroom.utils</p>
 */
public class ObjectPool {

	private var _pools:Dictionary;

	public function ObjectPool () {
		reset ();
	}

	public function getObject ( c:Class ):* {
		var tmp:Array = c in _pools ? _pools[c] : _pools[c] = new Array ();
		return tmp.length > 0 ? tmp.pop () : new c ();
	}

	public function returnObject ( o:* , c:Class = null ):void {
		if ( c == null ) {
			c = getDefinitionByName ( getQualifiedClassName ( o ) ) as Class;
		}
		var tmp:Array = c in _pools ? _pools[c] : _pools[c] = new Array ();
		tmp.push ( o );
	}

	public function reset ():void {
		_pools = new Dictionary ();
	}

}

}
