package com.ayone.atlas.presentation
{
	
import com.ayone.atlas.infrastructure.tasks.InitializeTask;
import com.ayone.atlas.projectList.infrastructure.events.ProjectListEvent;
import com.ayone.atlas.session.infrastructure.events.SessionEvent;
import com.ayone.atlas.util.SpringUtil;

import flash.events.Event;

import mx.events.FlexEvent;

import org.springextensions.actionscript.context.IApplicationContext;
import org.springextensions.actionscript.context.support.FlexXMLApplicationContext;
import org.springextensions.actionscript.core.task.ITask;

import spark.components.Application;
import spark.components.Label;

[SkinState("normal")]

[SkinState("login")]

[SkinState("projects")]

[SkinState("project")]

public class AtlasApplication extends Application
{
	//------------------------------------------------------------
	//
	// Contructor
	//
	//------------------------------------------------------------
	
	public function AtlasApplication()
	{
		super();
		
		addHandlers();
	}
	
	//------------------------------------------------------------
	//
	// Properties
	//
	//------------------------------------------------------------
	
	private var isLogin:Boolean;
	
	private var isLoggedIn:Boolean;
	
	private var isProjectSelected:Boolean;
	
	private var title:String;
	
	//------------------------------
	// Visual Elements
	//------------------------------
	
	[SkinPart(required="true")]
	public var projectLabel:Label;
	
	//------------------------------------------------------------
	//
	// Methods
	//
	//------------------------------------------------------------
	
	override protected function getCurrentSkinState():String
	{
		super.getCurrentSkinState();
		
		var returnState:String = "normal"; 
		
		if (isLogin)
			returnState = "login";
		else if (isProjectSelected)
			returnState = "project";
		else if (isLoggedIn)
			returnState = "projects";
		
		return returnState;
	}
	
	override protected function partAdded(partName:String, instance:Object):void
	{
		super.partAdded(partName, instance);
		
		if (instance == projectLabel)
			updateProjectTitle();
	}
	
	private function updateProjectTitle():void
	{
		if (projectLabel && title)
			projectLabel.text = title;
	}
	
	//------------------------------------------------------------
	// Event Handling
	//------------------------------------------------------------
	
	private function addHandlers():void
	{
		addEventListener(FlexEvent.CREATION_COMPLETE, creationCompleteHandler);
	}
	
	private function creationCompleteHandler(e:FlexEvent):void
	{
		var applicationContext:FlexXMLApplicationContext = new FlexXMLApplicationContext();
		applicationContext.addConfigLocation("../resources/context.xml");
		applicationContext.addEventListener(Event.COMPLETE, handleComplete);
		applicationContext.load();
	}
	
	private function handleComplete(e:Event):void
	{
		var context:IApplicationContext = e.target as IApplicationContext;
		SpringUtil.context = context;
		
		var task:ITask = SpringUtil.createTask(InitializeTask);
		task.execute();
	}
	
	[EventHandler(name="sessionLoginRequired")]
	public function loginRequiredHandler(e:SessionEvent):void
	{
		isLogin = true;
		isLoggedIn = isProjectSelected = false;
		
		invalidateSkinState();
	}
	
	[EventHandler(name="sessionLoginSuccesfull")]
	public function sessionLoginSuccesfullHandler(e:SessionEvent):void
	{
		isLoggedIn = true;
		isProjectSelected = isLogin = false;
		
		invalidateSkinState();
	}
	
	[EventHandler(name="projectListProjectSelect")]
	public function projectListProjectSelectHandler(e:ProjectListEvent):void
	{	
		isLogin = isLoggedIn = false;
		isProjectSelected = true;
		
		invalidateSkinState();
		
		title = e.project.title;
			
		updateProjectTitle();
	}
}

}