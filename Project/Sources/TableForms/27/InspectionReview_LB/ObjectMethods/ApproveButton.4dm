If (False:C215)
	Mods_2005_CM05
	// Modified by: costasmanousakis-(Designer)-(10/17/11 11:01:43)
	Mods_2011_10
	//  `test of G_Insp_ApproveReject_new
End if 
C_BOOLEAN:C305(INSP_TESTING_B)
If (INSP_TESTING_B)
	G_Insp_ApproveReject_new
Else 
	G_Insp_ApproveReject
End if 
UNLOAD RECORD:C212([Inspections:27])