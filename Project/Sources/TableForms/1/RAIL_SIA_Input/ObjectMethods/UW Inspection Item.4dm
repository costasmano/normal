If (False:C215)
	// Fixes for move to v14 or 15 to make sure object method only runs using approriarte for event
	//Modified by: administrator (12/17/15 13:44:23)
End if 
If (Form event code:C388=On Clicked:K2:4)
	If (User in group:C338(Current user:C182; "MDC")=False:C215)
		PushChange(1; Self:C308)
	End if 
	If ([Bridge MHD NBIS:1]Item92BA:165=False:C215)
		If ([Bridge MHD NBIS:1]Item92BB:166>0)
			[Bridge MHD NBIS:1]Item92BB:166:=0
			PushChange(1; ->[Bridge MHD NBIS:1]Item92BB:166)
			CalcItem91
			PushChange(1; ->[Bridge MHD NBIS:1]Item91:162)
		End if 
	End if 
End if 