package bloom.components {

import bloom.styles.ContainerStyle;
import bloom.utils.ColorUtils;
import bloom.core.ThemeBase;

import flash.display.DisplayObjectContainer;
import flash.display.GradientType;
import flash.display.Graphics;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.Matrix;
import flash.geom.Point;
import flash.geom.Rectangle;

import org.osflash.signals.Signal;
import org.osflash.signals.natives.NativeSignal;

/**
 * Color Picker
 *
 * based on code in razor
 * @see https://github.com/razorberry/razor
 *
 */
public class ColorPicker extends Button {

	protected var colorContainer:Sprite;
	protected var saturationContainer:Sprite;
	protected var lightnessContainer:Sprite;
	protected var previewIcon:Sprite;
	protected var pickerHandle:Sprite;
	protected var lightnessHandle:Sprite;
	protected var previousSwatch:Sprite;
	protected var previewSwatch:Sprite;
	
	protected var _valueChanged:Signal;
	protected var _valueChangeLive:Signal;

	protected var pickerUIWindow:Window;
	protected var pickerUIContainer:FlowContainer;
	protected var okButton:Button;
	protected var cancelButton:Button;

	protected var onlightnessHandleDown:NativeSignal;
	protected var onpickerHandleDown:NativeSignal;
	protected var onsaturationContainerDown:NativeSignal;
	protected var onlightnessContainerDown:NativeSignal;
	protected var onMove:NativeSignal;

	private var _hue:uint;
	private var _saturation:Number;
	private var _saturatedHue:uint;
	private var _color:uint = 0xff0000;
	private var _previousColor:uint = _color;
	private var _r:uint = 0xff;
	private var _g:uint = 0;
	private var _b:uint = 0;
	private var _lightnessW:Number;
	private var _padding:Number;
	private var _buttonIconS:Number;
	private var _pickerHandleS:Number;
	private var _buttonHeight:Number;
	private var _lightnessHandleH:Number;
	private var _swatchH:Number;

	public function ColorPicker (p:DisplayObjectContainer = null,title:String = "") {
		super (p,title);

		_valueChanged = new Signal (ColorPicker);
		_valueChangeLive = new Signal (uint);
		
		pickerUIContainer = new FlowContainer();
		pickerUIWindow = new Window (null,pickerUIContainer);
		pickerUIWindow.liveResize = true;
		pickerUIWindow.minWidth = 260;
		pickerUIWindow.minHeight = 260;
		pickerUIContainer.onResized.add( function():void{
			draw(null);
			updateFromColor(true);
		});
		
		okButton = new Button (pickerUIWindow.content,"Ok");
		cancelButton = new Button (pickerUIWindow.content,"Cancel");

		previewSwatch = new Sprite ();
		pickerUIWindow.content.addChild (previewSwatch);
		
		previousSwatch = new Sprite ();
		pickerUIWindow.content.addChild (previousSwatch);
		
		previewIcon = new Sprite ();
		icon = previewIcon;

		colorContainer = new Sprite ();
		pickerUIWindow.content.addChild (colorContainer);

		saturationContainer = new Sprite ();
		pickerUIWindow.content.addChild (saturationContainer);

		lightnessContainer = new Sprite ();
		pickerUIWindow.content.addChild (lightnessContainer);

		lightnessHandle = new Sprite ();
		lightnessHandle.buttonMode = true;
		pickerUIWindow.content.addChild (lightnessHandle);

		pickerHandle = new Sprite ();
		pickerHandle.buttonMode = true;
		pickerUIWindow.content.addChild (pickerHandle);

		onMove = ThemeBase.onStageMouseMove;
		onlightnessHandleDown = new NativeSignal (lightnessHandle,MouseEvent.MOUSE_DOWN);
		onpickerHandleDown = new NativeSignal (pickerHandle,MouseEvent.MOUSE_DOWN);
		onsaturationContainerDown = new NativeSignal (saturationContainer,MouseEvent.MOUSE_DOWN);
		onlightnessContainerDown = new NativeSignal (lightnessContainer,MouseEvent.MOUSE_DOWN);

		onpickerHandleDown.add (onpickerHandlePress);
		ThemeBase.onStageMouseUp.add (onMainHandleRelease);

		onlightnessContainerDown.add (onlightnessContainerPress);
		onlightnessHandleDown.add (onlightnessHandlePress);
		onsaturationContainerDown.add (onsaturationContainerRelease);

		okButton.mouseDown.add (okDown);
		cancelButton.mouseDown.add (cancelDown);

		mouseDown.add (openColorUI);

		_swatchH = 26;
		_lightnessHandleH = 6;
		_lightnessW = 20;
		_buttonIconS = _height - 10;
		_pickerHandleS = 20;
		_padding = 10;
		_buttonHeight = okButton.height;

		pickerUIWindow.size (300,200);

		draw (null);

		color = _color;
	}

	private function okDown (e:MouseEvent):void {
		_valueChanged.dispatch (this);
		closeColorUI (null);
	}

	private function cancelDown (e:MouseEvent):void {
		_color = _previousColor;
		draw (null);
		closeColorUI (null);
	}

	private function openColorUI (e:MouseEvent):void {
		_previousColor = _color;
		pickerUIWindow.x = ThemeBase.stage.stageWidth * .5 - pickerUIWindow.width * .5;
		pickerUIWindow.y = ThemeBase.stage.stageHeight * .5 - pickerUIWindow.height * .5;
		ThemeBase.stage.addChild (pickerUIWindow);
		mouseDown.addOnce (closeColorUI);
		ThemeBase.onStageResize.add(resizeStage);
	}

	private function resizeStage (e:Event = null):void {
		pickerUIWindow.x = ThemeBase.stage.stageWidth * .5 - pickerUIWindow.width * .5;
		pickerUIWindow.y = ThemeBase.stage.stageHeight * .5 - pickerUIWindow.height * .5;
	}

	private function closeColorUI (e:MouseEvent):void {
		ThemeBase.stage.removeChild (pickerUIWindow);
		mouseDown.remove (closeColorUI);
		ThemeBase.onStageResize.remove(resizeStage);
	}

	private function onMainHandleRelease (e:MouseEvent):void {
		okButton.enabled = cancelButton.enabled = true;

		onMove.remove (updateFromPosition);
		pickerHandle.stopDrag ();
		lightnessHandle.stopDrag ();
	}

	private function onpickerHandlePress (e:MouseEvent):void {
		updateFromPosition ();
		okButton.enabled = cancelButton.enabled = false;
		pickerHandle.startDrag (true,new Rectangle (colorContainer.x,colorContainer.y,colorContainer.width,
		                                            colorContainer.height));
		onMove.add (updateFromPosition);
	}

	private function onsaturationContainerRelease (e:MouseEvent):void {
		var targetP:Point = saturationContainer.localToGlobal(new Point(e.localX, e.localY));
		var targety:Point = pickerUIContainer.globalToLocal(new Point(targetP.x, targetP.y));
		pickerHandle.x = targety.x;
		pickerHandle.y = targety.y;
		
		onpickerHandleDown.dispatch(e);
	}

	private function onlightnessContainerPress (e:MouseEvent):void {
		var targetP:Point = lightnessContainer.localToGlobal(new Point(e.localX, e.localY));
		var targety:Point = pickerUIContainer.globalToLocal(new Point(targetP.x, targetP.y));
		lightnessHandle.y = targety.y;
		
		onlightnessHandleDown.dispatch(e);
	}

	private function onlightnessHandlePress (e:MouseEvent):void {
		updateFromPosition ();
		lightnessHandle.startDrag (true,new Rectangle (lightnessContainer.x + (lightnessContainer.width * .5),
		                                               lightnessContainer.y,0,lightnessContainer.height));
		onMove.add (updateFromPosition);
	}

	override protected function draw (e:Event):void {
		var g:Graphics = previewIcon.graphics;
		g.beginFill (0x00000f,.3);
		g.drawRect (0,0,_buttonIconS,_buttonIconS);
		g.endFill ();

		super.draw (e);

		var g:Graphics = lightnessHandle.graphics;
		g.clear ();
		g.beginFill (0xffffff,.1);
		g.lineStyle (2,0x000000,1,true);
		g.drawRect (- _lightnessW * .5,- (_lightnessHandleH * .5),_lightnessW,_lightnessHandleH);
		g.endFill ();

		var g:Graphics = pickerHandle.graphics;
		g.clear ();
		g.beginFill (0xffffff,.1);
		g.lineStyle (2,0x000000,1,true);
		g.drawCircle (0,0,_pickerHandleS * .5);
		g.endFill ();

		drawColorGamut ();
		drawLightnessContainer ();
		drawSwatch();
		
		okButton.y = colorContainer.y + colorContainer.height;
		okButton.x = colorContainer.x;
		cancelButton.y = colorContainer.y + colorContainer.height;
		cancelButton.x = okButton.width + _padding;

		lightnessHandle.x = lightnessContainer.x + (lightnessContainer.width * .5);
		updateFromColor ();
	}

	protected function drawColorGamut ():void {
		colorContainer.x = _padding;
		colorContainer.y = _padding+_swatchH;
		var sw:Number = pickerUIContainer.width - _padding * 2 - _lightnessW;
		var sh:Number = ((pickerUIContainer.height-_swatchH)-(_padding * 2)-_buttonHeight);

		var g:Graphics = colorContainer.graphics;
		g.clear ();

		if (sw > 0 && sh > 0) {
			var colors:Array = [0xFF0000,0xFFFF00,0x00FF00,0x00FFFF,0x0000FF,0xFF00FF,0xFF0000];
			var alphas:Array = [1,1,1,1,1,1,1];
			var ratios:Array = [0,42,85,127,170,212,255];
			var matr:Matrix = new Matrix ();
			matr.createGradientBox (sw,sh);
			g.beginGradientFill (GradientType.LINEAR,colors,alphas,ratios,matr);
			g.lineStyle (1,0,0);
			g.drawRect (0,0,sw,sh);
			g.endFill ();
		}

		saturationContainer.x = saturationContainer.y = colorContainer.x;
		saturationContainer.y = _padding+_swatchH;
		var g:Graphics = saturationContainer.graphics;
		g.clear ();
		if (sw > 0 && sh > 0) {
			var colors:Array = [0x7F7F7F,0x7F7F7F];
			var alphas:Array = [0,1];
			var ratios:Array = [0,255];
			var matr:Matrix = new Matrix ();
			matr.createGradientBox (sw,sh,Math.PI / 2);
			g.beginGradientFill (GradientType.LINEAR,colors,alphas,ratios,matr);
			g.drawRect (0,0,sw,sh);
			g.endFill ();
		}
		
	}

	protected function drawLightnessContainer ():void {
		lightnessContainer.y = _padding+_swatchH;
		lightnessContainer.x = colorContainer.x + colorContainer.width;
		var sh:Number = pickerUIContainer.height - _padding * 2 - _buttonHeight-_swatchH;
		var sw:Number = _lightnessW;

		var g:Graphics = lightnessContainer.graphics;
		g.clear ();
		var colors:Array = [0xFFFFFF,_saturatedHue,0x000000];
		var alphas:Array = [1,1,1];
		var ratios:Array = [0,127,255];
		var matr:Matrix = new Matrix ();
		matr.createGradientBox (sw,sh,Math.PI / 2,0,0);
		g.beginGradientFill (GradientType.LINEAR,colors,alphas,ratios,matr);
		g.lineStyle (0,0,0);
		g.drawRect (0,0,sw,sh);
		g.endFill ();
	}

	protected function drawSwatch ():void {
		var g:Graphics = previewIcon.graphics;
		g.clear ();
		g.beginFill (_color,1);
		g.drawRect (0,0,_buttonIconS,_buttonIconS);
		g.endFill ();
		
		var previewW:Number = ((_padding*2)+(colorContainer.width*.5)-(_lightnessW*.5));
		var g:Graphics = previewSwatch.graphics;
		g.clear ();
		g.beginFill (_color,1);
		g.drawRect (0,0,previewW,_swatchH);
		g.endFill ();
		previewSwatch.x = _padding;
		previewSwatch.y = _padding;
		
		var g:Graphics = previousSwatch.graphics;
		g.clear ();
		g.beginFill (_previousColor,1);
		g.drawRect (0,0,previewW,_height);
		g.endFill ();	
		previousSwatch.x = previewSwatch.x+previewSwatch.width;
		previousSwatch.y = previewSwatch.y;
	}

	protected function calculateSaturatedHue ():void {
		_saturatedHue = ColorUtils.blend (_hue,0x7f7f7f,1 - _saturation);
	}

	protected function updateFromPosition (e:MouseEvent = null):void {
		_hue = translateHue ((pickerHandle.x - Math.floor (colorContainer.x)) / colorContainer.width);
		_saturation = 1 - ((pickerHandle.y - Math.floor (colorContainer.y)) / colorContainer.height);
		
		calculateSaturatedHue ();

		if (lightnessHandle.y - Math.floor (lightnessContainer.y) < lightnessContainer.height / 2) {
			_color = ColorUtils.blend (0xffffff,_saturatedHue,
			                           (lightnessHandle.y - Math.floor (lightnessContainer.y)) / (lightnessContainer.height / 2))
		} else {
			_color = ColorUtils.blend (_saturatedHue,0,
			                           (lightnessHandle.y - lightnessContainer.height / 2 - Math.floor (lightnessContainer.y)) / (lightnessContainer.height / 2));
		}

		calculateRGB ();
		drawLightnessContainer ();
		drawSwatch ();

		if (e != null) e.updateAfterEvent ();

		_valueChangeLive.dispatch (_color);
	}

	protected function updateFromColor (external:Boolean = false):void {
		calculateRGB ();

		// Calculate HSL values!
		var rr:Number = _r / 0xFF;
		var gg:Number = _g / 0xFF;
		var bb:Number = _b / 0xFF;
		var max:Number = Math.max (bb,Math.max (rr,gg));
		var min:Number = Math.min (bb,Math.min (rr,gg));

		var h:Number;
		var s:Number;
		var l:Number;

		// Calculate Hue (in degrees)
		if (max == min)
			h = 0; else if (max == rr) {
			h = 60 * ((gg - bb) / (max - min)) + (gg < bb ? 360 : 0);
		} else if (max == gg) {
			h = 60 * ((bb - rr) / (max - min)) + 120;
		} else {
			h = 60 * ((rr - gg) / (max - min)) + 240;
		}
		// Restrict 0 <= hue < 360
		while (h < 0)
			h += 360;
		while (h >= 360)
			h -= 360;

		// Calculate Lightness
		l = (max + min) / 2;

		// Calculate Saturation
		if (l == 0 || max == min)
			s = 0; else if (l <= 0.5)
			s = (max - min) / (2 * l); else
			s = (max - min) / (2 - 2 * l);

		if (external) {
			pickerHandle.x = (h / 360 * colorContainer.width) + colorContainer.x;
			pickerHandle.y = ((1 - s) * colorContainer.height) + colorContainer.y;

			lightnessHandle.y = (1 - l) * lightnessContainer.height + lightnessContainer.y;
			lightnessHandle.x = lightnessContainer.x + (lightnessContainer.width * .5);
		}

		_hue = translateHue (h / 360);
		_saturation = s;
		
		calculateSaturatedHue ();
		drawLightnessContainer ();
		drawSwatch ();
	}

	protected function calculateRGB ():void {
		_b = (_color & 0xff);
		_g = (_color & 0xff00) >> 8;
		_r = (_color & 0xff0000) >> 16;
	}

	protected function translateHue (v:Number):uint {
		var r:Number = 0;
		var g:Number = 0;
		var b:Number = 0;
		if (v <= 1 / 6) {
			r = 255;
			g = ColorUtils.blend (0,255,v * 6);
			b = 0;
		} else if (v <= 2 / 6) {
			r = ColorUtils.blend (255,0,v * 6 - 1);
			g = 255;
			b = 0;
		} else if (v <= 3 / 6) {
			r = 0;
			g = 255;
			b = ColorUtils.blend (0,255,(v * 6 - 2));
		} else if (v <= 4 / 6) {
			r = 0;
			g = ColorUtils.blend (255,0,(v * 6 - 3));
			b = 255;
		} else if (v <= 5 / 6) {
			r = ColorUtils.blend (0,255,(v * 6 - 4));
			g = 0;
			b = 255;
		} else if (v <= 1) {
			r = 255;
			g = 0;
			b = ColorUtils.blend (255,0,(v * 6 - 5));
		}

		return uint ((b) | (g << 8) | (r << 16));
	}

	override public function destroy ():void {
		super.destroy ();

		ThemeBase.onStageMouseUp.remove (onMainHandleRelease);
		ThemeBase.onStageResize.remove(resizeStage);
		onMove.remove (updateFromPosition);

		_valueChanged.removeAll ();
		_valueChanged = null;
		_valueChangeLive.removeAll ();
		_valueChangeLive = null;
		
		onlightnessContainerDown.removeAll ();
		onlightnessContainerDown = null;
		onlightnessHandleDown.removeAll ();
		onlightnessHandleDown = null;
		onpickerHandleDown.removeAll ();
		onpickerHandleDown = null;
		onsaturationContainerDown.removeAll ();
		onsaturationContainerDown = null;
		
		okButton.destroy();
		cancelButton.destroy();
		pickerUIWindow.destroy();
		pickerUIContainer.destroy();
		
	}

	///////////////////////////////////
	// getter/setters
	///////////////////////////////////

	public function set color (v:uint):void {
		if (! isNaN (v))
			_color = v;
		updateFromColor (true);
	}

	public function get color ():uint {
		return _color;
	}

	public function set hex (str:String):void {
		var numStr:String = str.split ("#").join ("").split ("0x").join ("");
		var num:Number = parseInt (numStr,16);
		if (! isNaN (num))
			color = uint (num);
	}

	public function get hex ():String {
		return (_r < 16 ? "0" : "") + _r.toString (16) + (_g < 16 ? "0" : "") + _g.toString (16) + (_b < 16 ? "0" : "") + _b.toString (16);
	}

	///////////////////////////////////
	// toString
	///////////////////////////////////

	public override function toString ():String {
		return "[bloom.components.ColorPicker]";
	}

}

}
