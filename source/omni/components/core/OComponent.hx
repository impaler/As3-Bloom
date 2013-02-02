package omni.components.core;

import nme.geom.Rectangle;
import omni.components.core.signals.OCoreEvent;
import omni.components.utils.ComponentUtils;
import omni.components.core.signals.OSignal;
import omni.components.core.interfaces.IStyle;
import omni.components.core.interfaces.IOComponent;

import nme.events.Event;
import nme.display.Sprite;

class OComponent implements IOComponent
{

	public function new(style:IStyle = null)
	{
		createComponentMembers();
		initStyle(style);
		createMembers();
		if(style == null)
			startTrackingTheme();
		enableSignals();

		sprite.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
	}

	private function createComponentMembers():Void
	{
		sprite = new Sprite();
		onResize = new OCoreEvent(OCoreEvent.RESIZE, this.sprite);
		components = [];
	}

	public function onAddedToStage(e:Event):Void
	{
		sprite.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		invalidate();
		//		OCore.log("Added to stage");
	}

	//***********************************************************
	//                  Component Core
	//***********************************************************

	public var sprite(getSprite, null):Sprite;

	private function getSprite():Sprite
	{
		return sprite;
	}

	public var state(getState, setState):String;
	public var _state:String = null;

	private function setState(value:String):String
	{
		if(value != this._state)
		{
			this._state = value;
			invalidate();
		}
		return _state;
	}

	private function getState():String
	{
		return _state;
	}

	public var style(getStyle, setStyle):IStyle;
	private var _style:IStyle;

	public function setStyleClass(value:Class<IStyle>):IStyle
	{
		var styleInstance = Type.createInstance(value, []);
		this.style = styleInstance;
		return this.style;
	}

	private function setStyle(value:IStyle):IStyle
	{
		if(this._style != value)
		{
			stopTrackingTheme();
			initStyle(value);
			invalidate();
			return this._style;
		}
		else
		{
			return null;
		}
	}

	private function getStyle():IStyle
	{
		return this._style;
	}

	public var styleId(getStyleId, null):String;

	public function getStyleId():String
	{
		return ComponentStyle.styleString;
	}

	public function initStyle(style:IStyle = null):Void
	{
		if(this._style != null)
		{
			this._style.destroy();
			this._style = null;
		}
		if(style == null)
		{
			this._style = OCore.instance.defaultTheme.getStyle(this.styleId);
		}
		else
		{
			this._style = style;
		}
		this._style.initStyle(this);
	}

	public var invalid:Bool;

	public function invalidate(recursive:Bool = true):Void
	{
		if(! this.invalid)
		{
			this.invalid = true;
			ORenderManager.instance.addToRenderList(this);

		}
		if(components.length > 0 && recursive)
		{
			for(i in 0...components.length)
			{
				var o = cast (components[i], IOComponent);
				o.invalidate();
			}
		}
	}
	
	public function drawNow(recursive:Bool = true):Void
	{
		this.invalid = true;
		draw();
		
		if(components.length > 0 && recursive)
		{
			for(i in 0...components.length)
			{
				var o = cast (components[i], IOComponent);
				o.drawNow();
			}
		}
	}
	
	public function draw():Void
	{
		coreDraw();
	}

	public function coreDraw():Void
	{
		if(! this.invalid)
			return;

		if(this._style != null)
		{
			this._style.update(this);
		}

		updateMembers();

		drawCount++;

		this.invalid = false;
	}

	public function onThemeChange():Void
	{
		initStyle();
		invalidate();
	}

	public var trackTheme(default, setTrackTheme):Bool;

	public function setTrackTheme(value:Bool):Bool
	{
		if(value != this.trackTheme)
		{
			this.trackTheme = value;
			this.trackTheme ? startTrackingTheme() : stopTrackingTheme();
		}

		return this.trackTheme;
	}

	public function startTrackingTheme():Void
	{
		if(! this.trackTheme)
		{
			OCore.instance.onThemeChange.add(onThemeChange);
			this.trackTheme = true;
		}
	}

	public function stopTrackingTheme():Void
	{
		if(this.trackTheme)
		{
			OCore.instance.onThemeChange.remove(onThemeChange);

			var styleType = Type.getClass(this._style);
			this._style = Type.createInstance(styleType, []);
			this.trackTheme = false;
		}
	}

	public var onResize:OCoreEvent;

	public var components:Array <IOComponent>;

	public function add(comp:IOComponent):Void
	{
		this.components.push(comp);
		this.sprite.addChild(comp.sprite);
	}

	//***********************************************************
	//                  Overridables
	//***********************************************************

	public function createMembers():Void
	{
		//override me
	}

