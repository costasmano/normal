If (False:C215)
	//[DCM_Contracts];"DistrMaintInput".btnSave
	// Modified by: costasmanousakis-(Designer)-(9/13/10 13:47:16)
	Mods_2010_09
	//removed (False ) code
	// Modified by: costasmanousakis-(Designer)-(12/13/10 12:35:18)
	Mods_2010_12
	//  `simplified code
End if 

If (Form event code:C388=On Clicked:K2:4)
	DCM_ContrBidItems("SAVE")
	DCM_ItemQEntered_b:=False:C215
	ACCEPT:C269
End if 