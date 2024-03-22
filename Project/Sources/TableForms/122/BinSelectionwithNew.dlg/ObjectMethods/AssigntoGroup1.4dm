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

Case of 
	: (PRJ_UnassignedBins_atxt<1)
	: (GroupDD_as<1)
		ALERT:C41("You must select a group before moving from unassgned to assigned")
	Else 
		
		PRJ_MoveSelectedArray(->PRJ_UnassignedBins_atxt; ->PRJ_UnassignedBinRecordNos_al; ->PRJ_UnassignedBinGroup_al; ->PRJ_ExistSelectedBins_atxt; ->PRJ_ExstSelectedBinRecordNos_al; ->PRJ_ExstSelectedBinGroup_al)
		
		OBJECT SET VISIBLE:C603(*; "Move@"; False:C215)
		If (Size of array:C274(PRJ_AvailableBins_atxt)=0)
			OBJECT SET VISIBLE:C603(*; "MoveAllToUnassigned2@"; False:C215)
		Else 
			OBJECT SET VISIBLE:C603(*; "MoveAllToUnassigned2@"; True:C214)
		End if 
End case 
//End Object Method: MoveToSelected_l