package com.ayone.atlas.membership.presentation
{
	
import com.ayone.atlas.membership.infrastructure.MembershipManager;
import com.ayone.atlas.membership.infrastructure.events.MembershipEvent;
import com.ayone.atlas.membership.infrastructure.tasks.LoadContactsCommand;
import com.ayone.atlas.util.SpringUtil;

import flash.events.MouseEvent;

import org.springextensions.actionscript.core.command.ICommand;
import org.springextensions.actionscript.core.event.EventBus;

import spark.components.Button;
import spark.components.List;
import spark.components.SkinnableContainer;

[SkinState("members")]
[SkinState("addMembers")]

public class MembershipContainer extends SkinnableContainer
{
	//------------------------------------------------------------
	//
	// Properties
	//
	//------------------------------------------------------------
	
	private var isAddMemberState:Boolean; 
	
	[Autowired]
	public var manager:MembershipManager;
	
	//------------------------------
	// Visual Elements
	//------------------------------
	
	[SkinPart(required="true")]
	public var memberList:List;
	
	[SkinPart(required="true")]
	public var addButton:Button;
	
	[SkinPart(required="true")]
	public var backButton:Button;
		
	//------------------------------------------------------------
	//
	// Methods
	//
	//------------------------------------------------------------
	
	private function updateMembers():void
	{
		if (!memberList)
			return;
		
		memberList.dataProvider = manager.members;
		memberList.labelField = "name";
	}
	
	//------------------------------------------------------------
	// Skinning
	//------------------------------------------------------------
	
	override protected function getCurrentSkinState():String
	{	
		var returnState:String = "members"; 
		
		if (isAddMemberState)
			returnState = "addMembers";
		
		return returnState;
	}
	
	override protected function partAdded(partName:String, instance:Object):void
	{
		super.partAdded(partName, instance);
		
		if (instance == memberList)
			updateMembers();	
		else if (instance == addButton)
			addButton.addEventListener(MouseEvent.CLICK, addButtonClickHandler);
		else if (instance == backButton)
			backButton.addEventListener(MouseEvent.CLICK, backButtonClickHandler);
			
	}
	
	override protected function partRemoved(partName:String, instance:Object):void
	{
		super.partRemoved(partName, instance);
		
		if (instance == addButton)
			addButton.removeEventListener(MouseEvent.CLICK, addButtonClickHandler);
		else if (instance == backButton)
			backButton.removeEventListener(MouseEvent.CLICK, backButtonClickHandler);
	}
	
	//------------------------------------------------------------
	// Event Handling
	//------------------------------------------------------------
	
	private function addButtonClickHandler(e:MouseEvent):void
	{
		isAddMemberState = true;
		invalidateSkinState();
		
		var command:ICommand = SpringUtil.createCommand(LoadContactsCommand);
		command.execute();
	}
	
	private function backButtonClickHandler(e:MouseEvent):void
	{
		EventBus.dispatchEvent(new MembershipEvent(MembershipEvent.SHOW_MEMBERS));
	}
	
	[EventHandler(name="membershipMembersChange")]
	public function membershipMembersChangeHandler():void
	{
		isAddMemberState = false;
		
		invalidateSkinState();
		
		updateMembers();
	}
	
	[EventHandler(name="membershipShowMembers")]
	public function membershipShowMembersHandler():void
	{
		isAddMemberState = false;
		
		invalidateSkinState();
	}
}

}