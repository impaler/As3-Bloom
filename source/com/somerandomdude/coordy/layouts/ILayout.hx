package com.somerandomdude.coordy.layouts;

import com.somerandomdude.coordy.nodes.INode;
import com.somerandomdude.coordy.proxyupdaters.IProxyUpdater;


interface ILayout implements ICoreLayout {
	
	public var updateMethod(default,set_updateMethod):String;
	private var proxyUpdater(default,set_proxyUpdater):IProxyUpdater;
		
	function executeUpdateMethod():Void;
}