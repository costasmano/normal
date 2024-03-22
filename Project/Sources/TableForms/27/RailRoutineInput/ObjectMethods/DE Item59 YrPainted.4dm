If (False:C215)
	// Fixes for move to v14 or 15 to make sure object method only runs using approriarte for event
	//Modified by: administrator (12/22/15 10:30:29)
End if 
If (Form event code:C388=On Data Change:K2:15)
	If (Self:C308->#-1)
		vbYrPtdUnknown:=0
	Else 
		vbYrPtdUnknown:=1
	End if 
	PushChange(1; Self:C308)
End if 