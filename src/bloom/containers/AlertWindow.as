/**
 * Copyright (c) 2012 - 2100 Sindney
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */
package bloom.containers {

import bloom.brushes.Brush;
import bloom.core.Bloom;

import com.greensock.TweenLite;

import flash.display.Shape;
import flash.display.Sprite;
import flash.events.Event;

/**
 * Window
 *
 * @author sindney
 */
public class AlertWindow extends Window {
	
	private var _position:String;
	private var _topPadding:int;
	
	private const CENTRE:String = "Centre";
	private const TOPCENTRE:String = "TopCentre";
	
	private var _modalBG:Sprite;
	
	private var _modalBrush:Brush;
	

	public function AlertWindow ( content:FlowContainer = null ) {
		super ( content );
		
		_modalBG = new Sprite();
		_modalBG.mouseEnabled = true;
		_modalBG.mouseChildren = true;
		
		update();
	}

	override public function closeWindow ( e:Event = null ):void {
		TweenLite.to(_modalBG,.4,{alpha:0,onComplete:function(){Bloom.core().stage.removeChild(_modalBG);}});
		super.closeWindow ( e );
	}

	override public function openWindow ( e:Event = null ):void {
		_modalBG.alpha=0;
		Bloom.core().stage.addChild(_modalBG);
		TweenLite.to(_modalBG,.4,{alpha:1});
		
		super.openWindow ( e );
	}

	override public function applyModel ():void {
		if ( ! _customModel ) {
			_window_model = Registry.theme.AlertWindow_Model as WindowModel;
		}
		
		position = TOPCENTRE;
		_topPadding = 30;
		
		_customModel = true;
		super.applyModel();
	}

	override protected function draw ( e:Event ):void {
		drawModalBG ();
		super.draw ( e );
	}

	private function drawModalBG ():void {
		//todo _modalBrush
		
		var stageWidth:Number = Bloom.core ().stage.stageWidth;
		var stageHeight:Number = Bloom.core ().stage.stageHeight;

		_modalBG.graphics.clear();
		_modalBG.graphics.beginFill ( 0x000033 , .7 );
		_modalBG.graphics.drawRect ( 0 , 0 , stageWidth , stageHeight );
		_modalBG.graphics.endFill ();
		
	}

	///////////////////////////////////
	// getter/setters
	///////////////////////////////////

	public function get position ():String {
		return _position;
	}

	public function set position ( value:String ):void {
		_position = value;
		
		if ( _position == TOPCENTRE) {
			Bloom.core().onStageResize.add( onStageResize );
		}
	}

	private function onStageResize (e:Event=null):void {
		switch ( position ) {
			case TOPCENTRE :
					var xPos:Number = Math.round ( ( Bloom.core ().stage.stageWidth * .5 ) - ( this.width * .5 ) );
					var yPos:Number = _topPadding;
					move(xPos, yPos);
				break;
			
			case CENTRE :
					var xPos:Number = Math.round(  ( Bloom.core().stage.stageWidth*.5 ) - ( this.width *.5 ));
					var yPos:Number = Math.round(  ( Bloom.core().stage.stageHeight*.5 ) - ( this.height *.5 ));
					move(xPos, yPos);
				break;
		}
		
		drawModalBG ();
		
	}

	///////////////////////////////////
	// toString
	///////////////////////////////////

	override public function toString ():String {
		return "[bloom.containers.Window]";
	}

}

}
