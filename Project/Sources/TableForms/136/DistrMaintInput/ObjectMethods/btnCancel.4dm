If (False:C215)
	// Modified by: costasmanousakis-(Designer)-(12/10/10 20:44:09)
	Mods_2010_12
End if 

If (Modified record:C314([DCM_Contracts:136]))
	
	CONFIRM:C162("Data for current contract record has been modified! Exit without saving?"; "Don't Exit"; "Exit")
	If (Ok=0)
		CANCEL:C270
	End if 
	
Else 
	CANCEL:C270
End if 