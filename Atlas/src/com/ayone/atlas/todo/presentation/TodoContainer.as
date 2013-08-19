package com.ayone.atlas.todo.presentation
{
	
import com.ayone.atlas.domain.ToDoItem;
import com.ayone.atlas.todo.infrastructure.TodoManager;
import com.ayone.atlas.todo.infrastructure.tasks.ICreateTodoCommand;
import com.ayone.atlas.util.SpringUtil;

import flash.events.MouseEvent;

import org.springextensions.actionscript.core.command.ICommand;

import spark.collections.Sort;
import spark.collections.SortField;
import spark.components.Button;
import spark.components.List;
import spark.components.SkinnableContainer;
import spark.components.TextInput;

public class TodoContainer extends SkinnableContainer
{
	//------------------------------------------------------------
	//
	// Properties
	//
	//------------------------------------------------------------
	
	[Autowired]
	public var manager:TodoManager;
	
	//------------------------------
	// Visual Elements
	//------------------------------
	
	[SkinPart(required="true")]
	public var todoList:List;
	
	[SkinPart(required="true")]
	public var todoInput:TextInput;
	
	[SkinPart(required="true")]
	public var addTodoButton:Button;
	
	//------------------------------------------------------------
	//
	// Methods
	//
	//------------------------------------------------------------
	
	private function updateTodos():void
	{
		if (!todoList || !manager.todoItems)
			return;
		
		sortTodosCollection();
		
		todoList.dataProvider = manager.todoItems;
		todoList.validateNow();
	}
	
	private function sortTodosCollection():void
	{	
		var resolvedSort:SortField = new SortField();
		resolvedSort.name = "resolved";
		resolvedSort.numeric = false;
		
		var modifiedSort:SortField = new SortField();
		modifiedSort.name = "modified";
		modifiedSort.numeric = true;
		modifiedSort.descending = true
		
		var sort:Sort = new Sort();
		sort.fields = [resolvedSort, modifiedSort];
		
		manager.todoItems.sort = sort;
		manager.todoItems.refresh();
		
		for(var i:int = 0; i < manager.todoItems.length; i++)
		{
			if (ToDoItem(manager.todoItems.getItemAt(i)).resolved)
			{
				if ((new Date(ToDoItem(manager.todoItems.getItemAt(i)).modified)).getDate() != 
					(new Date(ToDoItem(manager.todoItems.getItemAt(i - 1)).modified)).getDate() || 
					!ToDoItem(manager.todoItems.getItemAt(i - 1)).resolved)
				{
						ToDoItem(manager.todoItems.getItemAt(i)).isHeader = true;
				}
				
				if (i < manager.todoItems.length - 1 &&
					(new Date(ToDoItem(manager.todoItems.getItemAt(i)).modified)).getDate() == 
					(new Date(ToDoItem(manager.todoItems.getItemAt(i + 1)).modified)).getDate() && 
					ToDoItem(manager.todoItems.getItemAt(i)).isHeader)
				{
					ToDoItem(manager.todoItems.getItemAt(i + 1)).isHeader = false;
				}
			}	
		}		
	}
	
	//------------------------------------------------------------
	// Skinning
	//------------------------------------------------------------
	
	override protected function partAdded(partName:String, instance:Object):void
	{
		super.partAdded(partName, instance);
		
		if (instance == todoList)
			updateTodos();
		else if (instance == addTodoButton)
			addTodoButton.addEventListener(MouseEvent.CLICK, addTodoButtonClickHandler);
	}
	
	override protected function partRemoved(partName:String, instance:Object):void
	{
		super.partRemoved(partName, instance);
		
		if (instance == addTodoButton)
			addTodoButton.removeEventListener(MouseEvent.CLICK, addTodoButtonClickHandler);
	}
	
	//------------------------------------------------------------
	// Event Handling
	//------------------------------------------------------------
	
	private function addTodoButtonClickHandler(e:MouseEvent):void
	{	
		var command:ICommand = SpringUtil.createCommandById("createTodoCommand");
		ICreateTodoCommand(command).title = todoInput.text;
		command.execute();
	}
	
	[EventHandler(name="todosChange")]
	public function todosChangeHandler():void
	{ 
		todoInput.text = "";
		
		updateTodos();
	}
	
	[EventHandler(name="todoStatusChange")]
	public function todoStatusChangeHandler():void
	{ 
		var pos:int = todoList.layout.verticalScrollPosition;
		
		sortTodosCollection();
		todoList.validateNow();
		
		todoList.layout.verticalScrollPosition = pos;
	}
}

}