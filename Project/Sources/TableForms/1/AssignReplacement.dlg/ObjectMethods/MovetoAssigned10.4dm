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
	//Copied to Server on : 06/25/08, 12:03:53
End if 
If (PRJ_ExistSelectedBins_atxt<1)
Else 
	If (Substring:C12(PRJ_ExistSelectedBins_atxt{PRJ_ExistSelectedBins_atxt}; 1; 5)="Unass")
		PRJ_MoveSelectedArray(->PRJ_ExistSelectedBins_atxt; ->PRJ_ExstSelectedBinRecordNos_al; ->PRJ_ExstSelectedBinGroup_al; ->PRJ_UnassignedBins_atxt; ->PRJ_UnassignedBinRecordNos_al; ->PRJ_UnassignedBinGroup_al)
		OBJECT SET VISIBLE:C603(*; "Move@"; False:C215)
	Else 
		ALERT:C41("You may not move a previously assigned BIN")
	End if 
End if 
//End Object Method:  Move_l