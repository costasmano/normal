//%attributes = {"invisible":true}
// ----------------------------------------------------
// PRJ_CheckForChanges
// User name (OS): cjmiller
// Date and time: 12/14/06, 12:57:16
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2006_CJMv2
End if 

If (ProjectChangesMade_b) | (Modified record:C314([PRJ_ProjectDetails:115]))
	ProjectChangesMade_b:=False:C215
	PRJ_SetProjectChangesMade(->[PRJ_ProjectDetails:115]; ->[PRJ_ProjectDetails:115]PRJ_ModifiedBy_s:46; ->[PRJ_ProjectDetails:115]PRJ_ModifiedTimeStamp_s:47; "val")
	SAVE RECORD:C53([PRJ_ProjectDetails:115])
	CONFIRM:C162("Project data has changed - Save changes? (Yes/No)"; "Yes"; "No")
	If (OK=1)
		PRJ_SaveProjectdata
		VALIDATE TRANSACTION:C240
	Else 
		CANCEL TRANSACTION:C241
	End if 
Else 
	CANCEL TRANSACTION:C241
End if 
//End PRJ_CheckForChanges