package com.ayone.atlas.session.infrastructure.tasks
{

import com.ayone.atlas.domain.User;
import com.ayone.atlas.infrastructure.RemoteContext;
import com.ayone.atlas.infrastructure.tasks.PostSignInTask;
import com.ayone.atlas.session.infrastructure.SessionManager;
import com.ayone.atlas.session.infrastructure.events.SessionEvent;
import com.ayone.atlas.util.SpringUtil;

import mx.rpc.remoting.RemoteObject;

import org.springextensions.actionscript.core.event.EventBus;
import org.springextensions.actionscript.core.task.ITask;
import org.springextensions.actionscript.core.task.support.Task;

[Bindable]
public class LoginMockTask extends Task implements ILoginTask
{
	//------------------------------------------------------------
	//
	// Properties
	//
	//------------------------------------------------------------
	
	private var service:RemoteObject;
	
	public var username:String;
	
	public var password:String;
	
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
		var user:User = new User();
		user.name = "vasia";
		user.id = 0;
		
		manager.user = user;
		
		var task:ITask = SpringUtil.createTask(PostSignInTask);
		task.execute();
		
		EventBus.dispatchEvent(new SessionEvent(SessionEvent.LOGIN_SUCCESFULL));
		
		super.execute();
	}
}
	
}