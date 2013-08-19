package com.ayone.atlas.projectList.infrastructure.tasks
{
	
import com.ayone.atlas.domain.Project;
import com.ayone.atlas.projectList.infrastructure.ProjectListManager;
import com.ayone.atlas.projectList.infrastructure.events.ProjectListEvent;
import com.ayone.atlas.projectList.infrastructure.services.IProjectListService;

import mx.rpc.AsyncResponder;
import mx.rpc.AsyncToken;
import mx.rpc.events.FaultEvent;
import mx.rpc.events.ResultEvent;

import org.springextensions.actionscript.core.command.ICommand;
import org.springextensions.actionscript.core.event.EventBus;
	
[Bindable]
public class CreateProjectMockCommand implements ICommand, ICreateProjectCommand
{
	//------------------------------------------------------------
	//
	// Properties
	//
	//------------------------------------------------------------
	
	public var title:String;
	
	[Autowired]
	public var manager:ProjectListManager;
	
	
	[Autowired]
	public var service:IProjectListService;
	
	//------------------------------------------------------------
	//
	// Methods
	//
	//------------------------------------------------------------
	
	public function execute():*
	{		
		var token:AsyncToken = service.loadProjects(title);
		token.addResponder(new AsyncResponder(completeHandler, errorHandler));	
	}
	
	//------------------------------------------------------------
	// Event Handling
	//------------------------------------------------------------
	
	protected function completeHandler(e:ResultEvent, token:Object):void
	{
		manager.projects.addItem(Project(e.result));
		
		EventBus.dispatchEvent(new ProjectListEvent(ProjectListEvent.PROJECTS_CHANGE));
	}
	
	protected function errorHandler(e:FaultEvent):void
	{
		
	}
}

}