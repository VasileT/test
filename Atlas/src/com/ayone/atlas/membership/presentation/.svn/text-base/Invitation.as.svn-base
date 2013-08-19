package com.ayone.atlas.membership.presentation
{
	
import com.ayone.atlas.membership.infrastructure.MembershipManager;
import com.ayone.atlas.membership.infrastructure.tasks.SendinvitationCommand;
import com.ayone.atlas.util.SpringUtil;

import flash.events.MouseEvent;

import org.springextensions.actionscript.core.command.ICommand;

import spark.components.Button;
import spark.components.TextInput;
import spark.components.supportClasses.SkinnableComponent;

public class Invitation extends SkinnableComponent
{
	//------------------------------------------------------------
	//
	// Properties
	//
	//------------------------------------------------------------
	
	[Autowired]
	public var manager:MembershipManager;
	
	//------------------------------
	// Visual Elements
	//------------------------------
	
	[SkinPart(required="true")]
	public var emailInput:TextInput;
	
	[SkinPart(required="true")]
	public var sendInvitationButton:Button;
	
	//------------------------------------------------------------
	//
	// Methods
	//
	//------------------------------------------------------------
	
	private function resetContactsControls():void
	{
		emailInput.text = "";		
	}
	
	//------------------------------------------------------------
	// Skinning
	//------------------------------------------------------------
	
	override protected function partAdded(partName:String, instance:Object):void
	{
		super.partAdded(partName, instance);
		
		if (instance == sendInvitationButton)
			sendInvitationButton.addEventListener(MouseEvent.CLICK, sendInvitationButtonClickHandler);
	}
	
	override protected function partRemoved(partName:String, instance:Object):void
	{
		super.partRemoved(partName, instance);
		
		if (instance == sendInvitationButton)
			sendInvitationButton.removeEventListener(MouseEvent.CLICK, sendInvitationButtonClickHandler);
	}
	
	//------------------------------------------------------------
	// Event Handling
	//------------------------------------------------------------
	
	private function sendInvitationButtonClickHandler(e:MouseEvent):void
	{
		var command:ICommand = SpringUtil.createCommand(SendinvitationCommand);
		
		SendinvitationCommand(command).emailAddress = emailInput.text;
		command.execute()
	}	
	
	[EventHandler(name="membershipMembersChange")]
	public function membershipMembersChangeHandler():void
	{
		resetContactsControls();
	}
	
	[EventHandler(name="membershipShowMembers")]
	public function membershipShowMembersHandler():void
	{
		resetContactsControls();
	}
}
	
}