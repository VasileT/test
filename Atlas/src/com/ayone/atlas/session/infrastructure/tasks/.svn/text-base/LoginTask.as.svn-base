package com.ayone.atlas.session.infrastructure.tasks
{
	
import com.ayone.atlas.domain.User;
import com.ayone.atlas.infrastructure.RemoteContext;
import com.ayone.atlas.infrastructure.tasks.PostSignInTask;
import com.ayone.atlas.session.infrastructure.SessionManager;
import com.ayone.atlas.session.infrastructure.events.SessionEvent;
import com.ayone.atlas.util.ResponseCode;
import com.ayone.atlas.util.SpringUtil;

import mx.controls.Alert;
import mx.rpc.events.FaultEvent;
import mx.rpc.events.ResultEvent;
import mx.rpc.remoting.RemoteObject;

import org.springextensions.actionscript.core.event.EventBus;
import org.springextensions.actionscript.core.task.ITask;
import org.springextensions.actionscript.core.task.support.Task;

[Bindable]
public class LoginTask extends Task implements ILoginTask
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
		service = new RemoteObject();
		service.destination = "authenticationService";
		service.endpoint = remoteContext.endpointUrl;
		service.authenticate.addEventListener("result", loginResultHandler);
		service.addEventListener("fault", faultHandler);
		service.authenticate(username, password);
		
		super.execute();
	}
	
	//------------------------------------------------------------
	// Event Handling
	//------------------------------------------------------------
	
	private function loginResultHandler(e:ResultEvent):void 
	{
		manager.user = User(e.result);
		
		var task:ITask = SpringUtil.createTask(PostSignInTask);
		task.execute();
		
		EventBus.dispatchEvent(new SessionEvent(SessionEvent.LOGIN_SUCCESFULL));
	}
	
	private function faultHandler(e:FaultEvent):void 
	{	
		if (e.fault.faultCode == ResponseCode.BAD_CREDINTIAL_EXCEPTION)
			Alert.show("Bad credentials" , "error");
		else if (e.fault.rootCause.faultCode == "Channel.Connect.Failed")
			Alert.show("Server is down!" , "error");
	}
}
	
}