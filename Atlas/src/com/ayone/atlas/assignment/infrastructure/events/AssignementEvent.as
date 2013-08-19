package com.ayone.atlas.assignment.infrastructure.events
{
	
import flash.events.Event;

public class AssignementEvent extends Event
{
	//------------------------------------------------------------
	//
	// Constructor
	//
	//------------------------------------------------------------
	
	public function AssignementEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
	{
		super(type, bubbles, cancelable);
	}
}

}