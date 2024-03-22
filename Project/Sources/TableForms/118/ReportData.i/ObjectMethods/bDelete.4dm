// ----------------------------------------------------
// Object Method: bDelete
// User name (OS): cjmiller
// Date and time: 11/27/07, 15:25:56
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2007_CJM_v54  //r003 `11/27/07, 15:25:58
End if 
CONFIRM:C162("Are you sure you wish to delete this Report data record?"; "Yes"; "No")
If (OK=1)
	DELETE RECORD:C58([PRJ_ReportData:118])
	ProjectChangesMade_b:=True:C214
	CANCEL:C270
End if 
//End Object Method: bDelete