If (False:C215)
	// Fixes for move to v14 or 15 to make sure object method only runs using approriarte for event
	//Modified by: administrator (12/22/15 10:30:29)
End if 
If (Form event code:C388=On Data Change:K2:15)
	PushChange(1; Self:C308)
	OBJECT SET ENABLED:C1123(*; "DE Button Save"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
End if 
