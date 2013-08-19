package com.ayone.atlas.infrastructure.services
{
	
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import mx.core.mx_internal;
	import mx.rpc.AsyncToken;
	import mx.rpc.events.ResultEvent;
	
	use namespace mx_internal;
	
	public class MockServiceBase extends EventDispatcher
	{
		//------------------------------------------------------------
		//
		// Methods
		//
		//------------------------------------------------------------
		
		public function sendResult(result:Object, delay:Number):AsyncToken
		{
			var t:Timer = new Timer(delay, 1);
			var token:AsyncToken = new AsyncToken(null);
			
			t.addEventListener(TimerEvent.TIMER_COMPLETE, function(e:TimerEvent):void
			{
				token.setResult(result);
				var event:ResultEvent = new ResultEvent(ResultEvent.RESULT, false, true, result, token);
				token.applyResult(event);
			});
			
			t.start();
			
			return token;
		}
		
	}
	
}