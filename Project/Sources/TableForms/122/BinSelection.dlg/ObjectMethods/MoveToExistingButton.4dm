// ----------------------------------------------------
// Object Method: MoveToSelected_l
// User name (OS): cjmiller
// Date and time: 04/19/05, 11:51:03
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2005_CJM03  //04/19/05, 13:54:23
	Mods_2007_CJM_v5310  //06/20/07 Fix so that if nothing selected, no errors
End if 
If (PRJ_AvailableBins_atxt<1)
Else 
	PRJ_MoveToSelected(->PRJ_ExistSelectedBins_atxt; ->PRJ_ExstSelectedBinRecordNos_al)
	OBJECT SET VISIBLE:C603(*; "Move@"; False:C215)
End if 
//End Object Method: MoveToSelected_l