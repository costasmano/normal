// ----------------------------------------------------
// Object Method: PRJ_ConsultantReviewers_atxt
// User name (OS): cjmiller
// Date and time: 03/15/07, 12:51:25
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2006_CJMv2  //Make array names uniform
End if 
POPUPMENUC(->PRJ_ConsultantReviewers_atxt; ->PRJ_ConsultantReviewersID_al; ->[PRJ_ProjectTimeTracking:124]Person ID:3)

//End Object Method: PRJ_ConsultantReviewers_atxt