	public function updateMembers():Void
	{
		//override me
	}

	public function enableSignals():Void
	{
		//override me
	}

	public function disableSignals():Void
	{
		//override me
	}

	//***********************************************************
	//                  Dimensions / Positions
	//***********************************************************

	public var x(getX, setX):Float;

	public function setX(value:Float):Float
	{
		return x = sprite.x = (value);
	}

	function getX():Float
	{
		return sprite.x;
	}

	public var y(getY, setY):Float;

	function getY():Float
	{
		return sprite.y;
	}

	public function setY(value:Float):Float
	{
		return y = sprite.y = (value);
	}

	public function move(x:Float, y:Float):Void
	{
		setX(x);
		setY(y);
	}

	public var height(getHeight, setHeight):Float;
	public var _height(default, set_Height):Float = 0;

	private function setHeight(h:Float):Float
	{
		if(_height != h)
		{
			set_Height(h);
			invalidate();
			onResize.dispatch();
		}
		return _height;
	}

	private function getHeight():Float
	{
		return _height;
	}

	private function set_Height(h:Float):Float
	{
		if(_height != h)
		{
			h = ComponentUtils.clamp(h, _style.minHeight, _style.maxHeight);
			_height = (h);
		}
		return _height;
	}

	public var width(getWidth, setWidth):Float;
	public var _width(default, set_Width):Float = 0;

	public function setWidth(w:Float):Float
	{
		if(_width != w)
		{
			set_Width(w);
			invalidate();
			onResize.dispatch();
		}
		return _width;
	}

	public function set_Width(w:Float):Float
	{
		if(_width != w)
		{
			w = ComponentUtils.clamp(w, this._style.minWidth, this._style.maxWidth);
			_width = (w);
		}
		return _width;
	}

	public function getWidth():Float
	{
		return _width;
	}

	public function size(w:Float, h:Float):Void
	{
		_size(w, h);
		invalidate();
	}

	public function _size(w:Float, h:Float):Void
	{
		_width = ComponentUtils.clamp(w, this._style.minWidth, this._style.maxWidth);
		_height = ComponentUtils.clamp(h, this._style.minHeight, this._style.maxHeight);
	}

	public var padding(getPadding, setPadding):Float;
	public var _padding(default, set_Padding):Float = 0;

	private function setPadding(value:Float):Float
	{
		if(_padding != value)
		{
			set_Padding(value);
			invalidate();
			onResize.dispatch();
		}
		return _padding;
	}

	private function getPadding():Float
	{
		return _padding;
	}

	private function set_Padding(value:Float):Float
	{
		if(_padding != value)
		{
			_padding = Math.round(value);
		}
		return _padding;
	}

	public var buttonMode(getButtonMode, setButtonMode):Bool;

	public function setButtonMode(b:Bool):Bool
	{
		#if flash
		//todo new native flash api for cursors
		sprite.buttonMode = b;
		#elseif js
		sprite.useHandCursor = b;
		#end
		//todo cpp desktop use displayobject

		return b;
	}

	public function getButtonMode():Bool
	{
		#if flash
		return sprite.buttonMode;
		#elseif js
		return sprite.useHandCursor;
		#else
		return false;
		#end
	}

	public function startDrag(lockCenter:Bool = false, ?bounds:Rectangle):Void
	{
		sprite.startDrag(false, bounds);
	}
	
	public function stopDrag():Void
	{
		sprite.stopDrag();
	}

	public var mouseX(get_mouseX, null):Float;
	private function get_mouseX():Float
	{ 
		return sprite.mouseX; 
	}
	
	public var mouseY(get_mouseY, null):Float;
	private function get_mouseY():Float
	{ 
		return sprite.mouseY; 
	}

	public function destroy():Void
	{
		if(components.length > 0)
		{
			for(o in components)
			{
				var comp = cast(o, IOComponent);
				comp.destroy();
			}
			components = null;
		}

		_style.destroy();
		_style = null;

		sprite = null;

		onResize.destroy();
		stopTrackingTheme();
	}

	//***********************************************************
	//                  Debug
	//***********************************************************

	public var drawCount(default, setdrawCount):Int = 0;

	public function setdrawCount(value:Int):Int
	{
		drawCount = value;
		//		OCore.log(this.styleId + " - " + drawCount);
		return drawCount;
	}

}

import omni.components.style.OBackgroundStyle;

/**
* ComponentStyle
*/
class ComponentStyle extends OBackgroundStyle
{
	public static var styleString:String = "ComponentStyle";

	public static var STATE_OVER:String = "STATE_OVER";
	public static var STATE_DOWN:String = "STATE_DOWN";

	public function new()
	{
		super();
		styleID = styleString;
	}

}