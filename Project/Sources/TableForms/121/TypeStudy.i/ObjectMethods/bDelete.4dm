// ----------------------------------------------------
// Object Method: bDelete
// User name (OS): cjmiller
// Date and time: 11/27/07, 14:55:29
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2007_CJM_v54  //r003 `11/27/07, 14:55:31
End if 

CONFIRM:C162("Are you sure you wish to delete this Type Study record?"; "Yes"; "No")
If (OK=1)
	DELETE RECORD:C58([PRJ_TypeStudy:121])
	ORDER BY:C49([PRJ_TypeStudy:121]; [PRJ_TypeStudy:121]TYP_Received_d:5; <)
	PRJ_LastReview_l:=[PRJ_TypeStudy:121]RV_ReviewID_l:2
	ProjectChangesMade_b:=True:C214
	CANCEL:C270
End if 
//End Object Method: bDelete