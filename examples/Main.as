package 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	
	import bloom.control.ThemeBase;
	import bloom.components.*;
	import bloom.themes.BlueTheme;
	
	public class Main extends Sprite {
		
		public function Main():void {
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			stage.showDefaultContextMenu = false;
			stage.scaleMode = "noScale";
			stage.align = "TL";
			
			// first, there's no need to hurry.
			// we should make every basic things stable and perfect, then we start to port old comps to bloom.
			
			ThemeBase.initialize(stage);
			ThemeBase.theme = new BlueTheme();
			
			// in the future, we can change themes like this.
			// var blue:ITheme = new BlueTheme();
			// var white:ITheme = new WhiteTheme();
			// ThemeBase.theme = blue;
			// Themebase.theme = white;
			// we provide one blueTheme in bloom, and we can provide other themes out side of bloom.
			// we can create a themes folder like src/examples.
			// selective complie is simple. BlueTheme for example. Just extends it as SimpleBlueTheme.
			// then copy those comps in BlueTheme's constructor you need to SimpleBlueTheme's constructure(remeber not to use super()), then it's done.
			
			var label:Label = new Label(this, "Label");
			var buttonBase:ButtonBase = new ButtonBase(this);
			buttonBase.move(0, 20);
			buttonBase = new ButtonBase(this);
			buttonBase.state = ButtonBase.OVER;
			buttonBase.move(0, 50);
			buttonBase = new ButtonBase(this);
			buttonBase.state = ButtonBase.DOWN;
			buttonBase.move(0, 80);
		}
		
	}
	
}