package com.ayone.atlas.todo.infrastructure.tasks
{
	
import com.ayone.atlas.domain.ToDoItem;
import com.ayone.atlas.todo.infrastructure.TodoManager;
import com.ayone.atlas.todo.infrastructure.events.TodoEvent;
import com.ayone.atlas.todo.infrastructure.services.ITodoService;

import mx.rpc.AsyncResponder;
import mx.rpc.AsyncToken;
import mx.rpc.events.FaultEvent;
import mx.rpc.events.ResultEvent;

import org.springextensions.actionscript.core.command.ICommand;
import org.springextensions.actionscript.core.event.EventBus;

[Bindable]
public class ResolveTodoMockCommand implements ICommand, IChangeTodoStatusCommand
{
	//------------------------------------------------------------
	//
	// Properties
	//
	//------------------------------------------------------------
	
	public var todoItem:ToDoItem;
	
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
		var token:AsyncToken = service.resolveTodo(todoItem);
		token.addResponder(new AsyncResponder(completeHandler, errorHandler));
	}
	
	//------------------------------------------------------------
	// Event Handling
	//------------------------------------------------------------
	
	protected function completeHandler(e:ResultEvent, token:Object):void
	{
		todoItem = todoItem(e.result);
		
		EventBus.dispatchEvent(new TodoEvent(TodoEvent.TODO_STATUS_CHANGE));
	}
	
	protected function errorHandler(e:FaultEvent):void
	{
		
	}
}

}