package com.ayone.atlas.membership.infrastructure.tasks
{
	
import com.ayone.atlas.membership.infrastructure.services.IMembershipService;

import mx.rpc.AsyncResponder;
import mx.rpc.AsyncToken;
import mx.rpc.events.FaultEvent;
import mx.rpc.events.ResultEvent;

import org.springextensions.actionscript.core.command.ICommand;
	
public class SendinvitationCommand implements ICommand
{
	//------------------------------------------------------------
	//
	// Properties
	//
	//------------------------------------------------------------
	
	public var emailAddress:String;
	
	[Autowired]
	public var service:IMembershipService;
	
	//------------------------------------------------------------
	//
	// Methods
	//
	//------------------------------------------------------------
	
	public function execute():*
	{
		var token:AsyncToken = service.sendInvitation();
		token.addResponder(new AsyncResponder(completeHandler, errorHandler));	
	}
	
	//------------------------------------------------------------
	// Event Handling
	//------------------------------------------------------------
	
	protected function completeHandler(e:ResultEvent, token:Object):void
	{
	
	}
	
	protected function errorHandler(e:FaultEvent):void
	{
		
	}
}

}