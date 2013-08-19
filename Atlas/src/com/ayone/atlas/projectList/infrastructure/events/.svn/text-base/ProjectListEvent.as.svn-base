package com.ayone.atlas.projectList.infrastructure.events
{
	
import com.ayone.atlas.domain.Project;

import flash.events.Event;

public class ProjectListEvent extends Event
{
	//------------------------------------------------------------
	//
	// Contructor
	//
	//------------------------------------------------------------
	
	public function ProjectListEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
	{
		super(type, bubbles, cancelable);
	}
	
	//------------------------------------------------------------
	//
	// Properties
	//
	//------------------------------------------------------------
	
	public var project:Project;
	
	public static const PROJECTS_CHANGE:String = "projectListProjectsChange";
	
	public static const PROJECT_SELECT:String = "projectListProjectSelect";
}

}