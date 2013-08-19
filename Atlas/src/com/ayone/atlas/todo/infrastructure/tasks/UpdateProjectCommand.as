package com.ayone.atlas.todo.infrastructure.tasks
{
	
import com.ayone.atlas.domain.Project;
import com.ayone.atlas.todo.infrastructure.TodoManager;

import org.springextensions.actionscript.core.command.ICommand;
	
public class UpdateProjectCommand implements ICommand
{
	//------------------------------------------------------------
	//
	// Properties
	//
	//------------------------------------------------------------
	
	public var project:Project;
	
	[Autowired]
	public var manager:TodoManager;
	
	//------------------------------------------------------------
	//
	// Methods
	//
	//------------------------------------------------------------
	
	public function execute():*
	{	
		manager.project = project;
	}
}

}