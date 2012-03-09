package bloom.components 
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	
	import bloom.styles.ButtonBaseStyle;
	
	/**
	 * IconButton
	 */
	public class IconButton extends ButtonBase {
		
		private var _iconNormal:DisplayObject;
		private var _iconOver:DisplayObject;
		private var _iconDown:DisplayObject;
		
		public function IconButton(p:DisplayObjectContainer = null) {
			super(p);
		}
		
		override public function dispose():void {
			super.dispose();
			removeIcons();
			_iconNormal = null;
			_iconOver = null;
			_iconDown = null;
		}
		
		protected function removeIcons():void {
			if (_iconNormal && _iconNormal.parent) removeChild(_iconNormal);
			if (_iconOver && _iconOver.parent) removeChild(_iconOver);
			if (_iconDown && _iconDown.parent) removeChild(_iconDown);
		}
		
		override protected function draw(e:Event):void {
			super.draw(e);
			removeIcons();
			switch(state){
				case NORMAL:
					if (_iconNormal) {
						_iconNormal.x = (_width - _iconNormal.width) * 0.5;
						_iconNormal.y = (_height - _iconNormal.height) * 0.5;
						addChild(_iconNormal);
					}
					break;
				case OVER:
					if (_iconOver) {
						_iconOver.x = (_width - _iconOver.width) * 0.5;
						_iconOver.y = (_height - _iconOver.height) * 0.5;
						addChild(_iconOver);
					}
					break;
				case DOWN:
					if (_iconDown) {
						_iconDown.x = (_width - _iconDown.width) * 0.5;
						_iconDown.y = (_height - _iconDown.height) * 0.5;
						addChild(_iconDown);
					}
					break;
			}
		}
		
		///////////////////////////////////
		// getter/setters
		///////////////////////////////////
		
		public function get iconNormal():DisplayObject {
			return _iconNormal;
		}
		
		public function set iconNormal(value:DisplayObject):void {
			if (_iconNormal != value) {
				if (_iconNormal && _iconNormal.parent) removeChild(_iconNormal);
				_iconNormal = value;
				_changed = true;
				invalidate();
			}
		}
		
		public function get iconOver():DisplayObject {
			return _iconOver;
		}
		
		public function set iconOver(value:DisplayObject):void {
			if (_iconOver != value) {
				if (_iconOver && _iconOver.parent) removeChild(_iconOver);
				_iconOver = value;
				_changed = true;
				invalidate();
			}
		}
		
		public function get iconDown():DisplayObject {
			return _iconDown;
		}
		
		public function set iconDown(value:DisplayObject):void {
			if (_iconDown != value) {
				if (_iconDown && _iconDown.parent) removeChild(_iconDown);
				_iconDown = value;
				_changed = true;
				invalidate();
			}
		}
		
		///////////////////////////////////
		// toString
		///////////////////////////////////
		
		public override function toString():String {
			return "[bloom.components.IconButton]";
		}
	}

}