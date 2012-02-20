package bloom.components 
{
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import bloom.control.Bloom;
	import bloom.themes.default.ButtonStyle;
	
	/**
	 * Button
	 */
	public class Button extends ButtonBase {
		
		private var _title:Label;
		private var _icon:DisplayObjectContainer;
		
		public function Button(p:DisplayObjectContainer = null, text:String = "", icon_:DisplayObjectContainer = null) {
			super(p);
			
			_title = new Label(this, text);
			_title.onTextChange.add( onTitleChanged );
			
			icon = icon_;
			
			style = Bloom.theme.button;
		}
		
		protected function onTitleChanged(title:String):void {
			_title.move((_width - _title.width) * 0.5, (_height - _title.height) * 0.5);
		}
		
		override protected function onThemeChanged():void {
			style = Bloom.theme.button;
		}
		
		override protected function draw(e:Event):void {
			if (_changed) {
				_changed = false;
			} else {
				return;
			}
			
			super.draw(e);
			
			if (!_title) return;
			
			buttonStyle.backgroundBrush.update ( _state , _bg , dimensionObject );
			buttonStyle.textStyle.update( _state, _title );
			
			_title.move((_width - _title.width) * 0.5, (_height - _title.height) * 0.5);
		}
		
		///////////////////////////////////
		// getter/setters
		///////////////////////////////////
		
		public function set icon(value:DisplayObjectContainer):void {
			if ( value != null ) {
				_icon = value;
				this.addChild(_icon);
				
				_changed = true;
				invalidate();
			}
		}
		
		public function get title():Label {
			return _title;
		}
		
		public function get buttonStyle():ButtonStyle {
			return _style as ButtonStyle;
		}
		
		
		
		///////////////////////////////////
		// toString
		///////////////////////////////////
		
		override public function toString():String {
			return "[bloom.components.Button]";
		}
		
		override public function destroy () : void {
			super.destroy();
			
			_title.destroy();
			_title = null;
		}
		
	}

}