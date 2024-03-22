If (False:C215)
	// Method: Object Method: Item 93b
	// Description
	// 
	// Parameters
	// ----------------------------------------------------
	// Modified by: costasmanousakis-(Designer)-(4/24/2006 15:23:14)
	Mods_2006_CM04
	
End if 
If (False:C215)
	// Fixes for move to v14 or 15 to make sure object method only runs using approriarte for event
	//Modified by: administrator (12/22/15 10:30:29)
End if 
If (Form event code:C388=On Data Change:K2:15)
	INSP_UWDate_OM(Self:C308)
End if 
