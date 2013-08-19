package com.ayone.atlas.todo.infrastructure.tasks
{
	
import com.ayone.atlas.infrastructure.RemoteContext;
import com.ayone.atlas.todo.infrastructure.TodoManager;
import com.ayone.atlas.todo.infrastructure.events.TodoEvent;
import com.ayone.atlas.util.ResponseCode;

import mx.collections.ArrayCollection;
import mx.controls.Alert;
import mx.rpc.events.FaultEvent;
import mx.rpc.events.ResultEvent;
import mx.rpc.remoting.RemoteObject;

import org.springextensions.actionscript.core.command.ICommand;
import org.springextensions.actionscript.core.event.EventBus;
	
public class LoadTodosCommand implements ICommand
{
	//------------------------------------------------------------
	//
	// Properties
	//
	//------------------------------------------------------------
	
	private var service:RemoteObject;
	
	[Autowired]
	public var manager:TodoManager;
	
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
		service.destination = "todoService";
		service.endpoint = remoteContext.endpointUrl;
		service.loadTodos.addEventListener("result", loadTodosResultHandler);
		service.addEventListener("fault", faultHandler);
		service.loadTodos(manager.project.id);
	}
	
	//------------------------------------------------------------
	// Event Handling
	//------------------------------------------------------------
	
	private function loadTodosResultHandler(e:ResultEvent):void 
	{
		manager.todoItems = (ArrayCollection(e.result));
		
		EventBus.dispatchEvent(new TodoEvent(TodoEvent.TODOS_CHANGE));
	}
	
	private function faultHandler(e:FaultEvent):void 
	{	
		if (e.fault.faultCode == ResponseCode.DATA_ACCESS_EXCEPTION)
			Alert.show("Data Access Exception!" , "error");
		else if (e.fault.faultCode == ResponseCode.DATA_INTEGRITY_VIOLATION_EXCEPTION)
			Alert.show("Data Integrity Violation Exception!" , "error");
		else if (e.fault.faultCode == ResponseCode.PROJECT_NOT_FOUND_EXCEPTION)
			Alert.show("Project Not Found Exception!" , "error");
		else if (e.fault.rootCause.faultCode == "Channel.Connect.Failed")
			Alert.show("Server is down!" , "error");
	}
}

}