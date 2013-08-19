package com.ayone.atlas.infrastructure.events
{
	
import flash.events.Event;

public class ApplicationEvent extends Event
{
	//------------------------------------------------------------
	//
	// Constructor
	//
	//------------------------------------------------------------
	
	public function ApplicationEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
	{
		super(type, bubbles, cancelable);
	}
	
	//------------------------------------------------------------
	//
	// Properties
	//
	//------------------------------------------------------------
	
	public var enabled:Boolean;
	
	public static const ENABLED_CHANGE:String = "enabledChanged";
}

}