If (False:C215)
	// Modified by: costasmanousakis-(Designer)-(10/19/2007 16:10:03)
	Mods_2007_CM12_5302
	Mods_2013_03  //r001 ` Log new record removed from here as it is under the accept button
	//Modified by: Charles Miller (3/19/13 14:44:20)
End if 

Case of 
	: (Form event code:C388=On Load:K2:1)
		OBJECT SET ENTERABLE:C238([ElementDict:30]ElementNo:1; True:C214)
		
		C_BOOLEAN:C305(NewRecord_b)
		
		InitChangeStack(1)
		NewRecord_b:=Is new record:C668([ElementDict:30])
		
		
	: (Form event code:C388=On Validate:K2:3)
		
		If (NewRecord_b)
			[ElementDict:30]DateCreated:6:=Current date:C33
			[ElementDict:30]TimeCreated:7:=Current time:C178
			PushChange(1; ->[ElementDict:30]DateCreated:6)
			PushChange(1; ->[ElementDict:30]TimeCreated:7)
			
			
		End if 
		[ElementDict:30]DateModified:8:=Current date:C33
		[ElementDict:30]TimeModified:9:=Current time:C178
		PushChange(1; ->[ElementDict:30]DateModified:8)
		PushChange(1; ->[ElementDict:30]TimeModified:9)
		
		FlushGrpChgs(1; ->[ElementDict:30]ElementNo:1; ->[ElementDict:30]ElementNo:1; ->[ElementDict:30]ElementNo:1; 0)
End case 