package com.ayone.atlas.session.presentation
{
	
import com.ayone.atlas.session.infrastructure.events.SessionEvent;
import com.ayone.atlas.session.infrastructure.tasks.ILoginTask;
import com.ayone.atlas.session.infrastructure.tasks.LoginTask;
import com.ayone.atlas.util.SpringUtil;

import flash.events.MouseEvent;

import org.springextensions.actionscript.core.task.ITask;

import spark.components.Button;
import spark.components.TextInput;
import spark.components.supportClasses.SkinnableComponent;

public class Login extends SkinnableComponent
{
	//------------------------------------------------------------
	//
	// Properties
	//
	//------------------------------------------------------------
	
	//------------------------------
	// Visual Elements
	//------------------------------
	
	[SkinPart(required="true")]
	public var loginButton:Button;
	
	[SkinPart(required="true")]
	public var usernameInput:TextInput;
	
	[SkinPart(required="true")]
	public var passwordInput:TextInput;
	
	//------------------------------------------------------------
	//
	// Methods
	//
	//------------------------------------------------------------
	
	//------------------------------------------------------------
	// Skinning
	//------------------------------------------------------------
	
	override protected function partAdded(partName:String, instance:Object):void
	{
		super.partAdded(partName, instance);
		
		if (instance == loginButton)
			loginButton.addEventListener(MouseEvent.CLICK, loginButtonClickHandler);
	}
	
	override protected function partRemoved(partName:String, instance:Object):void
	{
		super.partRemoved(partName, instance);
		
		if (instance == loginButton)
			loginButton.removeEventListener(MouseEvent.CLICK, loginButtonClickHandler);
	}
		
	//------------------------------------------------------------
	// Event Handling
	//------------------------------------------------------------
	
	private function loginButtonClickHandler(e:MouseEvent):void
	{	
		if (usernameInput.text != "" && passwordInput.text != "")
		{
			var task:ITask = SpringUtil.createTaskById("loginTask");	
			ILoginTask(task).username = usernameInput.text;
			ILoginTask(task).password = passwordInput.text;
			usernameInput.text = "";
			passwordInput.text = "";
			
			task.execute();
		}
	}
}

}