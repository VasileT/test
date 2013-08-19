package com.ayone.atlas.todo.infrastructure.services
{
	
import com.ayone.atlas.domain.ToDoItem;
import com.ayone.atlas.infrastructure.services.MockServiceBase;

import mx.collections.ArrayCollection;
import mx.rpc.AsyncToken;

public class TodoMockService extends MockServiceBase implements ITodoService
{
	//------------------------------------------------------------
	//
	// Methods
	//
	//------------------------------------------------------------
	
	public function loadTodos():AsyncToken
	{
		var todo:ToDoItem;
		var todoItems:Array = new Array();
		
		for (var i:int = 0; i < 400; i++)
		{
			todo = new ToDoItem();
			todo.title = "todo" + i.toString();
			todo.index = 0;
			todo.modified = (new Date()).getTime();
			
			if (i > 10)
			{
				todo.modified = (new Date()).getTime() - i * 3600 * 1000;
				todo.resolved = true;
			}
			
			todoItems.push(todo);
		}
		
		var token:AsyncToken = sendResult(new ArrayCollection([todoItems]), 100);
		
		return token;
	}
	
	public function createTodo(title:String):AsyncToken
	{
		var todoItem:ToDoItem = new ToDoItem();
		
		todoItem.title = title;
		todoItem.modified = (new Date()).getTime();
		
		var token:AsyncToken = sendResult(todoItem, 100);
		
		return token;
	}
	
	public function resolveTodo(todoItem:ToDoItem):AsyncToken
	{
		todoItem.resolved = true;
		todoItem.modified = (new Date()).getTime();
		
		var token:AsyncToken = sendResult(todoItem, 100);
		
		return token;
	}
	
	public function reopenTodo(todoItem:ToDoItem):AsyncToken
	{
		todoItem.resolved = false;
		todoItem.isHeader = false
		
		var token:AsyncToken = sendResult(todoItem, 100);
		
		return token;
	}
	
}
	
}