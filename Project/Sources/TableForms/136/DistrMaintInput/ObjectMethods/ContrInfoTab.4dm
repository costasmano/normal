If (False:C215)
	// Modified by: costasmanousakis-(Designer)-(8/27/09 10:17:56)
	Mods_2009_08
End if 

RELATE MANY:C262([DCM_Contracts:136])
C_LONGINT:C283($pageNo_L)
$pageNo_L:=Self:C308->
Case of 
	: (Self:C308->{$pageNo_L}="General")
		//General tab
		
	: (Self:C308->{$pageNo_L}="Contract Summary")
		DCM_SetupRelated(Self:C308->)
		//G_MaintenanceCheckNegative 
		//G_MaintenanceCalculateTLFandDE 
	Else 
		DCM_SetupRelated(Self:C308->)
		
End case 