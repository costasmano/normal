//[Bridge MHD NBIS]Item109

//Give warning for values over 40%
If (False:C215)
	// Fixes for move to v14 or 15 to make sure object method only runs using approriarte for event
	//Modified by: administrator (12/17/15 13:44:23)
End if 
If (Form event code:C388=On Data Change:K2:15)
	If ([Bridge MHD NBIS:1]Item109:90>40)
		ALERT:C41("Truck ADT is greater than 40%.  Please check!")
	End if 
	PushChange(1; Self:C308)
End if 
