// ----------------------------------------------------
// Object Method: bValidate
// User name (OS): cjmiller
// Date and time: 01/26/06, 16:35:45
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// Modified by: costasmanousakis-(Designer)-(10/29/2007 08:51:46)
	Mods_2007_CM12_5302
	Mods_2008_CJM_v56  //r001 `06/12/08, 16:10:02   `Add update of last action date    
End if 
If (Is new record:C668([PRJ_SketchPlans:120]))
	PRJ_LastReview_l:=[PRJ_SketchPlans:120]SKT_SubmissionNumber_l:3
	PRJ_2ndAddSubRecord_b:=True:C214
End if 

PRJ_UpdateLastAction(Table name:C256(->[PRJ_SketchPlans:120]))

//End Object Method: bValidate