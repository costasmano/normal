If (False:C215)
	// Fixes for move to v14 or 15 to make sure object method only runs using approriarte for event
	//Modified by: administrator (12/22/15 10:30:29)
End if 
If (Form event code:C388=On Data Change:K2:15)  //[NBIS Secondary]Item10
	
	If ([NBIS Secondary:3]Item10:9#99.99)
		CBItem10:=0
	End if 
	PushChange(1; ->[NBIS Secondary:3]Item10:9)
End if 