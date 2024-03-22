//[Bridge MHD NBIS]Item114
If (False:C215)
	// Fixes for move to v14 or 15 to make sure object method only runs using approriarte for event
	//Modified by: administrator (12/17/15 13:44:23)
End if 
If (Form event code:C388=On Data Change:K2:15)
	If ([Bridge MHD NBIS:1]Item114:159>200000)
		ALERT:C41("Future ADT is greater than 200,000.  Please check!")
	End if 
	PushChange(1; Self:C308)
End if 