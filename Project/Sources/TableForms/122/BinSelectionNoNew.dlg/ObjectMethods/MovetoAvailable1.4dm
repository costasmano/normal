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
If (PRJ_UnassignedBins_atxt<1)
Else 
	C_TEXT:C284($Bin_s)  // Command Replaced was o_C_STRING length was 3
	$Bin_s:=Substring:C12(PRJ_UnassignedBins_atxt{PRJ_UnassignedBins_atxt}; 7; 3)
	
	If ($Bin_s=[PRJ_ProjectDetails:115]PRJ_PrimaryBin_s:34)
		ALERT:C41("You may not remove primary bin")
	Else 
		PRJ_MoveSelectedArray(->PRJ_UnassignedBins_atxt; ->PRJ_UnassignedBinRecordNos_al; ->PRJ_AvailableBins_atxt; ->PRJ_AvailableBinRecordNos_al)
		
		If (Size of array:C274(PRJ_AvailableBins_atxt)=0)
			OBJECT SET VISIBLE:C603(*; "Move@"; False:C215)
		Else 
			OBJECT SET VISIBLE:C603(*; "MovetoAssigned1@"; False:C215)
			OBJECT SET VISIBLE:C603(*; "MovetoAvailable1@"; False:C215)
		End if 
	End if 
End if 
//End Object Method:  Move_l