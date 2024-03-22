//[Bridge MHD NBIS]Item10
If (False:C215)
	// Fixes for move to v14 or 15 to make sure object method only runs using approriarte for event
	//Modified by: administrator (12/17/15 13:44:23)
End if 
If (Form event code:C388=On Data Change:K2:15)
	If ([Bridge MHD NBIS:1]Item10:102#99.99)
		CBItem10:=0
	End if 
	PushChange(1; ->[Bridge MHD NBIS:1]Item10:102)
End if 
