package com.somerandomdude.coordy.utils;

import com.somerandomdude.coordy.layouts.ICoreLayout;

interface ILayoutTransitioner{
	function syncNodesTo(l:ICoreLayout=null):Void;
}