If (False:C215)
	// Modified by: costasmanousakis-(Designer)-(10/13/10 10:20:28)
	Mods_2010_10
	//  `Make changes to the field [ScourPOA]Completed when the date is entered
	
	// Fixes for move to v14 or 15 to make sure object method only runs using approriarte for event
	//Modified by: administrator (12/22/15 10:30:29)
End if 
If (Form event code:C388=On Data Change:K2:15)
	
	PushChange(1; Self:C308)
	If (Self:C308->#!00-00-00!)
		[ScourPOA:132]Completed:21:=True:C214
	Else 
		[ScourPOA:132]Completed:21:=False:C215
	End if 
	PushChange(1; ->[ScourPOA:132]Completed:21)
	SCPOA_CompleteAction
End if 