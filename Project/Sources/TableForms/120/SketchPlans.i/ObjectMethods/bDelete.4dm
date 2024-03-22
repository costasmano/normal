// ----------------------------------------------------
// Object Method: bDelete
// User name (OS): cjmiller
// Date and time: 11/27/07, 15:01:05
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2007_CJM_v54  //r003 `11/27/07, 15:01:07
End if 

CONFIRM:C162("Are you sure you wish to delete this Sketch Plan Review record?"; "Yes"; "No")
If (OK=1)
	DELETE RECORD:C58([PRJ_SketchPlans:120])
	ORDER BY:C49([PRJ_SketchPlans:120]; [PRJ_SketchPlans:120]SKT_SubmissionNumber_l:3; <)
	PRJ_LastReview_l:=[PRJ_SketchPlans:120]SKT_SubmissionNumber_l:3
	ProjectChangesMade_b:=True:C214
	CANCEL:C270
End if 
//End Object Method: bDelete