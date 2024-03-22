Case of 
	: (Form event code:C388=On Clicked:K2:4)
		If ([Work_Estimate:103]WkHrEstComplete:17)
			[Work_Estimate:103]CompletedBy:21:=Current user:C182
			[Work_Estimate:103]CompleteDate:20:=Current date:C33(*)
		Else 
			[Work_Estimate:103]CompletedBy:21:=""
			[Work_Estimate:103]CompleteDate:20:=!00-00-00!
		End if 
		PushChange(1; Self:C308)
		PushChange(1; ->[Work_Estimate:103]CompletedBy:21)
		PushChange(1; ->[Work_Estimate:103]CompleteDate:20)
		
End case 