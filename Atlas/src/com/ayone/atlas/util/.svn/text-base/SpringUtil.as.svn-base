package com.ayone.atlas.util
{
	
import org.springextensions.actionscript.context.IApplicationContext;
import org.springextensions.actionscript.core.command.ICommand;
import org.springextensions.actionscript.core.task.ITask;
	
public class SpringUtil
{	
	//------------------------------------------------------------
	//
	// Properties
	//
	//------------------------------------------------------------
	
	/**
	 * Keeping objects that call to be wired before the context is
	 * created. As soon as the context is created, all requests are
	 * processed and objects wired. 
	 */	
	private static var toWire:Array = [];
	
	//------------------------------
	// context
	//------------------------------
	
	private static var _context:IApplicationContext;
	
	public static function set context(value:IApplicationContext):void
	{
		_context = value;
		
		while (toWire.length > 0)
		{
			_context.wire(toWire.shift());
		}
	}
	
	//------------------------------------------------------------
	//
	// Methods
	//
	//------------------------------------------------------------
	
	public static function wire(object:*):void
	{
		if (_context)
			_context.wire(object);
		else
			toWire.push(object);
	}
	
	public static function createTask(taskClass:Class):ITask
	{
		var task:ITask = new taskClass();
		_context.wire(task);
		
		return task;
	}
	
	public static function createTaskById(id:String):ITask
	{
		return _context.getObject(id);
	}
	
	public static function createCommand(commandClass:Class):ICommand
	{
		var command:ICommand = new commandClass();
		_context.wire(command);
		
		return command;
	}
	
	public static function createCommandById(id:String):ICommand
	{
		return _context.getObject(id);
	}
}

}