package omni.components.core.interfaces;

import omni.components.core.signals.OSignal;
import nme.display.Sprite;
import nme.events.Event;

/**
 * IComponent
 * 
 * @description The base interface for all component types
 * 
 */
interface IOComponent implements IDestroyable
{

	//***********************************************************
	//                  Component Core
	//***********************************************************

	/**
	* The base display object of the component
	**/
	public var sprite(getSprite, null):Sprite;
	private function getSprite( ):Sprite;

	/**
	* The string that describes the current component state
	* Eg Disabled, Enabled etc
	**/
	public var state(getState, setState):String;
	public var _state:String;
	private function setState( value:String ):String;
	private function getState( ):String;

	/**
	* The components style object required by all components to draw
	**/
	public var style(getStyle, setStyle):IStyle;
	private var _style:IStyle;
	private function setStyle( value:IStyle ):IStyle;
	private function getStyle( ):IStyle;
	public function setStyleClass( value:Class<IStyle> ):IStyle;

	/**
	* The components styleID used to get the appropriate IStyle
	**/
	public var styleId(getStyleId, null):String;
	public function getStyleId( ):String;

	/**
	* The place where a component style is initiated
	**/
	public function initStyle (style:IStyle = null):Void;

	/**
	* The invalid flag to mark the component to be drawn
	**/
	public var invalid:Bool;

	/**
	* Mark the component to be drawn after a change
	**/
	public function invalidate (recursive:Bool = true):Void;
	
	/**
	* Draw the component asap
	**/
	function drawNow(recursive:Bool = true):Void;
	
	/**
	* The main draw function of each component
	**/
	public function draw ():Void;

	/**
	* The function called when the default theme is changed in core
	**/
	public function onThemeChange( ):Void;

	/**
	* Track the Theme changes or not
	**/
	public var trackTheme(default, setTrackTheme):Bool;
	public function setTrackTheme (value:Bool):Bool;

	/**
	* Let the component change theme based on the core default changes
	**/
	public function startTrackingTheme( ):Void;

	/**
	* Stop the component change theme based on the core default changes
	**/
	public function stopTrackingTheme( ):Void;

	/**
	* The core signal for when a component's dimensions have changed
	**/
	//	public var onResize:OSignal<Void->Void>;

	/**
	* Array of child components
	**/
	public var components:Array <IOComponent>;

	public function add (comp:IOComponent):Void;

	//***********************************************************
	//                  Overridables
	//***********************************************************

	/**
	* The suggested place to create the component display objects etc
	**/
	public function createMembers ():Void;

	/**
	* The function to override to update the child object of a component
	**/
	public function updateMembers ():Void;

	/**
	* The suggested place for where Events are enabled
	**/
	public function enableSignals ():Void;

	/**
	* The suggested place for where Events are disabled
	**/
	public function disableSignals ():Void ;

	//***********************************************************
	//                  Dimensions / Positions
	//***********************************************************

	/**
	* The base x dimension of a component
	**/
	public var x(getX, setX):Float;
	private function setX( value:Float ):Float;
	private function getX( ):Float;

	/**
	* The base y dimension of a component
	**/
	public var y(getY, setY):Float;
	private function setY( value:Float ):Float;
	private function getY( ):Float;

	/**
	* Move the component
	**/
	public function move (x:Float, y:Float):Void;

	/**
	* The base height dimension of a component
	**/
	public var height(getHeight, setHeight):Float;
	private function setHeight( value:Float ):Float;
	private function getHeight( ):Float;

	/**
	* The base height dimension without invalidation
	**/
	public var _height(default, set_Height):Float;
	private function set_Height( value:Float ):Float;

	/**
	* The base width dimension of a component
	**/
	public var width(getWidth, setWidth):Float;
	private function setWidth( value:Float ):Float;
	private function getWidth( ):Float;

	/**
	* The base width dimension without invalidation
	**/
	public var _width(default, set_Width):Float;
	private function set_Width( value:Float ):Float;

	/**
	* Resize the component
	**/
	public function size (w:Float, h:Float):Void;

	/**
	* Resize without invalidation
	**/
	public function _size( w:Float, h:Float ):Void;

	/**
	* Basic padding value for simple layouts
	**/
	public var padding(getPadding, setPadding):Float;
	private function setPadding( value:Float ):Float;
	private function getPadding( ):Float;

	/**
	* Basic padding value without invalidation
	**/
	public var _padding(default, set_Padding):Float;
	private function set_Padding( value:Float ):Float;

	//***********************************************************
	//                  Debug
	//***********************************************************

	//	/**
	//	* Draw count is a debug util to check how many times a component has been drawn
	//	**/
	//	public var drawCount(default, setdrawCount):Int = 0;
	//	public function setdrawCount( value:Int ):Int;
}
