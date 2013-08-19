package com.ayone.atlas.membership.infrastructure.services
{
	
import com.ayone.atlas.domain.User;
import com.ayone.atlas.infrastructure.services.MockServiceBase;

import mx.collections.ArrayCollection;
import mx.rpc.AsyncToken;
	
public class MembershipMockService extends MockServiceBase implements IMembershipService
{
	//------------------------------------------------------------
	//
	// Methods
	//
	//------------------------------------------------------------
	
	public function loadMembers():AsyncToken
	{
		var user1:User = new User();
		user1.name = "vasia";
		var user2:User = new User();
		user2.name = "andrei";
		
		var token:AsyncToken = sendResult(new ArrayCollection([user1, user2]), 100);
		
		return token;
	}
	
	public function loadContacts():AsyncToken
	{
		var contact1:User = new User();
		contact1.name = "tomo";
		var contact2:User = new User();
		contact2.name = "adrian";
		
		var token:AsyncToken = sendResult(new ArrayCollection([contact1, contact2]), 100);
		
		return token;
	}
	
	public function sendInvitation():AsyncToken
	{
		var token:AsyncToken = sendResult(new ArrayCollection(), 100);
		
		return token;
	}
}
	
}