package bloom.style {

import bloom.core.IStyle;
import bloom.core.ScaleBitmap;

import flash.display.Graphics;
import flash.system.System;
import flash.utils.Dictionary;

/**
 * BaseStyle
 */
public class BaseStyle implements IStyle {

	private var _stateCollection:Dictionary;

	public function BaseStyle () {
		_stateCollection = new Dictionary (true);
	}

	public function drawStyle (state:int,target:*,args:*):void {
		var drawMethod:* = stateCollection[state];

		if (drawMethod is ScaleBitmap) {
			drawBitmap (ScaleBitmap (drawMethod),target,args);
		}

	}

	protected function drawBitmap (graphic:ScaleBitmap,target:*,args:*):void {
		var targetGraphics:Graphics = target as Graphics;
		targetGraphics.clear ();
		graphic.setSize (args.width,args.height);
		targetGraphics.beginBitmapFill (graphic.bitmapData);
		targetGraphics.drawRect (0,0,args.width,args.height);
		targetGraphics.endFill ();
	}

	protected function drawColorFill (graphic:ScaleBitmap,target:*,args:*):void {
//		var targetGraphics:Graphics = target as Graphics;
//		targetGraphics.clear ();
//		graphic.setSize (args.width,args.height);
//		targetGraphics.beginBitmapFill (graphic.bitmapData);
//		targetGraphics.drawRect (0,0,args.width,args.height);
//		targetGraphics.endFill ();
	}

	protected function drawDisplayAsset (graphic:ScaleBitmap,target:*,args:*):void {
//		var targetGraphics:Graphics = target as Graphics;
//		targetGraphics.clear ();
//		graphic.setSize (args.width,args.height);
//		targetGraphics.beginBitmapFill (graphic.bitmapData);
//		targetGraphics.drawRect (0,0,args.width,args.height);
//		targetGraphics.endFill ();

	}

	protected function drawMethod (graphic:ScaleBitmap,target:*,args:*):void {
//		var targetGraphics:Graphics = target as Graphics;
//		targetGraphics.clear ();
//		graphic.setSize (args.width,args.height);
//		targetGraphics.beginBitmapFill (graphic.bitmapData);
//		targetGraphics.drawRect (0,0,args.width,args.height);
//		targetGraphics.endFill ();
	}

	///////////////////////////////////
	// Dispose
	///////////////////////////////////

	public function dispose (gc:Boolean = false):void {
		_stateCollection = null;
		if (gc) System.gc ();
	}

	public function get stateCollection ():Dictionary {
		return _stateCollection;
	}

	///////////////////////////////////
	// toString
	///////////////////////////////////

	public function toString ():String {
		return "[bloom.styles.BaseStyle]";
	}

}
}
