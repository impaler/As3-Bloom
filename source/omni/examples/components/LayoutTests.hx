package omni.examples.components;

import omni.components.gui.layout.Layout;
import omni.components.core.OButtonBase;
import omni.components.core.interfaces.IOComponent;
import omni.components.core.OCore;

class LayoutTests
{

	public function new()
	{
		var layoutVert = new Layout();
		for(i in 0...3)
		{
			layoutVert.add ( new OButtonBase() );
		}
		OCore.addChild (layoutVert);
	
		var layout = new Layout();
		layout.direction = Layout.HORIZONTALLY;
		for(i in 0...3)
		{
			layout.add ( new OButtonBase() );
		}
		layoutVert.add(layout);
		
		var layoutVert = new Layout();
		for(i in 0...3)
		{
			layoutVert.add ( new OButtonBase() );
		}
		layout.add (layoutVert);
		for(i in 0...3)
		{
			layoutVert.add ( new OButtonBase() );
		}
		
		
//		var layout = new Layout();
//		layout.direction = Layout.HORIZONTALLY;
//		layout.move (layoutVert.width+10, 0);
//		for(i in 0...3)
//		{
//			layout.add ( new OButtonBase() );
//		}
//		
//		OCore.addChild (layout);
		
	}

}
