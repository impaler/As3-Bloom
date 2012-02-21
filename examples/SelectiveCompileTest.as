package {

import bloom.components.ButtonBase;
import bloom.control.BloomCore;
import bloom.core.ThemeBase;
import bloom.style.ButtonBaseStyle;
import bloom.themes.defaultTheme.DefaultButtonBaseStyle;

import flash.display.Sprite;
import flash.events.Event;

public class SelectiveCompileTest extends Sprite {
	public function SelectiveCompileTest():void {
		if (stage) init();
		else addEventListener(Event.ADDED_TO_STAGE, init);
	}
		
	private function init(e:Event = null):void {
		removeEventListener(Event.ADDED_TO_STAGE, init);
		stage.showDefaultContextMenu = false;
		stage.scaleMode = "noScale";
		stage.align = "TL";
		
		
		var ButtonBaseOnlyTheme:ThemeBase = new ThemeBase();
		ButtonBaseOnlyTheme.buttonBase = DefaultButtonBaseStyle;
		ButtonBaseOnlyTheme.disabledAlpha = .5;
		
		
		BloomCore.init(stage , ButtonBaseOnlyTheme);
		
		var btnbase:ButtonBase = new ButtonBase(this);
		
		
	}
}
}
