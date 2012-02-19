package bloom.components 
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	
	import org.osflash.signals.Signal;
	
	import bloom.control.Bloom;
	import bloom.core.Component;
	import bloom.core.ScaleBitmap;
	import bloom.themes.default.ProgressBarStyle;
	
	/**
	 * ProgressBar
	 */
	public class ProgressBar extends Component {
		
		private var _bg:Sprite;
		private var _progress:Shape;
		
		private var _value:int;
		
		private var _onChanged:Signal;
		
		public function ProgressBar(p:DisplayObjectContainer = null, value:int = 0) {
			super(p);
			
			_onChanged = new Signal(int);
			
			_bg = new Sprite();
			_progress = new Shape();
			addChild(_bg);
			addChild(_progress);
			
			_value = value;
			
			style = Bloom.theme.progressBar;
			
			size(100, 20);
		}
		
		override protected function draw(e:Event):void {
			if (_changed) {
				_changed = false;
			} else {
				return;
			}
			
			_value = _value > 100 ? 100 : _value;
			_value = _value < 0 ? 0 : _value;
			
			var style:ProgressBarStyle = _style as ProgressBarStyle;
			
			style.bg.setSize(_width, _height);
			_bg.graphics.clear();
			_bg.graphics.beginBitmapFill(style.bg.bitmapData);
			_bg.graphics.drawRect(0, 0, _width, _height);
			_bg.graphics.endFill();
			
			style.bar.setSize((_width * _value) * 0.01, _height);
			_progress.graphics.clear();
			_progress.graphics.beginBitmapFill(style.bar.bitmapData);
			_progress.graphics.drawRect(0, 0, (_width * _value) * 0.01, _height);
			_progress.graphics.endFill();
		}
		
		///////////////////////////////////
		// getter/setters
		///////////////////////////////////
		
		public function set value(value:int):void {
			if (_value != value) {
				_value = value;
				_changed = true;
				invalidate();
				if (_value >= 100) _onChanged.dispatch(_value);
			}
		}
		
		public function get value():int {
			return _value;
		}
		
		public function get onChanged():Signal {
			return _onChanged;
		}
		
		///////////////////////////////////
		// toString
		///////////////////////////////////
		
		override public function toString():String {
			return "[bloom.components.ProgressBar]";
		}
	}

}