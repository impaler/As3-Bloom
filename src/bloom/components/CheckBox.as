package bloom.components 
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import org.osflash.signals.Signal;
	
	import bloom.control.Bloom;
	import bloom.core.Component;
	import bloom.themes.default.CheckBoxStyle;
	
	[Event(name = "change", type = "flash.events.Event")]
	
	/**
	 * CheckBox
	 */
	public class CheckBox extends Component {
		
		protected var _value:Boolean;
		protected var _title:Label;
		protected var _bg:Shape;
		
		protected var _onChanged:Signal;
		
		public function CheckBox(p:DisplayObjectContainer = null, text:String = "", value:Boolean = false) {
			super(p);
			
			tabChildren = tabEnabled = false;
            buttonMode = true;
			
			_bg = new Shape();
			addChild(_bg);
			
			_title = new Label(this, text);
			_title.addEventListener(Event.CHANGE, onTitleChanged);
			
			_onChanged = new Signal(Boolean);
			
			_value = value;
			
			style = Bloom.theme.checkBox;
			
			size(100, 20);
			
			addEventListener(MouseEvent.CLICK, onMouseClick);
			Bloom.onThemeChanged.add(onThemeChanged);
		}
		
		protected function onTitleChanged(e:Event):void {
			_title.move(20, (20 - _title.height) * 0.5);
		}
		
		protected function onThemeChanged():void {
			style = Bloom.theme.buttonBase;
		}
		
		override protected function draw(e:Event):void {
			if (_changed) {
				_changed = false;
			} else {
				return;
			}
			
			var style:CheckBoxStyle = _style as CheckBoxStyle;
			
			_bg.graphics.clear();
			_bg.graphics.beginBitmapFill(_value ? style.selected.bitmapData : style.normal.bitmapData);
			_bg.graphics.drawRect(0, 0, 20, 20);
			_bg.graphics.endFill();
			
			_title.style = _value ? style.title_selected : style.title_normal;
			_title.move(20, (20 - _title.height) * 0.5);
		}
		
		private function onMouseClick(e:MouseEvent):void {
			value = !_value;
		}
		
		///////////////////////////////////
		// getter/setters
		///////////////////////////////////
		
		public function get title():Label {
			return _title;
		}
		
		public function set value(b:Boolean):void {
			if (_value != b) {
				_value = b;
				_changed = true;
				invalidate();
				_onChanged.dispatch(_value);
			}
		}
		
		public function get value():Boolean {
			return _value;
		}
		
		public function get onChanged():Signal {
			return _onChanged;
		}
		
		///////////////////////////////////
		// toString
		///////////////////////////////////
		
		override public function toString():String {
			return "[bloom.components.CheckBox]";
		}
	}

}
