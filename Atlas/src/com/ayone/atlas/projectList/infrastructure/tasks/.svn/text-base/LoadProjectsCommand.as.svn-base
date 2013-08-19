package com.ayone.atlas.projectList.infrastructure.tasks
{
	
import com.ayone.atlas.infrastructure.RemoteContext;
import com.ayone.atlas.projectList.infrastructure.ProjectListManager;
import com.ayone.atlas.projectList.infrastructure.events.ProjectListEvent;
import com.ayone.atlas.util.ResponseCode;

import mx.collections.ArrayCollection;
import mx.controls.Alert;
import mx.rpc.events.FaultEvent;
import mx.rpc.events.ResultEvent;
import mx.rpc.remoting.RemoteObject;

import org.springextensions.actionscript.core.command.ICommand;
import org.springextensions.actionscript.core.event.EventBus;

public class LoadProjectsCommand implements ICommand
{
	//------------------------------------------------------------
	//
	// Properties
	//
	//------------------------------------------------------------
	private var service:RemoteObject;
	
	[Autowired]
	public var manager:ProjectListManager;
	
	[Autowired]
	public var remoteContext:RemoteContext;
	
	//------------------------------------------------------------
	//
	// Methods
	//
	//------------------------------------------------------------
	public function execute():*
	{		
		service = new RemoteObject();
		service.destination = "projectService";
		service.endpoint = remoteContext.endpointUrl;
		service.loadProjects.addEventListener("result", loadProjectsResultHandler);
		service.addEventListener("fault", faultHandler);
		service.loadProjects();
	}
	
	//------------------------------------------------------------
	// Event Handling
	//------------------------------------------------------------
	
	private function loadProjectsResultHandler(e:ResultEvent):void 
	{
		manager.projects = ArrayCollection(e.result);
		
		EventBus.dispatchEvent(new ProjectListEvent(ProjectListEvent.PROJECTS_CHANGE));
	}
	
	private function faultHandler(e:FaultEvent):void 
	{	
		if (e.fault.faultCode == ResponseCode.DATA_ACCESS_EXCEPTION)
			Alert.show("Data Access Exception!" , "error");
		else if (e.fault.faultCode == ResponseCode.DATA_INTEGRITY_VIOLATION_EXCEPTION)
			Alert.show("Data Integrity Violation Exception!" , "error");
		else if (e.fault.faultCode == ResponseCode.USER_NOT_FOUND_EXCEPTION)
			Alert.show("User Not Found Exception!" , "error");
		else if (e.fault.rootCause.faultCode == "Channel.Connect.Failed")
			Alert.show("Server is down!" , "error");
	}
}

}