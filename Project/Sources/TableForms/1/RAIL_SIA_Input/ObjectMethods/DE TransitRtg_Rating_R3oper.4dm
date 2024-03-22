If (False:C215)
	//[Bridge MHD NBIS];"RAIL_SIA_Input".DE TransitRtg_Rating_R3oper
	// Fixes for move to v14 or 15 to make sure object method only runs using approriarte for event
	//Modified by: administrator (12/17/15 13:44:23)
End if 
If (Form event code:C388=On Clicked:K2:4)
	PushChange(2; Self:C308)
End if 