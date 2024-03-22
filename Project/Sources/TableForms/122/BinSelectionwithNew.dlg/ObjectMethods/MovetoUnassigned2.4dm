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
	
	PRJ_MoveSelectedArray(->PRJ_AvailableBins_atxt; ->PRJ_AvailableBinRecordNos_al; ->PRJ_AvailableBinGroup_al; ->PRJ_UnassignedBins_atxt; ->PRJ_UnassignedBinRecordNos_al; ->PRJ_UnassignedBinGroup_al)
	
	OBJECT SET VISIBLE:C603(*; "Move@"; False:C215)
	OBJECT SET VISIBLE:C603(*; "MoveAllToSelected1"; True:C214)
	If (Size of array:C274(PRJ_AvailableBins_atxt)=0)
		OBJECT SET VISIBLE:C603(*; "MoveAllToUnassigned1@"; False:C215)
	Else 
		OBJECT SET VISIBLE:C603(*; "MoveAllToUnassigned1@"; True:C214)
	End if 
End if 
//End Object Method: MoveToSelected_l