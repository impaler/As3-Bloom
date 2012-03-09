package bloom.components 
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import org.osflash.signals.natives.NativeSignal;
	import org.osflash.signals.Signal;
	
	import bloom.core.IObjectBase;
	import bloom.core.Margin;
	import bloom.core.ThemeBase;
	import bloom.styles.AccordionContentStyle;
	import bloom.styles.IStyle;
	
	/**
	 * AccordionContent
	 */
	public class AccordionContent extends Sprite implements IObjectBase {
		
		private var _selected:Boolean;
		private var _enabled:Boolean;
		private var _margin:Margin;
		
		private var _style:IStyle;
		
		private var _title:ToggleButton;
		private var _content:FlowContainer;
		
		private var _mouseClicked:NativeSignal;
		
		private var _onSelected:Signal;
		private var _onChanged:Signal;
		
		public function AccordionContent(title:String = "", content:FlowContainer = null) {
			super();
			_margin = new Margin();
			
			_title = new ToggleButton(this, title);
			_title.size(100, 30);
			
			if (content) {
				_content = content;
			} else {
				_content = new FlowContainer(null, FlowContainer.VERTICALLY);
			}
			
			_mouseClicked = new NativeSignal(_title, MouseEvent.CLICK, MouseEvent);
			_mouseClicked.add(onMouseClick);
			
			_onSelected = new Signal();
			_onChanged = new Signal();
			
			_enabled = true;
			_selected = false;
		}
		
		public function dispose():void {
			_mouseClicked.removeAll();
			_mouseClicked = null;
			_onSelected.removeAll();
			_onSelected = null;
			_onChanged.removeAll();
			_onChanged = null;
			_title.dispose();
			_title = null;
			_content.dispose();
			_content = null;
			_style = null;
		}
		
		private function onMouseClick(e:MouseEvent):void {
			selected = !_selected;
		}
		
		///////////////////////////////////
		// getter/setters
		///////////////////////////////////
		
		override public function get height():Number {
			return _title.height + (_selected ? _content.height : 0);
		}
		
		override public function set width(value:Number):void {
			_title.width = value;
			_content.width = value;
		}
		
		public function set selected(value:Boolean):void {
			if (_selected != value) {
				_selected = value;
				_title.value = value;
				if (_selected) {
					_content.y = _title.height;
					addChild(_content);
					_onSelected.dispatch();
				} else {
					removeChild(_content);
				}
				_onChanged.dispatch();
			}
		}
		
		public function get selected():Boolean {
			return _selected;
		}
		
		public function get title():ToggleButton {
			return _title;
		}
		
		public function get content():FlowContainer {
			return _content;
		}
		
		public function set enabled(value:Boolean):void {
			if (_enabled != value) {
				_enabled = mouseEnabled = mouseChildren = value;
				alpha = _enabled ? 1 : ThemeBase.theme.alpha;
			}
		}
		
		public function get enabled():Boolean {
			return _enabled;
		}
		
		public function get margin():Margin {
			return _margin;
		}
		
		public function get mouseClicked():NativeSignal {
			return _mouseClicked;
		}
		
		public function get onSelected():Signal {
			return _onSelected;
		}
		
		public function get onChanged():Signal {
			return _onChanged;
		}
		
		public function get style():IStyle {
			return _style;
		}
		
		public function set style(value:IStyle):void {
			if (_style != value) {
				_style = value;
				if (_style) {
					var style:AccordionContentStyle = _style as AccordionContentStyle;
					_title.style = style.title;
					_content.style = style.content;
				}
			}
		}
		
		///////////////////////////////////
		// toString
		///////////////////////////////////
		
		override public function toString():String {
			return "[bloom.components.AccordionContent]";
		}
	}

}