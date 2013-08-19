package com.ayone.atlas.membership.infrastructure.tasks
{
	
import com.ayone.atlas.membership.infrastructure.MembershipManager;
import com.ayone.atlas.membership.infrastructure.events.MembershipEvent;

import mx.collections.ArrayCollection;

import org.springextensions.actionscript.core.command.ICommand;
import org.springextensions.actionscript.core.event.EventBus;
	
public class AddMembersFromContactsCommand implements ICommand
{
	//------------------------------------------------------------
	//
	// Properties
	//
	//------------------------------------------------------------
	
	[Autowired]
	public var manager:MembershipManager;
	
	public var contacts:ArrayCollection;
	
	//------------------------------------------------------------
	//
	// Methods
	//
	//------------------------------------------------------------
	
	public function execute():*
	{	
		manager.members.addAll(contacts);
		
		EventBus.dispatchEvent(new MembershipEvent(MembershipEvent.MEMBERS_CHANGE));
		
		EventBus.dispatchEvent(new MembershipEvent(MembershipEvent.SHOW_MEMBERS));
	}
}

}