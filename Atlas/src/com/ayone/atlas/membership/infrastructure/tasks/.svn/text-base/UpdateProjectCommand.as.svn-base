package com.ayone.atlas.membership.infrastructure.tasks
{
	
import com.ayone.atlas.domain.Project;
import com.ayone.atlas.membership.infrastructure.MembershipManager;

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
	public var manager:MembershipManager;
	
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