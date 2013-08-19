package com.ayone.atlas.infrastructure.tasks
{
	
import com.ayone.atlas.membership.infrastructure.tasks.LoadMembersCommand;
import com.ayone.atlas.membership.infrastructure.tasks.UpdateProjectCommand;
import com.ayone.atlas.projectList.infrastructure.ProjectListManager;
import com.ayone.atlas.todo.infrastructure.tasks.LoadTodosCommand;
import com.ayone.atlas.todo.infrastructure.tasks.UpdateProjectCommand;
import com.ayone.atlas.util.SpringUtil;

import org.springextensions.actionscript.core.command.ICommand;
import org.springextensions.actionscript.core.task.support.Task;

public class PostSelectProjectTask extends Task
{
	//------------------------------------------------------------
	//
	// Properties
	//
	//------------------------------------------------------------
	
	[Autowired]
	public var projectListManager:ProjectListManager;
	
	//------------------------------------------------------------
	//
	// Methods
	//
	//------------------------------------------------------------
	
	override public function execute():*
	{
		var command:ICommand = SpringUtil.createCommand(com.ayone.atlas.membership.infrastructure.tasks.UpdateProjectCommand);
		com.ayone.atlas.membership.infrastructure.tasks.UpdateProjectCommand(command).project = projectListManager.selectedProject;
		next(command);
		
		command = SpringUtil.createCommand(com.ayone.atlas.todo.infrastructure.tasks.UpdateProjectCommand);
		com.ayone.atlas.todo.infrastructure.tasks.UpdateProjectCommand(command).project = projectListManager.selectedProject;
		next(command);
		
	    command = SpringUtil.createCommand(LoadMembersCommand);
		next(command);
		
		command = SpringUtil.createCommandById("loadTodosCommand");
		next(command);
		
		super.execute();
	}
}

}