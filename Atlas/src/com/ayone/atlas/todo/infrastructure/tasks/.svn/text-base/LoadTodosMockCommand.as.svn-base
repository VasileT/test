package com.ayone.atlas.todo.infrastructure.tasks
{

import com.ayone.atlas.todo.infrastructure.TodoManager;
import com.ayone.atlas.todo.infrastructure.events.TodoEvent;
import com.ayone.atlas.todo.infrastructure.services.ITodoService;

import mx.collections.ArrayCollection;
import mx.rpc.AsyncResponder;
import mx.rpc.AsyncToken;
import mx.rpc.events.FaultEvent;
import mx.rpc.events.ResultEvent;

import org.springextensions.actionscript.core.command.ICommand;
import org.springextensions.actionscript.core.event.EventBus;

public class LoadTodosMockCommand implements ICommand
{
	//------------------------------------------------------------
	//
	// Properties
	//
	//------------------------------------------------------------
	
	[Autowired]
	public var manager:TodoManager;
	
	[Autowired]
	public var service:ITodoService;
	
	//------------------------------------------------------------
	//
	// Methods
	//
	//------------------------------------------------------------
	
	public function execute():*
	{		
		var token:AsyncToken = service.loadTodos();
		token.addResponder(new AsyncResponder(completeHandler, errorHandler));	
	}
	
	//------------------------------------------------------------
	// Event Handling
	//------------------------------------------------------------
	
	protected function completeHandler(e:ResultEvent, token:Object):void
	{
		manager.todoItems = new ArrayCollection(e.result);
		
		EventBus.dispatchEvent(new TodoEvent(TodoEvent.TODOS_CHANGE));
	}
	
	protected function errorHandler(e:FaultEvent):void
	{
		
	}
}

}