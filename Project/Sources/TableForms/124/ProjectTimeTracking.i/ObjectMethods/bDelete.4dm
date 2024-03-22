// ----------------------------------------------------
// Object Method: bDelete
// User name (OS): cjmiller
// Date and time: 11/27/07, 15:27:26
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2007_CJM_v54  //r003 `11/27/07, 15:29:27
End if 
CONFIRM:C162("Are you sure you wish to delete this Time tracking record?"; "Yes"; "No")
If (OK=1)
	DELETE RECORD:C58([PRJ_ProjectTimeTracking:124])
	ProjectChangesMade_b:=True:C214
	CANCEL:C270
End if 
//End Object Method: bDelete