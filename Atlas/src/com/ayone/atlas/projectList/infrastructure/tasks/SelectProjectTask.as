package com.ayone.atlas.projectList.infrastructure.tasks
{
	
import com.ayone.atlas.domain.Project;
import com.ayone.atlas.infrastructure.tasks.PostSelectProjectTask;
import com.ayone.atlas.projectList.infrastructure.ProjectListManager;
import com.ayone.atlas.projectList.infrastructure.events.ProjectListEvent;
import com.ayone.atlas.util.SpringUtil;

import org.springextensions.actionscript.core.event.EventBus;
import org.springextensions.actionscript.core.task.ITask;
import org.springextensions.actionscript.core.task.support.Task;

public class SelectProjectTask extends Task
{
	//------------------------------------------------------------
	//
	// Properties
	//
	//------------------------------------------------------------
	
	public var selectedProject:Project;
	
	[Autowired]
	public var manager:ProjectListManager;
	
	//------------------------------------------------------------
	//
	// Methods
	//
	//------------------------------------------------------------
	
	override public function execute():*
	{	
		manager.selectedProject = selectedProject;
		
		var task:ITask = SpringUtil.createTask(PostSelectProjectTask);
		next(task);
		
		var event:ProjectListEvent = new ProjectListEvent(ProjectListEvent.PROJECT_SELECT);
		event.project = selectedProject;
		EventBus.dispatchEvent(event);
		
		super.execute();	
	}
}

}