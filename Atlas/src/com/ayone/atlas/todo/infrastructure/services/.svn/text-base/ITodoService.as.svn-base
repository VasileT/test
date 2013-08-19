package com.ayone.atlas.todo.infrastructure.services
{
	
import com.ayone.atlas.domain.ToDoItem;

import mx.rpc.AsyncToken;
	
public interface ITodoService
{
	function loadTodos():AsyncToken;
	function createTodo(title:String):AsyncToken;
	function resolveTodo(todoItem:ToDoItem):AsyncToken;
	function reopenTodo(todoItem:ToDoItem):AsyncToken;
}

}