package com.ayone.atlas.infrastructure.tasks
{
	
import com.ayone.atlas.projectList.infrastructure.tasks.LoadProjectsCommand;
import com.ayone.atlas.util.SpringUtil;

import org.springextensions.actionscript.core.command.ICommand;
import org.springextensions.actionscript.core.task.support.Task;

public class PostSignInTask extends Task
{
	//------------------------------------------------------------
	//
	// Methods
	//
	//------------------------------------------------------------
	
	override public function execute():*
	{
		var command:ICommand = SpringUtil.createCommandById("loadProjectsCommand");
		next(command);
		
		super.execute();
	}
}

}