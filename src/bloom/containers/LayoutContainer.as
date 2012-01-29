package bloom.containers {

import bloom.core.Component;
import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.Sprite;
import flash.events.Event;

public class LayoutContainer extends FlowContainer {
	
	private var _contentParent:Sprite;
	
	public static const CENTER:int = 0;
	public static const LEFT:int = 1;
	public static const RIGHT:int = 2;
	
	protected var _hAlignment:int;

	public function LayoutContainer ( p:DisplayObjectContainer = null ) {
		super ( p );

		_contentParent = new Sprite ();
		addChild ( _contentParent );
		
		_hAlignment = CENTER;

		_target = _contentParent;
	}

	public function addContent ( p:DisplayObject ):void {
		_target.addChild ( p ); 
		
		//needed for everything to have correct values for first render
		if ( p is Component ) {
			var comp:Component = p as Component;
			comp.drawDirectly();
		}
		
		_changed = true;
		invalidate();
		dispatchEvent(new Event("resize"));
		drawDirectly(); 

	}

	override protected function draw ( e:Event ):void {
		super.draw ( e );

		switch ( _hAlignment ) {
			case CENTER:
				_target.x = ((this.width * .5) - (_target.width * .5)) - margin.left;
				break;
			case LEFT:
				_target.x = 0 + margin.left;
				break;
			case RIGHT:
				_target.x = this.width - (_target.width +margin.left) - margin.right;
				break;			
		}
		
	}

}
}
