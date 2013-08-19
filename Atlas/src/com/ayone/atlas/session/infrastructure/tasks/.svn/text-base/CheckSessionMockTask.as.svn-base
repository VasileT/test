package com.ayone.atlas.session.infrastructure.tasks
{
	
import com.ayone.atlas.session.infrastructure.events.SessionEvent;

import org.springextensions.actionscript.core.event.EventBus;
import org.springextensions.actionscript.core.task.support.Task;

public class CheckSessionMockTask extends Task
{
	//------------------------------------------------------------
	//
	// Methods
	//
	//------------------------------------------------------------
	
	override public function execute():*
	{	
		EventBus.dispatchEvent(new SessionEvent(SessionEvent.LOGIN_REQUIRED));
	}
}

}