package com.ayone.atlas.session.presentation
{
	
import com.ayone.atlas.session.infrastructure.SessionManager;
import com.ayone.atlas.session.infrastructure.events.SessionEvent;
import com.ayone.atlas.session.infrastructure.tasks.LogoutTask;
import com.ayone.atlas.util.SpringUtil;

import flash.events.MouseEvent;

import org.springextensions.actionscript.core.task.ITask;

import spark.components.Button;
import spark.components.Label;
import spark.components.supportClasses.SkinnableComponent;

public class Logout extends SkinnableComponent
{
	//------------------------------------------------------------
	//
	// Properties
	//
	//------------------------------------------------------------
	
	[Autowired]
	public var manager:SessionManager;
	
	//------------------------------
	// Visual Elements
	//------------------------------
	
	[SkinPart(required="true")]
	public var logoutButton:Button;
	
	[SkinPart(required="true")]
	public var userLabel:Label;
	
	//------------------------------------------------------------
	//
	// Methods
	//
	//------------------------------------------------------------
	
	private function updateUserLabel():void
	{
		userLabel.text = "Welcome " + manager.user.name;
	}
	
	//------------------------------------------------------------
	// Skinning
	//------------------------------------------------------------
	
	override protected function partAdded(partName:String, instance:Object):void
	{
		super.partAdded(partName, instance);
		
		if (instance == logoutButton)
			logoutButton.addEventListener(MouseEvent.CLICK, logoutButtonClickHandler);
		else if (instance == userLabel)
			updateUserLabel();
	}
	
	override protected function partRemoved(partName:String, instance:Object):void
	{
		super.partRemoved(partName, instance);
		
		if (instance == logoutButton)
			logoutButton.removeEventListener(MouseEvent.CLICK, logoutButtonClickHandler);
	}
	
	//------------------------------------------------------------
	// Event Handling
	//------------------------------------------------------------
	
	private function logoutButtonClickHandler(e:MouseEvent):void
	{	
		var task:ITask = SpringUtil.createTaskById("logoutTask");	
		task.execute();
	}
	
	[EventHandler(name="sessionLoginSuccesfull")]
	public function sessionLoginSuccesfullHandler(e:SessionEvent):void
	{
		updateUserLabel();
	}
}

}