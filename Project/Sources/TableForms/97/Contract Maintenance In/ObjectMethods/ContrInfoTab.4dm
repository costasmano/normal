If (False:C215)
	// Modified by: costasmanousakis-(Designer)-(12/2/2005 16:43:44)
	Mods_2005_CM19
	// Modified by: costasmanousakis-(Designer)-(2/14/2006 14:58:15)
	Mods_2006_CM03
End if 

RELATE MANY:C262([Contract_Maintenance:97])

Case of 
	: (Self:C308->=1)
		//General tab
		G_MaintenanceCheckNegative
		G_MaintenanceCalculateTLFandDE
	Else 
		CM_SetupRelated(Self:C308->)
		
End case 