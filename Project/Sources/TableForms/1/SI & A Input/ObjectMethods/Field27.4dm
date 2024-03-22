//[Bridge MHD NBIS]Item99
If (False:C215)
	// Fixes for move to v14 or 15 to make sure object method only runs using approriarte for event
	//Modified by: administrator (12/17/15 13:44:23)
End if 
If (Form event code:C388=On Data Change:K2:15)
	PushChange(1; Self:C308)
	If (Blank([Bridge MHD NBIS:1]Item99:74)=False:C215)
		CBItem98:=0
	End if 
End if 
