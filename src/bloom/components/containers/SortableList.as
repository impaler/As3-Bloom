package bloom.components.containers {

import bloom.components.controls.ButtonBase;
import bloom.core.IComponent;
import bloom.core.IObjectBase;
import bloom.core.OmniCore;

import flash.display.DisplayObject;

import flash.display.DisplayObjectContainer;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.Point;

import org.osflash.signals.natives.NativeSignal;

public class SortableList extends VBox {

	private var onDragRender:NativeSignal;
	private var dragging:ButtonBase;
	private var swapTarget:ButtonBase;
	private var doneswapTarget:ButtonBase;

	public function SortableList (p:DisplayObjectContainer = null) {

		onDragRender = new NativeSignal(OmniCore.stage,Event.ENTER_FRAME, Event);
//		onDragRender = new NativeSignal(OmniCore.stage,MouseEvent.MOUSE_MOVE, MouseEvent);

		super (p);

	}

	override public function addContent (value:IComponent):IComponent {
			var thing:ButtonBase = value as ButtonBase;
			thing.mouseDown.add(onDownHandler);
			return super.addContent (value);
	}

	private function onDownHandler (e:MouseEvent = null):void {
		dragging = e.target as ButtonBase;
		dragging.mouseUp.addOnce(onUpHandler);
		onDragRender.add(onRenderDrag);
		dragging.startDrag();

	}

	private function onRenderDrag (e:* = null):void {

		var object:DisplayObject;
		var component:IObjectBase;
		var i:int, j:int = content.numChildren;

			for (i = 0; i < j; i ++) {
				object = _content.getChildAt (i);
				if ( object is IObjectBase ) {
					if ( dragging.hitTestObject(object) ) {

						swapTarget = object as ButtonBase;

						if ( doneswapTarget != swapTarget ) {
							doneswapTarget = swapTarget;

//							var otherindex = _content.getChildIndex(dragging);
//							_content.setChildIndex(swapTarget, otherindex);

							_content.swapChildren(dragging, swapTarget);

							drawDirectly();


							//todo fix stuffup
							dragging.x = mouseX-dragging.width*.5;
							dragging.y = mouseY-dragging.height*.5;
						}
					}
				}
			}

//		var Objects:Array = _content.getObjectsUnderPoint(new Point(mouseX, mouseY));
//
//		for (var i:int = 0; i < Objects.length; i ++) {
//			var object:* = Objects[i];
//			if ( object is ButtonBase ) {
//				swapTarget = object as ButtonBase;
//				_content.swapChildren(dragging, swapTarget);
//				drawDirectly();
//				//todo fix stuffup
//				dragging.x = mouseX-dragging.width*.5;
//				dragging.y = mouseY-dragging.height*.5;
//			}
//
//		}
	}

	private function onUpHandler (e:MouseEvent = null):void {
		onDragRender.remove(onRenderDrag);

//		if ( e.target is ButtonBase ) {
//			var thing:ButtonBase = e.target as ButtonBase;
		swapTarget.stopDrag();
					drawDirectly();
//		}

	}






}
}
