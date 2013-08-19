package com.ayone.atlas.membership.presentation
{
	
import com.ayone.atlas.domain.User;
import com.ayone.atlas.membership.infrastructure.MembershipManager;
import com.ayone.atlas.membership.infrastructure.events.MembershipEvent;
import com.ayone.atlas.membership.infrastructure.tasks.AddMembersFromContactsCommand;
import com.ayone.atlas.util.SpringUtil;

import flash.events.MouseEvent;

import mx.collections.ArrayCollection;

import org.springextensions.actionscript.core.command.ICommand;

import spark.components.Button;
import spark.components.List;
import spark.components.SkinnableContainer;

[SkinState("contacts")]
[SkinState("noContacts")]

public class Contacts extends SkinnableContainer
{
	//------------------------------------------------------------
	//
	// Constructor
	//
	//------------------------------------------------------------
	
	public function Contacts()
	{
		toAddContacts = new ArrayCollection();
	}
	
	//------------------------------------------------------------
	//
	// Properties
	//
	//------------------------------------------------------------
	
	public var toAddContacts:ArrayCollection;
	
	[Autowired]
	public var manager:MembershipManager;
	
	//------------------------------
	// Visual Elements
	//------------------------------
	
	[SkinPart(required="true")]
	public var contactsList:List;
	
	[SkinPart(required="true")]
	public var addContacts:Button;
	
	//------------------------------------------------------------
	//
	// Methods
	//
	//------------------------------------------------------------
	
	private function updateContacts():void
	{
		if (!contactsList)
			return;
		
		contactsList.dataProvider = manager.contacts;
		contactsList.labelField = "name";
	}
	
	private function updateAddContactsButton():void
	{
		switch(toAddContacts.length)
		{
			case 0: addContacts.label = "Select contacts to add";
				    break;
			case 1: addContacts.label = "Add 1 contact";
					break;
			default: addContacts.label = "Add " + toAddContacts.length + " contacts";
					 break;	
		}
	}
	
	//------------------------------------------------------------
	// Skinning
	//------------------------------------------------------------
	
	override protected function partAdded(partName:String, instance:Object):void
	{
		super.partAdded(partName, instance);
		
		if (instance == contactsList)
		{
			contactsList.addEventListener(MembershipEvent.ADD_CONTACT_TO_ADD_QUEUE, contactsListAddContactToAddQueueHandler);
			
			contactsList.addEventListener(MembershipEvent.REMOVE_CONTACT_FROM_ADD_QUEUE, contactsListRemoveContactFromAddQueueHandler);
			
			updateContacts();
		}
		else if (instance == addContacts)
		{
			addContacts.addEventListener(MouseEvent.CLICK, addContactsClickHandler);
			
			updateAddContactsButton();
		}
	}
	
	override protected function partRemoved(partName:String, instance:Object):void
	{
		super.partRemoved(partName, instance);
		
		if (instance == contactsList)
		{
			contactsList.removeEventListener(MembershipEvent.ADD_CONTACT_TO_ADD_QUEUE, contactsListAddContactToAddQueueHandler);
			
			contactsList.removeEventListener(MembershipEvent.REMOVE_CONTACT_FROM_ADD_QUEUE, contactsListRemoveContactFromAddQueueHandler);
		}
		else if (instance == addContacts)
			addContacts.removeEventListener(MouseEvent.CLICK, addContactsClickHandler);
	}
	
	override protected function getCurrentSkinState():String
	{	
		var returnState:String = "noContacts"; 
		
		if (toAddContacts.length > 0)
			returnState = "contacts";
		
		return returnState;
	}
	
	//------------------------------------------------------------
	// Event Handling
	//------------------------------------------------------------
	
	private function addContactsClickHandler(e:MouseEvent):void
	{
		var command:ICommand = SpringUtil.createCommand(AddMembersFromContactsCommand);
		AddMembersFromContactsCommand(command).contacts = toAddContacts;
		command.execute();
	}
	
	private function contactsListAddContactToAddQueueHandler(e:MembershipEvent):void
	{
		toAddContacts.addItem(User(e.target.data));
		
		e.stopPropagation();
		
		invalidateSkinState();
		
		updateAddContactsButton();
	}
	
	private function contactsListRemoveContactFromAddQueueHandler(e:MembershipEvent):void
	{
		toAddContacts.removeItemAt(toAddContacts.getItemIndex(User(e.target.data)));
		
		e.stopPropagation();
		
		invalidateSkinState();
		
		updateAddContactsButton();
	}
	
	[EventHandler(name="membershipContactsLoaded")]
	private function membershipContactsLoadedHandler():void
	{
		updateContacts();
	}
	
	[EventHandler(name="membershipMembersChange")]
	public function membershipMembersChangeHandler():void
	{
		toAddContacts.removeAll();
		
		invalidateSkinState();
		
		updateAddContactsButton();
	}
	
	[EventHandler(name="membershipShowMembers")]
	public function membershipShowMembersHandler():void
	{
		membershipMembersChangeHandler();
	}
}
	
}