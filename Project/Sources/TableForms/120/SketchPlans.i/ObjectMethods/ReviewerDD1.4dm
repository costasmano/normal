// ----------------------------------------------------
// Object Method: PRJ_StructReviewers_atxt
// User name (OS): cjmiller
// Date and time: 01/26/06, 11:56:32
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2006_CJMv2  //03/15/07, 12:37:25  `Change name from Reviewers to StructReviewers
End if 
If (Form event code:C388=On Clicked:K2:4)
	PRJ_ControlReviewerChange(->[PRJ_SketchPlans:120]RV_ReviewID_l:2; "Are you sure you wish to change the sketch plans person ")
	
End if 
//End Object Method: PRJ_StructReviewers_atxt