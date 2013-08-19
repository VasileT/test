package com.ayone.atlas.infrastructure.tasks
{
	
import com.ayone.atlas.util.SpringUtil;

import org.springextensions.actionscript.core.command.ICommand;
import org.springextensions.actionscript.core.task.ITask;
import org.springextensions.actionscript.core.task.support.Task;

public class InitializeTask extends Task
{
	//------------------------------------------------------------
	//
	// Methods
	//
	//------------------------------------------------------------
	
	override public function execute():*
	{
		var task:ITask = SpringUtil.createTaskById("checkSessionTask");
		next(task);
		
		super.execute();
	}
}

}