If (False:C215)
	// Modified by: costasmanousakis-(Designer)-(2/14/2006 14:58:15)
	Mods_2006_CM03
	// Modified by: costasmanousakis-(Designer)-(2/24/2006 12:51:30)
	Mods_2006_CM03
End if 
FORM SET INPUT:C55([DCM_WorkOrders:137]; "DistrMaintInput")
ADD RECORD:C56([DCM_WorkOrders:137])

DCM_AssignControl("RELATE")
DCM_AssignControl("INIT"; Records in selection:C76([DCM_WorkOrders:137]))
DCM_AssignControl("LOAD")

//CM_SetupRelated (Current form page)