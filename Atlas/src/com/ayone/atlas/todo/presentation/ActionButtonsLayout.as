package com.ayone.atlas.todo.presentation
{
	
import mx.core.ILayoutElement;

import spark.components.Button;
import spark.layouts.HorizontalLayout;

public class ActionButtonsLayout extends HorizontalLayout
{
	//------------------------------------------------------------
	//
	// Methods
	//
	//------------------------------------------------------------
	
	override public function updateDisplayList(w:Number, h:Number):void
	{
		super.updateDisplayList(w, h);
		
		var layoutElement:ILayoutElement;
		var prevLayoutElement:ILayoutElement;
		var count:uint = target.numElements;
		
		for (var i:int = 0; i < count; i++)	
		{
			layoutElement = target.getElementAt(i);
			
			if (Button(layoutElement).enabled)
			{
				Button(layoutElement).includeInLayout = true;
				Button(layoutElement).visible = true;		
				
				if (i > 0)
				{		
					var _x : Number = prevLayoutElement.getLayoutBoundsX() + prevLayoutElement.getLayoutBoundsWidth() + 15;
	
					layoutElement.setLayoutBoundsPosition(_x, layoutElement.getLayoutBoundsY());
					
					target.graphics.lineStyle(1, 0, 1);
					target.graphics.moveTo(_x - 10, layoutElement.getLayoutBoundsHeight() / 2);
					target.graphics.lineTo(_x - 6, layoutElement.getLayoutBoundsHeight() / 2);
				}
				
				prevLayoutElement =  target.getElementAt(i);	
			}
			else 
			{
				Button(layoutElement).includeInLayout = false;
				Button(layoutElement).visible = false;
			}
		}
	}
}
	
}