package bloom.core {

/**
 * IStyle
 */
public interface IStyle {

	function dispose (gc:Boolean = false):void;

	function update (value:IComponent):void;

	function toString ():String;

}

}
