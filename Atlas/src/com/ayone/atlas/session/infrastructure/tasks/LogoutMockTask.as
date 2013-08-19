package com.ayone.atlas.session.infrastructure.tasks
{
	
import com.ayone.atlas.infrastructure.RemoteContext;
import com.ayone.atlas.session.infrastructure.SessionManager;
import com.ayone.atlas.session.infrastructure.events.SessionEvent;

import mx.controls.Alert;
import mx.rpc.events.FaultEvent;
import mx.rpc.events.ResultEvent;
import mx.rpc.remoting.RemoteObject;

import org.springextensions.actionscript.core.event.EventBus;
import org.springextensions.actionscript.core.task.support.Task;

public class LogoutMockTask extends Task
{
	//------------------------------------------------------------
	//
	// Properties
	//
	//------------------------------------------------------------
	
	private var service:RemoteObject;
	
	[Autowired]
	public var manager:SessionManager;
	
	[Autowired]
	public var remoteContext:RemoteContext;
	
	//------------------------------------------------------------
	//
	// Methods
	//
	//------------------------------------------------------------
	
	override public function execute():*
	{
		EventBus.dispatchEvent(new SessionEvent(SessionEvent.LOGIN_REQUIRED));
		
		super.execute();
	}
}
	
}