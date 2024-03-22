// ----------------------------------------------------
// Object Method: Move_l
// User name (OS): cjmiller
// Date and time: 04/19/05, 11:50:17
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2005_CJM03  //04/19/05, 13:54:39
	Mods_2007_CJM_v5310  //06/20/07 Fix so that if nothing selected, no errors
End if 
If (PRJ_NewSelectedBins_atxt<1)
Else 
	PRJ_MoveToAvailable(->PRJ_NewSelectedBins_atxt; ->PRJ_NewSelectedBinRecordNos_al; PRJ_NewSelectedBins_atxt)
	OBJECT SET VISIBLE:C603(*; "MoveFromNewButton"; False:C215)
End if 
//End Object Method:  Move_l