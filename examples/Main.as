package {

import bloom.core.OmniCore;
import bloom.themes.darkBasic.DarkBasicTheme;

import com.demonsters.debugger.MonsterDebugger;

import flash.display.Sprite;
import flash.events.Event;

import theme_previewer.tabs.TabWindowTest;

public class Main extends Sprite {

	public function Main ():void {
		if (stage) init (); else addEventListener (Event.ADDED_TO_STAGE,init);
	}

	private function init (e:Event = null):void {
		removeEventListener (Event.ADDED_TO_STAGE,init);
		stage.showDefaultContextMenu = false;
		stage.scaleMode = "noScale";
		stage.align = "TL";

		OmniCore.init (stage,DarkBasicTheme);
//		OmniCore.init (stage,BlueTheme);

		MonsterDebugger.initialize (this);
		MonsterDebugger.trace (this,"Hello World!");

//		var thing:TabContainers = new TabContainers ();
//		addChild (thing);

//		var thing:TabButtons = new TabButtons ();
//		addChild (thing);

		var thing:TabWindowTest = new TabWindowTest();
		addChild(thing);

//		var thing:TabScrollContainers = new TabScrollContainers();
//		addChild(thing);

//		var thing:TabSliders = new TabSliders ();
//		addChild (thing);


//		var thing:TitleBar = new TitleBar("Title Bar Title");
//		addChild(thing);
//

	}

}

}
