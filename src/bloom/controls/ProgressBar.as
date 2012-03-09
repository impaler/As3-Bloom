package bloom.controls {

import bloom.core.Component;
import bloom.core.OmniCore;

import flash.display.BitmapData;
import flash.display.DisplayObjectContainer;
import flash.display.Shape;
import flash.events.Event;

import org.osflash.signals.Signal;

/**
 * ProgressBar
 */
public class ProgressBar extends Component {

	private var bitmapData0:BitmapData;
	private var bitmapData1:BitmapData;

	private var progress:Shape;

	private var _completed:Signal;

	private var _value:Number;

	public function ProgressBar (p:DisplayObjectContainer = null,value:Number = 0) {
		super (p);

		progress = new Shape ();
		addChild (progress);

		_completed = new Signal (ProgressBar);

		_value = value;

		_style = OmniCore.defaultTheme.progressBar;
		size (200,20);
	}

	override public function dispose (gc:Boolean = false):void {
		super.dispose (gc);
		if (bitmapData0) bitmapData0.dispose ();
		bitmapData0 = null;
		if (bitmapData1) bitmapData1.dispose ();
		bitmapData1 = null;

		_completed.removeAll ();
		_completed = null;

		graphics.clear ();
		progress.graphics.clear ();
		removeChild (progress);
		progress = null;
	}

	override protected function onThemeChanged ():void {
		style = OmniCore.defaultTheme.progressBar;
	}

	override protected function draw (e:Event = null):void {
		if (! _changed) return;
		_changed = false;

		var style:ProgressBarStyle = _style as ProgressBarStyle;
		if (bitmapData0) bitmapData0.dispose ();
		if (bitmapData1) bitmapData1.dispose ();

		graphics.clear ();
		style.background.setSize (_width,_height);
		bitmapData0 = style.background.bitmapData.clone ();
		graphics.beginBitmapFill (bitmapData0);
		graphics.drawRect (0,0,_width,_height);
		graphics.endFill ();

		progress.graphics.clear ();
		style.progress.setSize (_width * _value * 0.01,_height);
		bitmapData1 = style.progress.bitmapData.clone ();
		progress.graphics.beginBitmapFill (bitmapData1);
		progress.graphics.drawRect (0,0,_width * _value * 0.01,_height);
		progress.graphics.endFill ();
	}

	///////////////////////////////////
	// getter/setters
	///////////////////////////////////

	public function get value ():Number {
		return _value;
	}

	public function set value (value:Number):void {
		if (value > 100) value = 100;
		if (value < 0) value = 0;
		if (_value != value) {
			_value = value;
			_changed = true;
			invalidate ();
			if (_value == 100)_completed.dispatch (this);
		}
	}

	public function get completed ():Signal {
		return _completed;
	}

	///////////////////////////////////
	// toString
	///////////////////////////////////

	override public function toString ():String {
		return "[bloom.components.ProgressBar]";
	}

}

}
