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
Case of 
	: (PRJ_UnassignedBins_atxt<1)
	: (Substring:C12(PRJ_UnassignedBins_atxt{PRJ_UnassignedBins_atxt}; 5; 3)=Substring:C12(PRJ_PrimaryBin_txt; 1; 3))
		ALERT:C41("You may not move primary bin")
	Else 
		PRJ_MoveSelectedArray(->PRJ_UnassignedBins_atxt; ->PRJ_UnassignedBinRecordNos_al; ->PRJ_UnassignedBinGroup_al; ->PRJ_AvailableBins_atxt; ->PRJ_AvailableBinRecordNos_al; ->PRJ_AvailableBinGroup_al)
		OBJECT SET VISIBLE:C603(*; "Move@"; False:C215)
		OBJECT SET VISIBLE:C603(*; "MoveAllToUnassigned1@"; True:C214)
End case 
//End Object Method:  Move_l