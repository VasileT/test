package com.ayone.atlas.projectList.infrastructure.services
{
	
import com.ayone.atlas.domain.Project;
import com.ayone.atlas.infrastructure.services.MockServiceBase;

import mx.collections.ArrayCollection;
import mx.rpc.AsyncToken;
	
public class ProjectListMockService extends MockServiceBase implements IProjectListService
{
	//------------------------------------------------------------
	//
	// Methods
	//
	//------------------------------------------------------------
	
	public function loadProjects():AsyncToken
	{
		var project1:Project = new Project();
		project1.title = "project1";
		var project2:Project = new Project();
		project2.title = "project2";
		
		var token:AsyncToken = sendResult(new ArrayCollection([project1, project2]), 100);
		
		return token;
	}
	
	public function createProject(title:String):AsyncToken
	{
		var project:Project = new Project();
		project.title = title;
		
		var token:AsyncToken = sendResult(project), 100);
		
		return token;
	}
}

}