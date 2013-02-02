package omni.components.core;

import omni.components.core.interfaces.IDestroyable;
import omni.components.core.interfaces.IStyle;
import nme.system.System;

import omni.components.style.OBaseStyle;

/**
 * OTheme
 */
class OTheme implements IDestroyable
{

	public function new()
	{
		_stylesHash = new Hash();
	}

	var _stylesHash:Hash<OBaseStyle>;

	public var themeName(getThemeName, null):String;

	public function getThemeName():String
	{
		return Type.getClassName(Type.getClass(this));
	}

	public function addStyle(style:Class<OBaseStyle>):Void
	{
		var styleInstance:OBaseStyle = Type.createInstance(style, []);
		_stylesHash.set(styleInstance.styleID, styleInstance);
	}

	public function getStyle(styleID:String):OBaseStyle
	{
		var styleInstance:OBaseStyle = cast ( _stylesHash.get(styleID), OBaseStyle);
		return styleInstance;
	}

	public function destroy():Void
	{
		for(style in _stylesHash)
		{
			style.destroy();
		}
		_stylesHash = null;
	}

}


