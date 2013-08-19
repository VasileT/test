package com.ayone.atlas.domain
{
	
import flash.events.Event;
import flash.events.EventDispatcher;
	
[RemoteClass(alias="com.ayone.atlas.dto.TodoDTO")]

public class ToDoItem
{
	//------------------------------------------------------------
	//
	// Properties
	//
	//------------------------------------------------------------
	
	public var title:String;
	
	public var id:int;

	public var index:int;	
	
	public var modified:Number;
	
	//------------------------------
	// resolved
	//------------------------------
	
	private var _resolved:Boolean;
	
	[Bindable]
	public function get resolved():Boolean
	{
		return _resolved;
	}
	
	public function set resolved(value:Boolean):void
	{
		_resolved = value;
	}
	
	//------------------------------
	// isHeader
	//------------------------------
	
	private var _isHeader:Boolean;
	
	[Bindable]
	public function get isHeader():Boolean
	{
		return _isHeader;
	}
	
	public function set isHeader(value:Boolean):void
	{
		_isHeader = value;
	}
}

}