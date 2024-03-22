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
	Mods_2008_v55  //r005 `04/28/08, 11:30:23     
End if 

If (PRJ_ExistSelectedBins_atxt<1)
Else 
	
	PRJ_MoveSelectedArray(->PRJ_ExistSelectedBins_atxt; ->PRJ_ExstSelectedBinRecordNos_al; ->PRJ_ExstSelectedBinGroup_al; ->PRJ_UnassignedBins_atxt; ->PRJ_UnassignedBinRecordNos_al; ->PRJ_UnassignedBinGroup_al)
	OBJECT SET VISIBLE:C603(*; "Move@"; False:C215)
	
	If (Size of array:C274(PRJ_AvailableBins_atxt)=0)
		OBJECT SET VISIBLE:C603(*; "MoveAllToUnassigned2@"; False:C215)
	Else 
		OBJECT SET VISIBLE:C603(*; "MoveAllToUnassigned2@"; True:C214)
	End if 
	OBJECT SET VISIBLE:C603(*; "MoveAllToSelected1@"; True:C214)
	PRJ_ExistSelected_txt:=""
End if 


//End Object Method:  Move_l