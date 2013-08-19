package com.ayone.atlas.membership.infrastructure.tasks
{
	
import com.ayone.atlas.membership.infrastructure.MembershipManager;
import com.ayone.atlas.membership.infrastructure.events.MembershipEvent;
import com.ayone.atlas.membership.infrastructure.services.IMembershipService;

import mx.collections.ArrayCollection;
import mx.rpc.AsyncResponder;
import mx.rpc.AsyncToken;
import mx.rpc.events.FaultEvent;
import mx.rpc.events.ResultEvent;

import org.springextensions.actionscript.core.command.ICommand;
import org.springextensions.actionscript.core.event.EventBus;
	
public class LoadContactsCommand implements ICommand
{
	//------------------------------------------------------------
	//
	// Properties
	//
	//------------------------------------------------------------
	
	[Autowired]
	public var manager:MembershipManager;
	
	[Autowired]
	public var service:IMembershipService;
	
	//------------------------------------------------------------
	//
	// Methods
	//
	//------------------------------------------------------------
	
	public function execute():*
	{
		var token:AsyncToken = service.loadContacts();
		token.addResponder(new AsyncResponder(completeHandler, errorHandler));	
	}

	//------------------------------------------------------------
	// Event Handling
	//------------------------------------------------------------
	
	protected function completeHandler(e:ResultEvent, token:Object):void
	{
		manager.contacts = ArrayCollection(e.result);
		
		EventBus.dispatchEvent(new MembershipEvent(MembershipEvent.CONTACTS_LOADED));
	}
	
	protected function errorHandler(e:FaultEvent):void
	{
		
	}
}
	
}