package com.ayone.atlas.projectList.presentation
{
	
import com.ayone.atlas.domain.Project;
import com.ayone.atlas.projectList.infrastructure.ProjectListManager;
import com.ayone.atlas.projectList.infrastructure.tasks.ICreateProjectCommand;
import com.ayone.atlas.projectList.infrastructure.tasks.SelectProjectTask;
import com.ayone.atlas.util.SpringUtil;

import flash.events.Event;
import flash.events.MouseEvent;

import org.springextensions.actionscript.core.command.ICommand;
import org.springextensions.actionscript.core.task.ITask;

import spark.components.Button;
import spark.components.List;
import spark.components.SkinnableContainer;
import spark.components.TextInput;

public class ProjectListContainer extends SkinnableContainer
{
	//------------------------------------------------------------
	//
	// Properties
	//
	//------------------------------------------------------------
	
	[Autowired]
	public var manager:ProjectListManager;
	
	//------------------------------
	// Visual Elements
	//------------------------------
	
	[SkinPart(required="true")]
	public var projectList:List;
	
	[SkinPart(required="true")]
	public var projectInput:TextInput;
	
	[SkinPart(required="true")]
	public var createProjectButton:Button;
	
	//------------------------------------------------------------
	//
	// Methods
	//
	//------------------------------------------------------------
	
	private function updateProjects():void
	{
		if (!projectList)
			return;
		
		projectList.dataProvider = manager.projects;
		projectList.labelField = "title";
	}
	
	//------------------------------------------------------------
	// Skinning
	//------------------------------------------------------------
	
	override protected function partAdded(partName:String, instance:Object):void
	{
		super.partAdded(partName, instance);
		
		if (instance == projectList)
		{
			updateProjects();
			projectList.addEventListener(Event.CHANGE, projectListSelectionChangeHandler);	
		} 
		else if (instance == createProjectButton)
		{
			createProjectButton.addEventListener(MouseEvent.CLICK, createProjectButtonClickHandler);	
		}
	}
	
	override protected function partRemoved(partName:String, instance:Object):void
	{
		super.partRemoved(partName, instance);
		
		if (instance == projectList)
			projectList.removeEventListener(Event.CHANGE, projectListSelectionChangeHandler);	
		else if (instance == createProjectButton)
		{
			createProjectButton.removeEventListener(MouseEvent.CLICK, createProjectButtonClickHandler);	
		}
	}
	
	//------------------------------------------------------------
	// Event Handling
	//------------------------------------------------------------
	
	private function projectListSelectionChangeHandler(e:Event):void
	{
		var task:ITask = SpringUtil.createTask(SelectProjectTask);	
		SelectProjectTask(task).selectedProject = Project(projectList.selectedItem)
		task.execute();
	}
	
	private function createProjectButtonClickHandler(e:MouseEvent):void
	{
		var command:ICommand = SpringUtil.createCommandById("createProjectCommand");	
		ICreateProjectCommand(command).title = projectInput.text;
		command.execute();
	}
	
	[EventHandler(name="projectListProjectsChange")]
	public function projectListProjectsChangeHandler():void
	{
		projectInput.text = "";
		updateProjects();
	}
}
	
}