// ----------------------------------------------------
// Object Method: bValidate
// User name (OS): cjmiller
// Date and time: 01/26/06, 16:06:46
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// Modified by: costasmanousakis-(Designer)-(10/29/2007 08:55:39)
	Mods_2007_CM12_5302
	Mods_2008_CJM_v56  //r001 `06/12/08, 16:26:49   `Add update of last action date    
End if 
If (Is new record:C668([PRJ_StructuralReview:119]))
	PRJ_LastReview_l:=[PRJ_StructuralReview:119]SR_StructureReviewOrder_l:3
	PRJ_2ndAddSubRecord_b:=True:C214
End if 

PRJ_UpdateLastAction(Table name:C256(->[PRJ_StructuralReview:119]))

//End Object Method: bValidate